<?php

namespace app\api\controller;

use app\admin\model\Market;
use app\common\controller\Api;
use app\common\library\GateLib;

class Gate extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = '*';

    private $gateLib;
    private $marketModel;

    public function __construct(){
        parent::__construct();
        $this->gateLib = new GateLib();
        $this->marketModel = new Market();
    }

    public function _initialize()
    {
        parent::_initialize();
    }

    public function get_ticker(){
        $result = $this->gateLib->get_ticker('rating_usdt');
        $data = [
            'quote_volume'=>$result['quoteVolume'],
            'base_volume'=>$result['baseVolume'],
            'highest_bid'=>$result['highestBid'],
            'high24hr'=>$result['high24hr'],
            'last'=>$result['last'],
            'lowest_ask'=>$result['lowestAsk'],
            'elapsed'=>$result['elapsed'],
            'result'=>$result['result'],
            'low24hr'=>$result['low24hr'],
            'percent_change'=>$result['percentChange'],
            'createtime'=>time()
            ];
        $this->marketModel->save($data);
        return json(['data'=>'ok']);
    }


}
