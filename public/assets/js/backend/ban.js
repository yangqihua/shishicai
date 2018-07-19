define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'ban/index',
                    add_url: 'ban/add',
                    edit_url: 'ban/edit',
                    del_url: 'ban/del',
                    multi_url: 'ban/multi',
                    table: 'ban',
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
                        {field: 'gate_ask', title: __('Gate_ask')},
                        {field: 'bcex_ask', title: __('Bcex_ask')},
                        {field: 'gate_bid', title: __('Gate_bid')},
                        {field: 'bcex_bid', title: __('Bcex_bid')},
                        {field: 'remark', title: __('Remark')},
                        {field: 'order_count', title: __('Order_count')},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'get_eth', title: __('Get_eth')},
                        {field: 'order_result', title: __('Order_result')},
                        {field: 'order_status', title: __('Order_status')},
                        {field: 'symbol', title: __('Symbol')},
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