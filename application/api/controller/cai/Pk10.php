<?php

namespace app\api\controller\cai;

use app\admin\model\PkHuihe;
use app\admin\model\PkLost;
use app\admin\model\PkResult;
use app\common\controller\Api;
use app\common\model\Config;
use fast\Http;
use QL\QueryList;
use think\Db;

/**
 * 首页接口
 */
class Pk10 extends Api
{

    private $isDebug = false;
    private $baseMoney = 1;   // 表示以1为底
    private $xiazhuCount = 1;   // 表示第五把要下注了
    private $xiazhuLength = 3;  // 表示连根4把放弃
    private $cookie = 'PHPSESSID=ntsri95d4h9u04s745r3b3nkk4; PHPSESSID=ntsri95d4h9u04s745r3b3nkk4';
    private $duoyin_cookie = 'JSESSIONID=aaaEs5okegqkp-kyv7ckw; _skin_=blue; x-session-token=znJ0eZnwe%2BDuBn%2BrOOON8TcKYGxwaHosaEFMaXVYF%2Fef2R6Hw6RHVQ%3D%3D';
    private $receiver_address = '904693433@qq.com';
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];
    private $map = ['yi', 'er', 'san', 'si', 'wu', 'liu', 'qi', 'ba', 'jiu', 'shi',];
    private $huiheMap = ['total' => '冠亚之和', 'yi' => '冠军', 'er' => '亚军', 'san' => '第三名', 'si' => '第四名', 'wu' => '第五名', 'liu' => '第六名', 'qi' => '第七名', 'ba' => '第八名', 'jiu' => '第九名', 'shi' => '第十名',];
    private $testData = ['qihao' => 674230, 'reward_time' => '2018-04-01 21:07', 'yi' => '4', 'er' => '10', 'san' => '4', 'si' => '3', 'wu' => '6', 'liu' => '8', 'qi' => '5', 'ba' => '2', 'jiu' => '9', 'shi' => '1', 'total' => 17];


    public function send_mail()
    {
        $time = time();
        $url = 'https://www.dy78.com/api/init.do?_t=' . $time;
        $header = [
            ':authority' => 'www.dy78.com',
            ':method' => 'GET',
            ':path' => '/api/init.do?_t=' . $time,
            ':scheme' => 'https',
            'accept' => 'application/json, text/plain, */*',
            'accept-encoding' => 'gzip, deflate, br',
            'accept-language' => 'zh-CN,zh;q=0.9,en;q=0.8',
            'cache-control' => 'no-cache',
            'cookie' => 'JSESSIONID=aaaEs5okegqkp-kyv7ckw; x-session-token=AFqU8eHXlDMl8PFD%2FUbkjt6US0fz8FLI6Gwy0zXp8lzHTZPSIiqpuw%3D%3D;',
            'origin' => 'https://www.dy78.com',
            'referer' => 'https://www.dy78.com/game/',
            'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',
        ];
        $ql = QueryList::getInstance();
        $result = json_decode($ql->get($url, [], ['headers' => $header])->getHtml(), true);
        $money = $result['money'];
        $message = $result['fullName'] . ' 当前余额：' . $money . '，token: ' . $result['token'] . '，lastLoginTime：' . $result['lastLoginTime'] . '，serverTime：' . $result['serverTime'];
        $subject = '当前余额：' . $money;
        $data = sendMail($this->receiver_address, $message, $subject);
        $this->success($data);
    }


    public function cron_get_history()
    {
        $config = new Config();
        $this->duoyin_cookie = $config->where("name", "duoyin_cookie")->find() ? $config->where("name", "duoyin_cookie")->find()['value'] : $this->duoyin_cookie;
        $item = $this->getData(2320, 2359);
        if (!$item) {
            // todo: 爬取数据出错处理
            $this->error('爬取数据出错处理');
        }
        $item = array_reverse($item);
        foreach ($item as $k => $v) {
            // 数据库不存在才是新的一期
            $resultModel = new PkResult();
            $old = $resultModel->where(['qihao' => $v['qihao']])->find();
            if (!$old) {
                foreach ($this->huiheMap as $key => $value) {
//                    if ($key != 'total') {
                    if ($key == 'yi') {
                        $this->checkHuihe($v, $key);
                    }
                }
                $resultModel->save($v);
            }
        }
    }

    public function cron_get_data()
    {
//        $item = $this->getOneRecentData();
//        $item = $this->testData;
        $config = new Config();
        $this->duoyin_cookie = $config->where("name", "duoyin_cookie")->find() ? $config->where("name", "duoyin_cookie")->find()['value'] : $this->duoyin_cookie;
        $item = $this->get_duoyin_data();
        if (!$item) {
            // todo: 爬取数据出错处理
        }
        // 数据库不存在才是新的一期
        $resultModel = new PkResult();
        $old = $resultModel->where(['qihao' => $item['qihao']])->find();
        if (!$old) {
            foreach ($this->huiheMap as $key => $value) {
//                if ($key != 'total') {
                if ($key == 'yi') {
                    $this->checkHuihe($item, $key);
                }
            }
            $resultModel->save($item);
        }
        $this->success('cron_get_data success');
    }

    public function get_duoyin_data()
    {
        $time = time();
        $url = 'https://www.dy78.com/static/data/50CurIssue.json?_t=' . $time;
        $header = [
            ':authority' => 'www.dy78.com',
            ':method' => 'GET',
            ':path' => 'static/data/50CurIssue.json?_t=' . $time,
            ':scheme' => 'https',
            'accept' => 'application/json, text/plain, */*',
            'accept-encoding' => 'gzip, deflate, br',
            'accept-language' => 'zh-CN,zh;q=0.9,en;q=0.8',
            'cache-control' => 'no-cache',
            'cookie' => 'JSESSIONID=aaaEs5okegqkp-kyv7ckw; x-session-token=pYGMhBTi28dDhlnwVoRi4kdWJ2vq9H3R3TMc1QJXnP%2BIBk3%2FrkyCqg%3D%3D',
            'origin' => 'https://www.dy78.com',
            'referer' => 'https://www.dy78.com/game/',
            'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',
        ];
        $ql = QueryList::getInstance();
        $result = json_decode($ql->get($url, [], ['headers' => $header])->getHtml(), true);
        $nums = explode(',', $result['nums']);
        $dataModel['qihao'] = $result['issue'];
        $dataModel['reward_time'] = $result['opentime'];
        for ($j = 0; $j < count($nums); $j++) {
            $column = $this->map[$j];
            $dataModel[$column] = preg_replace('/^0+/', '', $nums[$j]);
        }
        return $dataModel;
//        $this->success('', $dataModel);
    }

    /**
     * @param $wei = 下哪一位  yi er san ...
     * @param $type = 1 代表大，2代表小，3代表单，4代表双
     * @param int $repeat_num
     * @param $qihao
     * @return mixed|string
     * @internal param $ |int $repeat_num 重复了多少次
     */
    public function xiazhu_duoyin($wei, $type, $repeat_num = 5, $qihao)
    {
        trace('期号：' . $qihao . $wei . '位连出：' . $repeat_num . '次', 'error');
        $money = pow(2, ($repeat_num - $this->xiazhuCount)) * $this->baseMoney;
        $cookie = $this->duoyin_cookie;
        $index = array_search($wei, $this->map);
        $playId = 5011 + $index;
        switch ($type) {
            case 1:  // 大
                $playId .= '01';
                break;
            case 2:  // 小
                $playId .= '02';
                break;
            case 3:  // 单
                $playId .= '03';
                break;
            case 4:  // 双
                $playId .= '04';
                break;
        }
        $data = [
            'betBean[0].playId' => $playId,
            'betBean[0].money' => $money,
            'gameId' => 50,
            'turnNum' => $qihao,
            'totalNums' => 1,
            'totalMoney' => $money,
            'betSrc' => 0,
        ];

        $time = time();
        $url = 'https://www.dy78.com/bet/bet.do?_t=' . $time;
        $header = [
            ':authority' => 'www.dy78.com',
            ':method' => 'POST',
            ':path' => '/bet/bet.do?_t=' . $time,
            ':scheme' => 'https',
            'accept' => 'application/json, text/plain, */*',
            'accept-encoding' => 'gzip, deflate, br',
            'accept-language' => 'zh-CN,zh;q=0.9,en;q=0.8',
            'cache-control' => 'no-cache',
            'content-length' => '110',
            'content-type' => 'application/x-www-form-urlencoded',
            'cookie' => $cookie,
            'origin' => 'https://www.dy78.com',
            'pragma' => 'no-cache',
            'referer' => 'https://www.dy78.com/game/',
            'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',
        ];
        $options = [
            CURLOPT_COOKIE => $cookie,
            CURLOPT_HTTPHEADER => $header
        ];
//        $result = '';
//        $resultArr = [];
        $result = Http::post($url, $data, $options);
        $resultArr = json_decode($result, true);
        $message = '多盈下注提交的参数为：' . json_encode($data) . ' 返回的结果为：' . $result;
        if (!$resultArr || !$resultArr['success']) {
            sendMail($this->receiver_address, $message, $qihao . '期下注失败');
        }
        trace($message, 'error');
        return $resultArr;
    }


    // 在这个函数里面调用函数下注
    private function checkHuihe($item, $type = 'yi')
    {
        $xiazhuCount = $this->xiazhuCount;
        $xiazhuLength = $this->xiazhuLength;
        $isLianxu = $this->checkLianxu($item);
        $huiheModel = new PkHuihe();
        $wei = $this->huiheMap[$type];
        $weiValue = $item[$type];
        // $wei单双
        $sql = 'select * from pk_huihe where id = (select max(id) from pk_huihe where (type="单" or type="双") and wei=:wei)';
        $weidsolds = Db::query($sql, ['wei' => $wei]);
        // 1. check 单双
        // $wei 这一次是单
        if (isOdd($weiValue)) {
            // $wei位单:取最后一回合type=单或双&&wei=指定位的记录
            if (count($weidsolds) == 1 && $isLianxu) {
                $weidsold = $weidsolds[0];
                $lastType = $weidsold['type'];
                // update 如果上一次连出了单
                if ($lastType == '单') {
                    // todo: 到达一定次数下注
                    if ($xiazhuCount <= ($weidsold['repeat_num'] + 1) && ($weidsold['repeat_num'] + 1) < ($xiazhuCount + $xiazhuLength) && !$this->isDebug) {
                        $this->xiazhu_duoyin($type, 4, ($weidsold['repeat_num'] + 1), intval($item['qihao']) + 1);
                    }
                    $huiheModel->where('id', $weidsold['id'])->update([
                        'qihaos' => $weidsold['qihaos'] . ',' . $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => $weidsold['repeat_num'] + 1,
                    ]);
                } else { //save 如果上一次连出了双
                    $huiheModel->data([
                        'type' => '单',
                        'wei' => $wei,
                        'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => 1,
                    ])->save();
                }
            } else { //不存在记录
                $huiheModel->data([
                    'type' => '单',
                    'wei' => $wei,
                    'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                    'repeat_num' => 1,
                ])->save();
            }
        } else { // $wei双
            // $wei位双:取最后一回合type=单或双&&wei=指定位的记录
            if (count($weidsolds) == 1 && $isLianxu) {
                $weidsold = $weidsolds[0];
                $lastType = $weidsold['type'];

                // update
                if ($lastType == '双') {
                    // todo: 到达一定次数下注
                    if ($xiazhuCount <= ($weidsold['repeat_num'] + 1) && ($weidsold['repeat_num'] + 1) < ($xiazhuCount + $xiazhuLength) && !$this->isDebug) {
                        $this->xiazhu_duoyin($type, 3, ($weidsold['repeat_num'] + 1), intval($item['qihao']) + 1);
                    }
                    $huiheModel->where('id', $weidsold['id'])->update([
                        'qihaos' => $weidsold['qihaos'] . ',' . $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => $weidsold['repeat_num'] + 1,
                    ]);
                } else { //save ，本局是双，上一回合是单，则新开一回合。
                    $huiheModel->data([
                        'type' => '双',
                        'wei' => $wei,
                        'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => 1,
                    ])->save();
                }
            } else { //save
                $huiheModel->data([
                    'type' => '双',
                    'wei' => $wei,
                    'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                    'repeat_num' => 1,
                ])->save();
            }
        }
        // 2. check 大小
        $sql = 'select * from pk_huihe where id = (select max(id) from pk_huihe where (type="大" or type="小") and wei=:wei)';
        $weidxolds = Db::query($sql, ['wei' => $wei]);
        // $wei小
        if (isSmall($weiValue)) {
            if (count($weidxolds) == 1 && $isLianxu) {
                $weidxold = $weidxolds[0];
                $lastType = $weidxold['type'];

                // update
                if ($lastType == '小') {
                    // todo: 到达一定次数下注
                    if ($xiazhuCount <= ($weidxold['repeat_num'] + 1) && ($weidxold['repeat_num'] + 1) < ($xiazhuCount + $xiazhuLength) && !$this->isDebug) {
                        $this->xiazhu_duoyin($type, 1, ($weidxold['repeat_num'] + 1), intval($item['qihao']) + 1);
                    }
                    $huiheModel->where('id', $weidxold['id'])->update([
                        'qihaos' => $weidxold['qihaos'] . ',' . $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => $weidxold['repeat_num'] + 1,
                    ]);
                } else { //save
                    $huiheModel->data([
                        'type' => '小',
                        'wei' => $wei,
                        'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => 1,
                    ])->isUpdate(false)->save();
                }
            } else {
                $huiheModel->data([
                    'type' => '小',
                    'wei' => $wei,
                    'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                    'repeat_num' => 1,
                ])->isUpdate(false)->save();
            }
        } else { // $wei大
            if (count($weidxolds) == 1 && $isLianxu) {
                $weidxold = $weidxolds[0];
                $lastType = $weidxold['type'];

                // update
                if ($lastType == '大') {
                    // todo: 到达一定次数下注
                    if ($xiazhuCount <= ($weidxold['repeat_num'] + 1) && ($weidxold['repeat_num'] + 1) < ($xiazhuCount + $xiazhuLength) && !$this->isDebug) {
                        $this->xiazhu_duoyin($type, 2, ($weidxold['repeat_num'] + 1), intval($item['qihao']) + 1);
                    }
                    $huiheModel->where('id', $weidxold['id'])->update([
                        'qihaos' => $weidxold['qihaos'] . ',' . $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => $weidxold['repeat_num'] + 1,
                    ]);
                } else { //save ，本局是大，上一回合是小，则新开一回合。
                    $huiheModel->data([
                        'type' => '大',
                        'wei' => $wei,
                        'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                        'repeat_num' => 1,
                    ])->isUpdate(false)->save();
                }
            } else { //save ，本局是大，上一回合是小，则新开一回合。
                $huiheModel->data([
                    'type' => '大',
                    'wei' => $wei,
                    'qihaos' => $item['qihao'] . '(' . $weiValue . ')',
                    'repeat_num' => 1,
                ])->isUpdate(false)->save();
            }
        }
    }

    private function getOneRecentData()
    {
        $result = $this->getData(1, 1);
        if (count($result) > 0) {
            return $result[0];
        }
        return [];
    }

    private function getData($from = 1, $to = 10)
    {
        $ql = QueryList::getInstance();
        $url = 'https://m.jjcp.net/index.php/api/LotteryData/history';
        $header = [
            'Host' => 'm.jjcp.net',
            'Origin' => 'https://m.jjcp.net',
            'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
            'Cookie' => $this->cookie,
        ];
        $resultList = [];
        for ($k = $from; $k <= $to; $k++) {
            $data = ['page' => $k, 'id' => 5];
            $result = json_decode($ql->post($url, $data)->getHtml(), true);
            $data = $result['data']['data'];
            $dataModelList = [];
            for ($i = 0; $i < count($data); $i++) {
                $item = $data[$i];
                $dataModel['qihao'] = $item['number'];
                $dataModel['reward_time'] = $item['create_time'];
                for ($j = 0; $j < count($item['data']); $j++) {
                    $column = $this->map[$j];
                    $dataModel[$column] = preg_replace('/^0+/', '', $item['data'][$j]);
                }
                $dataModel['total'] = intval($dataModel['yi']) + intval($dataModel['er']);
                $dataModelList[] = $dataModel;
            }
            $resultList = array_merge($resultList, $dataModelList);
        }
        return $resultList;
    }

    /**
     * @param $wei = 下哪一位
     * @param $type = 1 代表大，2代表小，3代表单，4代表双
     * @param $qihao
     * @return string
     * @internal param $cookie
     * @internal param 倍数|int $extraBei 倍数(1,2,4,8,16),或者(1,3,5,9,17,33)
     */
    public function xiazhu($wei, $type, $qihao)
    {
        $cookie = $this->cookie;
        switch ($type) {
            case 1:  // 大
                break;
            case 2:  // 小
                break;
            case 3:  // 单
                break;
            case 4:  // 双
                break;
        }
        trace('提交的参数为：' . json_encode($postData) . ' 返回的结果为：' . $result, 'error');
        return $result;
    }

    // 检查期号是否连续
    private function checkLianxu($value)
    {
        $sql = 'select * from pk_result where id = (select max(id) from pk_result)';
        $qihaos = Db::query($sql);
        if (count($qihaos) == 1) {
            $old_qihao = $qihaos[0]['qihao'];
            $qihao = intval($old_qihao) + 1;
            if ($qihao != intval($value['qihao'])) {
                $lostModel = new PkLost();
                $old = $lostModel->where(['qihao' => $value['qihao']])->find();
                if (!$old) {
                    $lostModel->save(['qihao' => $value['qihao']]);
                }
                return false;
            }
        }
        return true;
    }

}
