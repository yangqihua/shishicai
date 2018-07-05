<?php

namespace app\api\controller;

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
        $this->marketModel->save($data);
        return json(['data' => 'ok']);
    }

    public function get_block()
    {
        $url = 'https://data.block.cc/api/v1/tickers?symbol=rating';
        $result = json_decode(Http::get($url), true);
        $data = [];
        foreach ($result as $item) {
            if ($item['symbol_pair'] == 'RATING_ETH') {
                if ($item['market'] == 'gate-io') {
                    $data['update_stamps'] = $item['timestamps'];
                    $data['gate_last'] = $item['last'];
                    $data['gate_bid'] = $item['bid'];
                    $data['gate_ask'] = $item['ask'];
                    $data['gate_high'] = $item['high'];
                    $data['gate_low'] = $item['low'];
                    $data['gate_vol'] = $item['vol'];  //24小时交易货币交易量
                    $data['gate_base_volume'] = $item['base_volume'];
                    $data['gate_change_daily'] = $item['change_daily'];
                } else if ($item['market'] == 'bcex') {
                    $data['bcex_last'] = $item['last'];
                    $data['bcex_bid'] = $item['bid'];
                    $data['bcex_ask'] = $item['ask'];
                    $data['bcex_high'] = $item['high'];
                    $data['bcex_low'] = $item['low'];
                    $data['bcex_vol'] = $item['vol'];  //24小时交易货币交易量
                    $data['bcex_base_volume'] = $item['base_volume'];
                    $data['bcex_change_daily'] = $item['change_daily'];
                }
            }
        }
        return json(['data' => $result]);
    }


}

























