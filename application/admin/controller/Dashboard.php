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
    private $huiheMap = ['yi' => '冠军', 'er' => '亚军', 'san' => '第三名', 'si' => '第四名', 'wu' => '第五名', 'liu' => '第六名', 'qi' => '第七名', 'ba' => '第八名', 'jiu' => '第九名', 'shi' => '第十名',];
    /**
     * 查看
     */
    public function index()
    {

        $resultList = [];
//        $huiheModel = new PkHuihe();
//        $dataList = $huiheModel->select();
//        foreach ($dataList as $key => $item){
//            $qiString = $item['qihaos'];
//            $qihaoArr = explode(',',$qiString);
//            for($i=0;$i<count($qihaoArr);$i++){
//                $qihao = preg_replace('/\(.*?\)/', '', $qihaoArr[$i]);
//                $resultList[$qihao][$item['wei']][$item['type']] = $i+1;
//            }
//        }


        $data = $this->get_one_day();
        $this->view->assign(['resultList'=>$resultList,'reward'=>$data]);
        return $this->view->fetch();
    }


    public function get_one_day()
    {
        $result = [];

        $fmt = "'%Y-%m-%d %H'";

        $sql = "SELECT FROM_UNIXTIME(createtime, $fmt) as create_time,count(FROM_UNIXTIME(createtime, $fmt)) as total FROM shishicai.pk_huihe group by create_time;";
        $res = Db::query($sql);
        foreach ($res as $row) {
            $result[$row['create_time']] = ['total_num' => $row['total']];
        }

        $sql = "SELECT FROM_UNIXTIME(createtime, $fmt) as create_time,count(FROM_UNIXTIME(createtime,$fmt)) as total,repeat_num FROM shishicai.pk_huihe where repeat_num=1 group by create_time,repeat_num;";
        $res = Db::query($sql);
        $total_reward = 0;
        foreach ($res as $row) {
            $result[$row['create_time']]['yi_num'] = $row['total'];
            $result[$row['create_time']]['reward'] = $row['total'] * 2 * $this->rate - $result[$row['create_time']]['total_num'];
            $total_reward += $row['total'] * 2 * $this->rate - $result[$row['create_time']]['total_num'];
        }
        $data['result'] = $result;
        $data['total_reward'] = $total_reward;
        return $data;
    }

}
