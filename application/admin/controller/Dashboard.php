<?php

namespace app\admin\controller;

use app\admin\model\PkHuihe;
use app\common\controller\Backend;
use think\Config;

/**
 * 控制台
 *
 * @icon fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard extends Backend
{

    private $huiheMap = ['yi' => '冠军', 'er' => '亚军', 'san' => '第三名', 'si' => '第四名', 'wu' => '第五名', 'liu' => '第六名', 'qi' => '第七名', 'ba' => '第八名', 'jiu' => '第九名', 'shi' => '第十名',];
    /**
     * 查看
     */
    public function index()
    {

        $resultList = [];
        $huiheModel = new PkHuihe();
        $dataList = $huiheModel->select();
        foreach ($dataList as $key => $item){
            $qiString = $item['qihaos'];
            $qihaoArr = explode(',',$qiString);
            $resultItem = [];
            for($i=0;$i<count($qihaoArr);$i++){
                $qihao = preg_replace('/\(.*?\)/', '', $qihaoArr[$i]);
                $resultList[$qihao][$item['wei']][$item['type']] = $i+1;
            }
//            $resultList[] = $resultItem;
        }
        $this->view->assign(['resultList'=>$resultList]);
        return $this->view->fetch();
    }

}
