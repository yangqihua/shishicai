<?php

namespace app\api\controller\milltor;

use app\common\controller\Api;

class Milltor extends Api
{

    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];
    private $receiver_address = '904693433@qq.com';

    public function send_mail()
    {
        $name = input('name', 'no name');
        $email = input('email', 'no email');
        $subject = input('subject', 'no subject');
        $message = $name . '的邮箱: ' . $email . '，发来信息: ' . input('message', 'no message');
        $data = sendMail($this->receiver_address, $message, $subject);
//        $data = ['code'=>200,'message'=>'success'];
        $this->success($data);
    }
}
