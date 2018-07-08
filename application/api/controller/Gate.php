<?php

namespace app\api\controller;

use app\admin\model\Block;
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


    public function get_uex_and_gate(){
        $sign = md5('country86mobile18428360735passwordyqh199411211time'.time());
        $url = '/open/api/get_ticker?symbol=rating&sign='.$sign;
        $result = Http::get($url);
        return json(['data'=>$result]);
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
                }else if ($item['market'] == 'coinoah') {
                    $data['coinoah_last'] = $this->num($item['last']);
                }else if ($item['market'] == 'hotbit') {
                    $data['hotbit_last'] = $this->num($item['last']);
                }
            }
        }
        $model = new Block();
        $model->save($data);
        return json(['data' => 'success']);
    }


    private function num($num, $double = 8){
        if(false !== stripos($num, "e")){
            $a = explode("e",strtolower($num));
            return bcmul($a[0], bcpow(10, $a[1], $double), $double);
        }
    }



}

























