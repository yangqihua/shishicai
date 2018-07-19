<?php

namespace app\common\library;


use app\common\model\Config;
use fast\Http;

class BuexLib
{

    private $key;
    private $secret;

    public function __construct()
    {
        $config = new Config();
        $keyResult = $config->where("name", "bcex_pub")->find();
        $this->key = $keyResult['value'];
        $keyResult = $config->where("name", "bcex_pri")->find();
        $this->secret = $keyResult['value'];
    }


    /**
     * @param $symbol = rating2eth
     * @param $type = sale | buy
     * @param $price
     * @param $count
     * @return mixed|string
     */
    public function order($symbol, $type, $price, $count)
    {
        $symbol = $symbol.'2eth';
        $url = 'https://www.bcex.top/Api_Order/coinTrust';
        $params = [
            'api_key' => $this->key,
            'symbol' => $symbol,
            'type' => $type,
            'price' => $price,
            'number' => $count,
            'sign' => md5('api_key=' . $this->key . '&number=' . $count . '&price=' . $price . '&symbol=' . $symbol . '&type=' . $type . '&secret_key=' . $this->secret),
        ];
        $result = Http::post($url, $params);
        return $result;
    }

    public function get_ask_bid($symbol)
    {
        $symbol = $symbol.'2eth';
        $url = 'https://www.bcex.top/Api_Order/depth';
        $json = Http::post($url, ['symbol' => $symbol]);
        $tryCount = 1;
        while (!$json && $tryCount++ < 5) {
            $json = Http::post($url, ['symbol' => 'rating2eth']);
        }
        $bcexResult = json_decode($json, true);
        $bcexAsks1 = $bcexResult['data']['asks'][count($bcexResult['data']['asks']) - 1]; // 卖1
        $bcexBids1 = $bcexResult['data']['bids'][0];  // 买1
        $bask = num_format($bcexAsks1[0]) . ',' . $bcexAsks1[1];
        $bbid = num_format($bcexBids1[0]) . ',' . $bcexBids1[1];
        return [
            'bcex_ask' => $bask,
            'bcex_bid' => $bbid,
            'bcex_ask_price' => num_format($bcexAsks1[0]),
            'bcex_ask_count' => $bcexAsks1[1],
            'bcex_bid_price' => num_format($bcexBids1[0]),
            'bcex_bid_count' => $bcexBids1[1],
        ];
    }

    // bcex 账户
    public function bcex_user_balance()
    {
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
        $result = json_decode(Http::post($url, $params), true);
        $data = [];
        foreach ($result['data'] as $key => $value) {
            $temp = num_format($value, 8);
            if ($temp != '0.00000000') {
                $data[$key] = num_format($value, 4);
            }
        }
        return $data;
    }

}
