<?php
use app\common\library\BuexLib;
use app\common\library\GateLib;


/**
 * @param $symbol = rating
 * @param $type = 1 gate 买，bcex卖
 * @param $count
 * @param $buy_price
 * @param $sell_price
 * @return array
 */
function order_gate_bcex($symbol, $type, $count, $buy_price, $sell_price)
{
    $gate_symbol = $symbol . '_eth';
    $gateLib = new GateLib();
    $bcexLib = new BuexLib();
    $data = ['get_eth' => 0, 'order_result' => '', 'order_count' => '', 'order_status' => 4];
    $percent = round($sell_price / $buy_price, 4) - 1;
    if ($percent < 0.020) {
        $order_result = $symbol . '买卖比例: ' . $percent . '小于0.020，不能下单';
        trace($order_result, 'error');
        $data['order_result'] = $order_result;
        $data['order_status'] = 2;
        return $data;
    }
    if ($count < 500) {
        $order_result = $symbol . '下单数量: ' . $count . '小于500，不能下单';
        trace($order_result, 'error');
        $data['order_result'] = $order_result;
        $data['order_status'] = 3;
        return $data;
    }
    if ($percent < 0.03) {
        $count = min($count, 8000);
    } else if ($percent < 0.05) {
        $count = min($count, 12000);
    }

    // gate 买，bcex卖
    if ($type === 1) {
        $tryCount = 1;
        $bcexRes = $bcexLib->order($symbol, 'sale', $sell_price, $count);
        while (!$bcexRes && $tryCount++ < 5) {
            $bcexRes = $bcexLib->order($symbol, 'sale', $sell_price, $count);
        }
        $bRes = json_decode($bcexRes, true, JSON_UNESCAPED_UNICODE);
        if ($bcexRes && is_array($bRes) && $bRes['code'] == 0) {
            $gateRes = json_encode($gateLib->buy($gate_symbol, $buy_price, $count));
            $order_result = $symbol . ', bcex下单结果：' . $bcexRes . ',gate下单结果：' . $gateRes;
            trace($order_result, 'error');
            $data['get_eth'] = $count * ($sell_price - $buy_price);
            $data['order_result'] = $order_result;
            $data['order_count'] = $count;
            $data['order_status'] = 5;
        }
    } else {
        $tryCount = 1;
        $bcexRes = $bcexLib->order($symbol, 'buy', $buy_price, $count);
        while (!$bcexRes && $tryCount++ < 5) {
            $bcexRes = $bcexLib->order($symbol, 'buy', $buy_price, $count);
        }
        $bRes = json_decode($bcexRes, true, JSON_UNESCAPED_UNICODE);
        if ($bcexRes && is_array($bRes) && $bRes['code'] == 0) {
            $gateRes = json_encode($gateLib->sell($gate_symbol, $sell_price, $count));
            $order_result = $symbol . ',bcex下单结果：' . $bcexRes . ',gate下单结果：' . $gateRes;
            trace($order_result, 'error');
            $data['get_eth'] = $count * ($sell_price - $buy_price);
            $data['order_result'] = $order_result;
            $data['order_count'] = $count;
            $data['order_status'] = 5;
        }
    }
    return $data;
}