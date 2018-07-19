<?php

namespace app\api\controller;

use app\admin\model\Ban;
use app\common\controller\Api;
use app\common\library\BuexLib;
use app\common\library\GateLib;

class Order extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = '*';

    private $gateLib;
    private $bcexLib;

    public function __construct()
    {
        parent::__construct();
        $this->gateLib = new GateLib();
        $this->bcexLib = new BuexLib();
    }

    public function order(){
        $list = ['tnc', 'pst','eos','bu', 'ont', 'nkn', 'rating', 'hsc', 'sop'];
        foreach ($list as $key=>$value){
            $this->per_order($value);
        }
        return json('success');
    }

    /**
     * $symbol = ont | hsc
     *  order_status:1代表没有差价，2代表有差价，差价不足，3代表数量不够，4代表网络异常，不能成功下单，5代表成功下单
     * @param string $symbol
     * @return \think\response\Json
     */
    public function per_order($symbol = 'pst')
    {
        $data = array_merge($this->bcexLib->get_ask_bid($symbol), $this->gateLib->get_ask_bid($symbol));
        $data['symbol'] = $symbol;
        $data['order_status'] = 1;
        if ($data['gate_ask_price'] < $data['bcex_bid_price']) { // 此时去gate买，去bcex卖
            $data['order_status'] = 2;
            $order_count = min($data['gate_ask_count'], $data['bcex_bid_count']);
            $data['remark'] = $symbol . '可下单:' . $order_count . '个,bcex_bid 买方比 gate 卖方多' . ((round($data['bcex_bid_price'] / $data['gate_ask_price'], 4) - 1) * 100) . '%';
//            $data = array_merge($data, order_gate_bcex($symbol,1, $order_count, $data['gate_ask_price'], $data['bcex_bid_price']));
        } else if ($data['bcex_ask_price'] < $data['gate_bid_price']) {
            $data['order_status'] = 2;
            $order_count = min($data['bcex_ask_count'], $data['gate_bid_count']);
            $data['remark'] = $symbol . '可下单:' . $order_count . '个,gate_bid 买方比 bcex 卖方多' . ((round($data['gate_bid_price'] / $data['bcex_ask_price'], 4) - 1) * 100) . '%';
//            $data = array_merge($data, order_gate_bcex($symbol,2, $order_count, $data['bcex_ask_price'], $data['gate_bid_price']));
        }
        $model = new Ban();
        $model->allowField(true)->save($data);
        return json(['data' => $data]);
    }


    /**
     * tnc pst eos bu ont nkn rating hsc sop
     */
    public function get_pairs()
    {
        $data = $this->gateLib->get_pairs();
        $gate_pair = [];
        foreach ($data as $key => $value) {
            $arr = explode('_', $value);
            if (count($arr) === 2 && $arr[1]==='ETH') {
                $gate_pair[] = strtolower($arr[0]);
            }
        }

        $data = $this->bcexLib->get_pairs();
        $bcex_pair = [];
        foreach ($data as $key => $value) {
            $arr = explode('_', $value);
            if (count($arr) === 2) {
                $bcex_pair[] = strtolower($arr[0]);
            }
        }

        $data = [];
        foreach ($gate_pair as $key=>$value){
            foreach ($bcex_pair as $k=>$v){
                if($value===$v){
                    $data[] = $value;
                }
            }
        }
        return json($data);
    }


}

























