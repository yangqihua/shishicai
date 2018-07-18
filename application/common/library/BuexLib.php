<?php

namespace app\common\library;



use app\common\model\Config;
use fast\Http;

class BuexLib
{

    private $key ;
    private $secret;

    public function __construct()
    {
        $config = new Config();
        $keyResult = $config->where("name", "key")->find();
        $this->key = $keyResult['value'];

        $keyResult = $config->where("name", "secret")->find();
        $this->secret = $keyResult['value'];
    }

    // bcex 账户
    public function bcex_user_balance(){
        $url = 'https://www.bcex.top/Api_User/userBalance';
        $config = new Config();
        $keyResult = $config->where("name", "bcex_pub")->find();
        $bcex_pub = $keyResult['value'];
        $keyResult = $config->where("name", "bcex_pri")->find();
        $bcex_pri = $keyResult['value'];
        $params = [
            'api_key' => $bcex_pub,
            'sign' => md5('api_key=' . $bcex_pub . '&secret_key=' . $bcex_pri),
        ];
        $result = json_decode(Http::post($url, $params),true);
        $data = [];
        foreach($result['data'] as $key => $value){
            $temp = num_format($value,8);
            if($temp != '0.00000000'){
                $data[$key]=num_format($value,4);
            }
        }
        return $data;
    }

}
