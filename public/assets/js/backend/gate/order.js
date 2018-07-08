define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'gate/order/index',
                    add_url: 'gate/order/add',
                    edit_url: 'gate/order/edit',
                    del_url: 'gate/order/del',
                    multi_url: 'gate/order/multi',
                    table: 'gate_order',
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
                        {field: 'buy_rate', title: __('Buy_rate')},
                        {field: 'sell_rate', title: __('Sell_rate')},
                        {field: 'order_count', title: __('Order_count')},
                        {field: 'sell_order_number', title: __('Sell_order_number')},
                        {field: 'buy_order_number', title: __('Buy_order_number')},
                        {field: 'order_status', title: __('Order_status'), formatter: Table.api.formatter.status},
                        {field: 'rate_money', title: __('Rate_money')},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
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