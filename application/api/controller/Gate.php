<?php

namespace app\api\controller;

use app\admin\model\Block;
use app\admin\model\GateOrder;
use app\admin\model\Market;
use app\common\controller\Api;
use app\common\library\GateLib;
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
        }
    }


}

























