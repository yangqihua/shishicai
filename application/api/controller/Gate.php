<?php

namespace app\api\controller;

use app\admin\model\Block;
use app\admin\model\GateOrder;
use app\admin\model\Market;
use app\admin\model\Zhuan;
use app\common\controller\Api;
use app\common\library\GateLib;
use app\common\model\Config;
use fast\Http;

class Gate extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = '*';

    private $gateLib;
    private $marketModel;

    public function __construct()
    {
        parent::__construct();
        $this->gateLib = new GateLib();
        $this->marketModel = new Market();
    }

    public function _initialize()
    {
        parent::_initialize();
    }

    public function ban_zhuan()
    {
        $data = array_merge($this->get_bcex_ask_bid(), $this->get_gate_ask_bid());
        if ($data['gate_ask_price'] < $data['bcex_bid_price']) { // 此时去gate买，去bcex卖
            $order_count = min($data['gate_ask_count'], $data['bcex_bid_count']);
            $data['remark'] = '可下单:'.$order_count.'个,bcex_bid 买方比 gate 卖方多' . ((round($data['bcex_bid_price'] / $data['gate_ask_price'], 4) - 1) * 100) . '%';
            $data = array_merge($data,$this->order_gate_bcex(1, $order_count, $data['gate_ask_price'], $data['bcex_bid_price']));
        } else if ($data['bcex_ask_price'] < $data['gate_bid_price']) {
            $order_count = min($data['bcex_ask_count'], $data['gate_bid_count']);
            $data['remark'] = '可下单:'.$order_count.'个,gate_bid 买方比 bcex 卖方多' . ((round($data['gate_bid_price'] / $data['bcex_ask_price'], 4) - 1) * 100) . '%';
            $data = array_merge($data,$this->order_gate_bcex(2, $order_count, $data['bcex_ask_price'], $data['gate_bid_price']));
        }
        $zhuanModel = new Zhuan();
        $zhuanModel->allowField(true)->save($data);
        return json(['data' => $data]);
    }

    // type :1 代表gate买，bcex卖，2反之
    private function order_gate_bcex($type, $count, $buy_price, $sell_price)
    {
        $data = ['get_eth'=>0,'order_result'=>'','order_count'=>''];
        $percent = round($sell_price / $buy_price, 4) - 1;
        if ($percent < 0.023) {
            $order_result = '买卖比例: ' . $percent . '小于0.023，不能下单';
            trace($order_result, 'error');
            $data['order_result'] = $order_result;
            return $data;
        }
        if ($count < 500) {
            $order_result = '下单数量: ' . $count . '小于500，不能下单';
            trace($order_result, 'error');
            $data['order_result'] = $order_result;
            return $data;
        }
        if ($percent < 0.03) {
            $count = min($count, 6000);
        } else if ($percent > 0.05) {
            $count = min($count, 10000);
        }

        // gate 买，bcex卖
        if ($type === 1) {
            $tryCount = 1;
            $bcexRes = $this->order_bcex('sale', $sell_price, $count);
            while (!$bcexRes && $tryCount++ < 5) {
                $bcexRes = $this->order_bcex('sale', $sell_price, $count);
            }
            $bRes = json_decode($bcexRes, true,JSON_UNESCAPED_UNICODE);
            if ($bcexRes && is_array($bRes) && $bRes['code'] == 0) {
                $gateRes = json_encode($this->gateLib->buy('rating_eth', $buy_price, $count));
                $order_result = 'bcex下单结果：' . $bcexRes . ',gate下单结果：' . $gateRes;
                trace($order_result, 'error');
                $data['get_eth'] = $count * ($sell_price - $buy_price);
                $data['order_result'] = $order_result;
                $data['order_count'] = $count;
            }
        } else {
            $tryCount = 1;
            $bcexRes = $this->order_bcex('buy', $buy_price, $count);
            while (!$bcexRes && $tryCount++ < 5) {
                $bcexRes = $this->order_bcex('buy', $buy_price, $count);
            }
            $bRes = json_decode($bcexRes, true,JSON_UNESCAPED_UNICODE);
            if ($bcexRes && is_array($bRes) && $bRes['code'] == 0) {
                $gateRes = json_encode($this->gateLib->sell('rating_eth', $sell_price, $count));
                $order_result = 'bcex下单结果：' . $bcexRes . ',gate下单结果：' . $gateRes;
                trace($order_result, 'error');
                $data['get_eth'] = $count * ($sell_price - $buy_price);
                $data['order_result'] = $order_result;
                $data['order_count'] = $count;
            }
        }
        return $data;
    }

    private function order_bcex($type, $price, $number)
    {
        $url = 'https://www.bcex.top/Api_Order/coinTrust';
        $config = new Config();
        $keyResult = $config->where("name", "bcex_pub")->find();
        $bcex_pub = $keyResult['value'];
        $keyResult = $config->where("name", "bcex_pri")->find();
        $bcex_pri = $keyResult['value'];
        $params = [
            'api_key' => $bcex_pub,
            'symbol' => 'rating2eth',
            'type' => $type,
            'price' => $price,
            'number' => $number,
            'sign' => md5('api_key=' . $bcex_pub . '&number=' . $number . '&price=' . $price . '&symbol=rating2eth&type=' . $type . '&secret_key=' . $bcex_pri),
        ];
        $result = Http::post($url, $params);
        return $result;
    }

    private function get_gate_ask_bid()
    {
        $gateResult = $this->gateLib->get_orderbook('rating_eth');
        $gateAsks1 = $gateResult['asks'][count($gateResult['asks']) - 1]; // 卖1
        $gateBids1 = $gateResult['bids'][0];  // 买1
        $gask = $this->num($gateAsks1[0]) . ',' . $gateAsks1[1];
        $gbid = $this->num($gateBids1[0]) . ',' . $gateBids1[1];
        return [
            'gate_ask' => $gask, 'gate_bid' => $gbid,
            'gate_ask_price' => $this->num($gateAsks1[0]), 'gate_ask_count' => $gateAsks1[1],
            'gate_bid_price' => $this->num($gateBids1[0]), 'gate_bid_count' => $gateBids1[1],
        ];
    }

    private function get_bcex_ask_bid()
    {
        $url = 'https://www.bcex.top/Api_Order/depth';
        $json = Http::post($url, ['symbol' => 'rating2eth']);
        $tryCount = 1;
        while (!$json && $tryCount++ < 5) {
            $json = Http::post($url, ['symbol' => 'rating2eth']);
        }
        $bcexResult = json_decode($json, true);
        $bcexAsks1 = $bcexResult['data']['asks'][count($bcexResult['data']['asks']) - 1]; // 卖1
        $bcexBids1 = $bcexResult['data']['bids'][0];  // 买1
        $bask = $this->num($bcexAsks1[0]) . ',' . $bcexAsks1[1];
        $bbid = $this->num($bcexBids1[0]) . ',' . $bcexBids1[1];
        return [
            'bcex_ask' => $bask, 'bcex_bid' => $bbid,
            'bcex_ask_price' => $this->num($bcexAsks1[0]), 'bcex_ask_count' => $bcexAsks1[1],
            'bcex_bid_price' => $this->num($bcexBids1[0]), 'bcex_bid_count' => $bcexBids1[1],
        ];
    }

    public function get_ticker()
    {
        $result = $this->gateLib->get_ticker('rating_usdt');
        $data = [
            'quote_volume' => $result['quoteVolume'],
            'base_volume' => $result['baseVolume'],
            'highest_bid' => $result['highestBid'],
            'high24hr' => $result['high24hr'],
            'last' => $result['last'],
            'lowest_ask' => $result['lowestAsk'],
            'elapsed' => $result['elapsed'],
            'result' => $result['result'],
            'low24hr' => $result['low24hr'],
            'percent_change' => $result['percentChange'],
            'createtime' => time()
        ];

        $latest = $this->marketModel->order('id desc')->limit(30)->select();
        $total = 0;
        foreach ($latest as $item) {
            $total += $item['last'];
        }
        $av = $total / count($latest);
        trace('平均价格：' . $av . ',当前价格：' . $data['last'], 'error');
        if ($data['last'] < $av) {
            $result = $this->gateLib->open_orders('rating_usdt');
            if (count($result['orders']) < 20) {
                // 就可以下单买卖了
                $buyRate = $data['last'];
                $saleRate = $data['last'] * (1 + rand(1, 3) / 100);
                $amount = 800;
                $buyRes = $this->gateLib->buy('rating_usdt', $buyRate, $amount);
                $sellRes = $this->gateLib->sell('rating_usdt', $saleRate, $amount);
                trace('买入价格：' . $buyRate . ',卖出价格：' . $saleRate, 'error');
                $gateOrder = [
                    'buy_rate' => $buyRate, 'sell_rate' => $saleRate,
                    'order_count' => $amount,
                    'sell_order_number' => $sellRes['orderNumber'],
                    'buy_order_number' => $buyRes['orderNumber'],
                    'order_status' => '未成交',
                ];
                $gateModel = new GateOrder();
                $gateModel->save($gateOrder);
            }
        }
        $this->marketModel->save($data);
        return json(['data' => 'ok']);
    }


    public function get_uex_and_gate()
    {
//        return json(['data'=>$result]);
    }

    public function get_block()
    {
        $url = 'https://data.block.cc/api/v1/tickers?symbol=rating';
        $result = json_decode(Http::get($url), true, 512, JSON_ERROR_CTRL_CHAR);
        $data = [];
        foreach ($result['data']['list'] as $item) {
            if ($item['symbol_pair'] == 'RATING_ETH') {
                if ($item['market'] == 'gate-io') {
                    $data['update_stamps'] = $item['timestamps'];
                    $data['gate_last'] = $this->num($item['last']);
                    $data['gate_bid'] = $this->num($item['bid']);
                    $data['gate_ask'] = $this->num($item['ask']);
                    $data['gate_high'] = $this->num($item['high']);
                    $data['gate_low'] = $this->num($item['low']);
                    $data['gate_vol'] = $item['vol'];  //24小时交易货币交易量
                    $data['gate_base_volume'] = $item['base_volume'];
                    $data['gate_change_daily'] = $item['change_daily'];
                } else if ($item['market'] == 'bcex') {
                    $data['bcex_last'] = $this->num($item['last']);
                    $data['bcex_bid'] = $this->num($item['bid']);
                    $data['bcex_ask'] = $this->num($item['ask']);
                    $data['bcex_high'] = $this->num($item['high']);
                    $data['bcex_low'] = $this->num($item['low']);
                    $data['bcex_vol'] = $item['vol'];  //24小时交易货币交易量
                    $data['bcex_base_volume'] = $item['base_volume'];
                    $data['bcex_change_daily'] = $item['change_daily'];
                } else if ($item['market'] == 'uex') {
                    $data['uex_last'] = $this->num($item['last']);
                } else if ($item['market'] == 'coinoah') {
                    $data['coinoah_last'] = $this->num($item['last']);
                } else if ($item['market'] == 'hotbit') {
                    $data['hotbit_last'] = $this->num($item['last']);
                }
            }
        }
        $model = new Block();
        $model->save($data);
        return json(['data' => 'success']);
    }


    private function num($num, $double = 8)
    {
        if (false !== stripos($num, "e")) {
            $a = explode("e", strtolower($num));
            return bcmul($a[0], bcpow(10, $a[1], $double), $double);
        } else {
            return $num;
        }
    }


}

























