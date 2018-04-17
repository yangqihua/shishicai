define(['jquery', 'bootstrap', 'backend', 'addtabs', 'table', 'echarts', 'echarts-theme'], function ($, undefined, Backend, Datatable, Table, Echarts) {

    var Controller = {
        index: function () {
            var lengend = ['冠军', '亚军', '第三名', '第四名', '第五名', '第六名', '第七名', '第八名', '第九名', '第十名',]
            var qihaos = [];
            var dsSeries = [];
            var dxSeries = [];
            var dsMap = {}
            var dxMap = {}
            for (var key in resultList) {
                qihaos.push(key);
                var value = resultList[key];
                for (var k in value) {
                    for (var lastKey in value[k]) {
                        if (lastKey === '大' || lastKey === '小') {
                            if (dxMap.hasOwnProperty(k)) {
                                dxMap[k].push(value[k][lastKey])
                            } else {
                                dxMap[k] = [value[k][lastKey]]
                            }
                        } else {
                            if (dsMap.hasOwnProperty(k)) {
                                dsMap[k].push(value[k][lastKey])
                            } else {
                                dsMap[k] = [value[k][lastKey]]
                            }
                        }
                    }
                }
            }
            for (var key in dsMap) {
                var dsSerie = {
                    name: key,
                    type: 'line',
                    data: dsMap[key]
                }
                dsSeries.push(dsSerie)
            }

            for (var key in dxMap) {
                var dxSerie = {
                    name: key,
                    type: 'line',
                    data: dxMap[key]
                }
                dxSeries.push(dxSerie)
            }

            var rewardChart = Echarts.init(document.getElementById('reward_echart'));

            var rewardData = reward['result']
            var rewardTime = [];
            var rewardMoney = [];
            for (var key in rewardData) {
                rewardTime.push(key);
                rewardMoney.push(rewardData[key]['reward']);
            }


            var rewardOption = {
                calculable: true,
                title: {
                    text: '中奖统计',
                    textStyle: {
                        color: '#27C24C',
                        fontSize: '16'
                    },
                },
                "toolbox": {
                    "feature": {
                        "saveAsImage": {
                            "show": true,
                            "title": "保存为图片",
                            "type": "png",
                            "lang": ["点击保存"]
                        },
                        "dataView": {
                            "show": true,
                            "title": "数据视图",
                            "readOnly": false,
                            "lang": ["数据视图", "关闭", "刷新"]
                        },
                        "magicType": {
                            "show": true,
                            "title": {
                                "bar": "柱形图切换",
                                "stack": "堆积",
                                "tiled": "平铺",
                                "line": "折线图切换"
                            },
                            "type": ["line", "bar"]
                        },
                        "restore": {
                            "show": true,
                            "title": "还原"
                        }
                    },
                    "show": true,
                    "left": "82%"
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ["中奖金额"]
                },
                dataZoom: [
                    {
                        "xAxisIndex": [
                            0
                        ],
                        bottom: 30,
                        "start": 0,
                        "end": 100,
                        handleIcon: 'path://M306.1,413c0,2.2-1.8,4-4,4h-59.8c-2.2,0-4-1.8-4-4V200.8c0-2.2,1.8-4,4-4h59.8c2.2,0,4,1.8,4,4V413z',
                        handleSize: '110%',
                        handleStyle: {
                            color: "#aaa",
                        },
                        textStyle: {
                            color: "#27C24C"
                        },
                        borderColor: "#aaa"
                    },
                    {
                        "type": "inside",
                        "show": true,
                        // "height": 15,
                        "start": 30,
                        "end": 100
                    }
                ],
                grid: {
                    "left": "10%",
                    "right": "10%",
                    "bottom": "15%"
                },
                xAxis: [{
                    "type": "category",
                    "data":rewardTime
                }],
                "yAxis": [{
                    "type": "value",
                    "name": "中奖金额",
                    "splitArea": {
                        "show": true
                    },
                    "scale": true
                }],
                "series": [{
                    "barWidth": 50,
                    "name": "中奖金额",
                    "type": "bar",
                    "label": {
                        "normal": {
                            "show": true,
                            // "formatter": (function() {
                            //     return ' {c}%';
                            // })(),
                            "position": "top"
                        }
                    },
                    "data": rewardMoney
                }]
            };

            rewardChart.setOption(rewardOption);



            var inventoryChart = Echarts.init(document.getElementById('first_echart'));
            var inventoryOption = {
                title: {
                    text: '大小连出统计',
                    textStyle: {
                        color: '#27C24C',
                        fontSize: '16'
                    },
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: lengend
                },
                grid: {
                    "bottom": 100,
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: qihaos
                },
                yAxis: {
                    type: 'value'
                },
                dataZoom: [
                    {
                        "xAxisIndex": [
                            0
                        ],
                        bottom: 30,
                        "start": 0,
                        "end": 100,
                        handleIcon: 'path://M306.1,413c0,2.2-1.8,4-4,4h-59.8c-2.2,0-4-1.8-4-4V200.8c0-2.2,1.8-4,4-4h59.8c2.2,0,4,1.8,4,4V413z',
                        handleSize: '110%',
                        handleStyle: {
                            color: "#aaa",
                        },
                        textStyle: {
                            color: "#27C24C"
                        },
                        borderColor: "#aaa"
                    },
                    {
                        "type": "inside",
                        "show": true,
                        // "height": 15,
                        "start": 30,
                        "end": 100
                    }
                ],
                series: dxSeries
            };
            inventoryChart.setOption(inventoryOption);


            var inventoryChart1 = Echarts.init(document.getElementById('second_echart'));
            var inventoryOption1 = {
                title: {
                    text: '单双连出统计',
                    textStyle: {
                        color: '#27C24C',
                        fontSize: '16'
                    },
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: lengend
                },
                grid: {
                    "bottom": 100,
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: qihaos
                },
                yAxis: {
                    type: 'value'
                },
                dataZoom: [
                    {
                        "xAxisIndex": [
                            0
                        ],
                        bottom: 30,
                        "start": 0,
                        "end": 100,
                        handleIcon: 'path://M306.1,413c0,2.2-1.8,4-4,4h-59.8c-2.2,0-4-1.8-4-4V200.8c0-2.2,1.8-4,4-4h59.8c2.2,0,4,1.8,4,4V413z',
                        handleSize: '110%',
                        handleStyle: {
                            color: "#aaa",
                        },
                        textStyle: {
                            color: "#27C24C"
                        },
                        borderColor: "#aaa"
                    },
                    {
                        "type": "inside",
                        "show": true,
                        // "height": 15,
                        "start": 30,
                        "end": 100
                    }
                ],
                series: dsSeries
            };
            inventoryChart1.setOption(inventoryOption1);

        }
    };

    return Controller;
});