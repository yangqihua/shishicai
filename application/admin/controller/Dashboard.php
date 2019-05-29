<?php

namespace app\admin\controller;

use app\admin\model\PkHuihe;
use app\common\controller\Backend;
use think\Config;
use think\Db;

/**
 * 控制台
 *
 * @icon fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard extends Backend
{

    protected $rate = 0.995;
    /**
     * 查看
     */
    public function index()
    {

        $result = Db::table('balance')->select();
        $balanceList['eth_rate'] = $result[0]['money']/$result[0]['total_eth'];
        $balanceList['rating_rate'] = $result[0]['money']/$result[0]['total_rating'];
        $balanceList['cur_eth_rate'] = $result[0]['money']/($result[0]['eth']+num_format($result[0]['locked_rating']*$result[0]['rating_price'],4));
        $balanceList['cur_rating_rate'] = $result[0]['money']/($result[0]['rating']+num_format($result[0]['locked_eth']/$result[0]['rating_price'],4));
        foreach ($result as $item){
            $balanceList['time'][] = datetime($item['createtime']);
            $balanceList['money'][] = $item['money'];
            $balanceList['eth'][] = $item['total_eth']*$balanceList['eth_rate'];
            $balanceList['rating'][] = $item['total_rating']*$balanceList['rating_rate'];
            $balanceList['cur_eth'][] = ($item['eth']+num_format($item['locked_rating']*$item['rating_price'],4))*$balanceList['cur_eth_rate'];
            $balanceList['cur_rating'][] = ($item['rating']+num_format($item['locked_eth']/$item['rating_price'],4))*$balanceList['cur_rating_rate'];
        }


        $result = Db::table('block')->column('createtime,gate_last,bcex_last,uex_last,coinoah_last,hotbit_last')->limit(1000);
        $marketList = [];
        foreach ($result as $item){
            $marketList['time'][] = date('Y-m-d H:i:s',$item['createtime']);
            $marketList['gate'][] = $item['gate_last'];
            $marketList['bcex'][] = $item['bcex_last'];
            $marketList['uex'][] = $item['uex_last'];
            $marketList['coinoah'][] = $item['coinoah_last'];
            $marketList['hotbit'][] = $item['hotbit_last'];
        }
        $this->view->assign(['marketList'=>$marketList,'balanceList'=>$balanceList]);
        return $this->view->fetch();
    }

}
