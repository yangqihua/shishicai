<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\Config;
use fast\Http;

class Nas extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = '*';

    public function __construct()
    {
        parent::__construct();
    }

    public function _initialize()
    {
        parent::_initialize();
    }


    public function ban_uex()
    {
    }

}

























