<?php

namespace app\admin\controller\pk;

use app\common\controller\Backend;

/**
 * 北京pk回合记录
 *
 * @icon fa fa-circle-o
 */
class Huihe extends Backend
{
    
    /**
     * PkHuihe模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('PkHuihe');

    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    

}