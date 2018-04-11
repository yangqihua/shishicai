<?php

namespace app\api\controller\milltor;

use app\common\controller\Api;

class Milltor extends Api
{

    private $receiver_address = '904693433@qq.com';

    public function send_mail()
    {
        $name = input('name', 'no name');
        $email = input('email', 'no email');
        $subject = input('email', 'no subject');
        $message = $name . '的邮箱: ' . $email . '，发来信息: ' . input('email', 'no message');
//        $data = sendMail($this->receiver_address, $message, $subject);
        $data = ['code'=>200,'message'=>'success'];
        $this->success($data);
    }
}
