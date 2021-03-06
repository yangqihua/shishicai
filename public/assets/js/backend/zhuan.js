define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'zhuan/index',
                    add_url: 'zhuan/add',
                    edit_url: 'zhuan/edit',
                    del_url: 'zhuan/del',
                    multi_url: 'zhuan/multi',
                    table: 'zhuan',
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
                        {field: 'get_eth', title: 'ETH盈利'},
                        {field: 'order_status', title: '状态'},
                        {field: 'order_result', title: '下单返回状态'},
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