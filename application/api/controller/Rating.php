<?php

namespace app\api\controller;

use app\admin\model\Balance;
use app\admin\model\Block;
use app\admin\model\GateOrder;
use app\admin\model\Market;
use app\admin\model\Uex;
use app\admin\model\Zhuan;
use app\common\controller\Api;
use app\common\library\BuexLib;
use app\common\library\GateLib;
use app\common\model\Config;
use fast\Http;

class Rating extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = '*';

    private $gateLib;
    private $buexLib;

    public function __construct()
    {
        parent::__construct();
        $this->gateLib = new GateLib();
        $this->buexLib = new BuexLib();
    }

    public function _initialize()
    {
        parent::_initialize();
    }


    public function get_balance(){
        $eth_ticker = $this->gateLib->get_ticker('eth_usdt');
        $rating_ticker = $this->gateLib->get_ticker('rating_eth');
        $data['eth_price'] = $eth_ticker['last']*6.67;
        $data['rating_price'] = $rating_ticker['last'];

        $gate_balance = $this->gateLib->get_balances();
        $buex_balance = $this->buexLib->bcex_user_balance();
        $data['eth'] = $gate_balance['available']['ETH']+$buex_balance['eth_over'];
        $data['locked_eth'] = $gate_balance['locked']['ETH']+$buex_balance['eth_lock'];
        $data['rating'] = $gate_balance['available']['RATING']+$buex_balance['rating_over'];
        $data['locked_rating'] = $gate_balance['locked']['RATING']+$buex_balance['rating_lock'];

        $data['money'] = num_format(($data['eth']+$data['locked_eth']+($data['rating']+$data['locked_rating'])*$data['rating_price'])
            *$data['eth_price'],2);

        $balanceModel = new Balance();
        $balanceModel->save($data);
        return json($data);
    }

    // bcex 挂单列表
    public function bcex_trade_list(){
        $url = 'https://www.bcex.top/Api_Order/tradeList';
        $config = new Config();
        $keyResult = $config->where("name", "bcex_pub")->find();
        $bcex_pub = $keyResult['value'];
        $keyResult = $config->where("name", "bcex_pri")->find();
        $bcex_pri = $keyResult['value'];
        $type = 'open';
        $params = [
            'api_key' => $bcex_pub,
            'symbol' => 'rating2eth',
            'type' => $type,
            'sign' => md5('api_key=' . $bcex_pub . '&symbol=rating2eth&type=' . $type . '&secret_key=' . $bcex_pri),
        ];
        $result = json_decode(Http::post($url, $params),true);
        $data = [];
        foreach ($result['data'] as $item){
            $data_item = [
                'id' => $item['id'],
                '时间'=>datetime($item['datetime']),
                '类型'=>($item['type']=='sale'?'卖出':'买入'),
                '价格'=>num_format($item['price']*10000000,2),
                '总数'=>num_format($item['amount'],2),
                '成交数'=>num_format($item['amount'] - $item['amount_outstanding'],2)
            ];
            $data[] = $data_item;
        }
        return json(['data'=>$data]);
    }

    // bcex 成交列表
    public function bcex_order_list(){
        $url = 'https://www.bcex.top/Api_Order/orderList';
        $config = new Config();
        $keyResult = $config->where("name", "bcex_pub")->find();
        $bcex_pub = $keyResult['value'];
        $keyResult = $config->where("name", "bcex_pri")->find();
        $bcex_pri = $keyResult['value'];
        $type = 'all';
        $params = [
            'api_key' => $bcex_pub,
            'symbol' => 'rating2eth',
            'type' => $type,
            'sign' => md5('api_key=' . $bcex_pub . '&symbol=rating2eth&type=' . $type . '&secret_key=' . $bcex_pri),
        ];
        $str = Http::post($url, $params);
        $result = json_decode($str,true);
        $data = [];
        foreach ($result['data'] as $item){
            $data_item = [
                'id' => $item['order_id'],
                '时间'=>datetime($item['created']),
                '类型'=>($item['side']=='sale'?'卖出':'买入'),
                '价格'=>num_format($item['price']*10000000,2),
                '成交数'=>num_format($item['number'],2)
            ];
            $data[] = $data_item;
        }
        return json(['data'=>$data]);
    }


    // gate 账户
    public function gate_user_balance(){
        $result = $this->gateLib->get_balances();
        return json(['data'=>$result]);
    }

    // gate 挂单列表
    public function gate_trade_list(){
        $result = $this->gateLib->open_orders('rating_eth');
        $data = [];
        foreach ($result['orders'] as $item){
            $data_item = [
                'id' => $item['orderNumber'],
                '时间'=>datetime($item['timestamp']),
                '类型'=>($item['type']=='buy'?'买入':'卖出'),
                '价格'=>num_format($item['rate']*10000000,2),
                '总数'=>num_format($item['amount'],2),
                '成交数'=>num_format($item['filledAmount'],2)
            ];
            $data[] = $data_item;
        }
        return json(['data'=>$data]);
    }

    // gate 成交列表
    public function gate_order_list(){
        $result = $this->gateLib->get_my_trade_history('rating_eth','');
        $data = [];
        foreach ($result['trades'] as $item){
            $data_item = [
                'id' => $item['tradeID'],
                '时间'=>$item['date'],
                '类型'=>($item['type']=='buy'?'买入':'卖出'),
                '价格'=>num_format($item['rate']*10000000,2),
                '成交数'=>num_format($item['amount'],2)
            ];
            $data[] = $data_item;
        }
        return json(['data'=>$data]);
    }



}

























