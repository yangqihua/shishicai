define(['jquery', 'bootstrap', 'backend', 'addtabs', 'table', 'echarts', 'echarts-theme'], function ($, undefined, Backend, Datatable, Table, Echarts) {

    var Controller = {
        index: function () {
            var balanceChart = Echarts.init(document.getElementById('balance_echart'));
            var balanceOption = {
                title: {
                    text: '账户',
                    textStyle: {
                        color: '#27C24C',
                        fontSize: '16'
                    },
                },
                tooltip: {
                    trigger: 'axis',
                    formatter: function (params) {
                        var result = params[0].name;
                        params.forEach(function (item) {
                            result += '<br/>';
                            result += '<span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:' + item.color + '"></span>';
                            result += item.seriesName + "：";
                            if (item.seriesName === 'eth') {
                                result += isNaN(item.value) ? 0 : item.value / balanceList['eth_rate'];
                            } else if (item.seriesName === 'rating') {
                                result += isNaN(item.value) ? 0 : item.value / balanceList['rating_rate'];
                            } else {
                                result += isNaN(item.value) ? 0 : item.value;
                            }
                        });
                        return result;
                    }
                },
                legend: {
                    data: ['money', 'eth', 'rating']
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
                    data: balanceList['time']
                },
                yAxis: {
                    // min: 0.000005,
                    // max: 0.000010,
                    type: 'value',
                    scale:true,
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
                series: [
                    {
                        name: 'money',
                        type: 'line',
                        data: balanceList['money']
                    },
                    {
                        name: 'eth',
                        type: 'line',
                        data: balanceList['eth']
                    },
                    {
                        name: 'rating',
                        type: 'line',
                        data: balanceList['rating']
                    },
                ]
            };
            balanceChart.setOption(balanceOption);


            var marketChart = Echarts.init(document.getElementById('market_echart'));
            var marketOption = {
                title: {
                    text: '库存统计',
                    textStyle: {
                        color: '#27C24C',
                        fontSize: '16'
                    },
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['gate', 'bcex', 'uex', 'coinoah', 'hotbit']
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
                    data: marketList['time']
                },
                yAxis: {
                    // min: 0.000005,
                    // max: 0.000010,
                    type: 'value',
                    // scale:true,
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
                series: [
                    {
                        name: 'gate',
                        type: 'line',
                        data: marketList['gate']
                    },
                    {
                        name: 'bcex',
                        type: 'line',
                        data: marketList['bcex']
                    },
                    {
                        name: 'uex',
                        type: 'line',
                        data: marketList['uex']
                    },
                    {
                        name: 'coinoah',
                        type: 'line',
                        data: marketList['coinoah']
                    },
                    {
                        name: 'hotbit',
                        type: 'line',
                        data: marketList['hotbit']
                    },
                ]
            };
            marketChart.setOption(marketOption);

        }
    };

    return Controller;
});