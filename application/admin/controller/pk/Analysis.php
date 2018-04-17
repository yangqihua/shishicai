<?php

namespace app\admin\controller\pk;

use app\common\controller\Backend;
use app\admin\model\PkHuihe;
use \think\Db;

class Analysis extends Backend
{
    protected $rate = 0.985;
    protected $max_num = 12;
    protected $rowdata = null;

    public function test($value = '')
    {
        return "123";
    }

    public function list_repeat()
    {
        $PkHuihe = new PkHuihe();
        $data = [];
        $sql = 'select count(id) as total from pk_huihe group by repeat_num';
        $res = Db::query($sql);
        $i = 0;
        foreach ($res as $row) {
            $i = $i + 1;
            $data[$i] = $row['total'];
        }
        return $data;
    }

    public function calc_income($start, $end)
    {
        $income = 0;
        $lost = 0;
        $data = $this->rowdata;
        if ($data == null) {
            $data = $this->list_repeat();
        }
        for ($i = $start; $i <= $end; $i++) {
            $income += $data[$i] * pow($this->rate, ($i + 1 - $start));
        }
        for ($i = $end + 1; $i < 30; $i++) {

            if (array_key_exists($i, $data)) {
                $lost += $data[$i] * pow(2, $end - $start + 1) - 1;
            }
        }
        $income = $income - $lost;
        return $income;
    }

    public function analysis($len = 4)
    {
        $data = [];
        $max_key = '';
        $max_value = -999999;
        $this->rowdata = $this->list_repeat();
        for ($i = 1; $i <= $this->max_num; $i++) {
            for ($j = $i + 1; $j <= $this->max_num; $j++) {
                if ($j - $i + 1 <= $len) {
                    $key = $i . '-' . $j;
                    $value = $this->calc_income($i, $j);
                    $data[$key] = $value;
                    if ($value > $max_value) {
                        $max_key = $key;
                        $max_value = $value;
                    }
                }
            }
        }
        $js = ['区间长度' => $len, 'max_key' => $max_key, 'max_value' => $max_value, 'data' => $data];
        return json($js);
    }

    public function get_one_day()
    {
        $result = [];

        $sql = 'SELECT FROM_UNIXTIME(createtime, \'%Y-%m-%d\') as create_time,count(FROM_UNIXTIME(createtime, \'%Y-%m-%d\')) as total FROM shishicai.pk_huihe group by create_time;';
        $res = Db::query($sql);
        foreach ($res as $row) {
            $result[$row['create_time']] = ['total_num' => $row['total']];
        }

        $sql = 'SELECT FROM_UNIXTIME(createtime, \'%Y-%m-%d\') as create_time,count(FROM_UNIXTIME(createtime, \'%Y-%m-%d\')) as total,repeat_num FROM shishicai.pk_huihe where repeat_num=1 group by create_time,repeat_num;';
        $res = Db::query($sql);
        $total_reward = 0;
        foreach ($res as $row) {
            $result[$row['create_time']]['yi_num'] = $row['total'];
            $result[$row['create_time']]['reward'] = $row['total'] * 2 * $this->rate - $result[$row['create_time']]['total_num'];
            $total_reward += $row['total'] * 2 * $this->rate - $result[$row['create_time']]['total_num'];
        }
        $data['result'] = $result;
        $data['total_reward'] = $total_reward;
        return json($data);
    }


}