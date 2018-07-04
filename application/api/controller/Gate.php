<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\library\GateLib;

class Gate extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = '*';

    private $gateLib;

    public function __construct(){
        parent::__construct();
        $this->gateLib = new GateLib();
    }

    public function _initialize()
    {
        parent::_initialize();
    }

    public function get_ticker(){
        $result = $this->gateLib->get_ticker('rating_usdt');
        return json(['data'=>$result]);
    }


}
