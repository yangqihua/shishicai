<?php

namespace app\api\controller\cai;

use app\common\controller\Api;
use QL\QueryList;

/**
 * 首页接口
 */
class Pk10 extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    public function get_data($from = 1, $to = 10, $id = 5)
    {
        $ql = QueryList::getInstance();
        $url = 'https://m.jjcp.net/index.php/api/LotteryData/history';
        $data = ['page' => 1, 'id' => $id];
        $header = [
            'Host' => 'm.jjcp.net',
            'Origin' => 'https://m.jjcp.net',
            'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
            'Cookie' => 'PHPSESSID=ntsri95d4h9u04s745r3b3nkk4; PHPSESSID=ntsri95d4h9u04s745r3b3nkk4',
        ];
        $result = json_decode($ql->post($url, $data)->getHtml(),true);
        $this->success('', $result);
    }

    public function index()
    {
        $this->success('请求成功');
    }

}
