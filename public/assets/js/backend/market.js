define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'market/index',
                    add_url: 'market/add',
                    edit_url: 'market/edit',
                    del_url: 'market/del',
                    multi_url: 'market/multi',
                    table: 'market',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'last', title: '最新成交价'},
                        {field: 'highest_bid', title: '买方最高价'},
                        {field: 'lowest_ask', title: '卖方最低价'},
                        {field: 'base_volume', title: '交易量'},
                        {field: 'percent_change', title: '涨跌百分比'},
                        {field: 'high24hr', title: '24小时最高价'},
                        {field: 'low24hr', title: '24小时最低价'},
                        {field: 'quote_volume', title: '兑换货币交易量'},
                        {field: 'result', title: __('Result')},
                        {field: 'elapsed', title: __('Elapsed')},
                        {field: 'createtime', title: __('Create_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});