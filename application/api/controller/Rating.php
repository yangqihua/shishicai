<?php

namespace app\api\controller;

use app\admin\model\Block;
use app\admin\model\GateOrder;
use app\admin\model\Market;
use app\admin\model\Uex;
use app\admin\model\Zhuan;
use app\common\controller\Api;
use app\common\library\GateLib;
use app\common\model\Config;
use fast\Http;

class Rating extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = '*';

    private $gateLib;
    private $marketModel;

    private $diffPrice = 0.00000002;

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


    // bcex 账户
    public function bcex_user_balance(){
        $url = 'https://www.bcex.top/Api_User/userBalance';
        $config = new Config();
        $keyResult = $config->where("name", "bcex_pub")->find();
        $bcex_pub = $keyResult['value'];
        $keyResult = $config->where("name", "bcex_pri")->find();
        $bcex_pri = $keyResult['value'];
        $params = [
            'api_key' => $bcex_pub,
            'sign' => md5('api_key=' . $bcex_pub . '&secret_key=' . $bcex_pri),
        ];
        $result = Http::post($url, $params);
        return $result;
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
        $result = Http::post($url, $params);
        return $result;
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
        $result = Http::post($url, $params);
        return $result;
    }




    private function num($num, $double = 8)
    {
        if (false !== stripos($num, "e")) {
            $a = explode("e", strtolower($num));
            return bcmul($a[0], bcpow(10, $a[1], $double), $double);
        } else {
            return round($num, $double);
        }
    }


}

























