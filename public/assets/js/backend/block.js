define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'block/index',
                    add_url: 'block/add',
                    edit_url: 'block/edit',
                    del_url: 'block/del',
                    multi_url: 'block/multi',
                    table: 'block',
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
                        {field: 'gate_last', title: __('Gate_last')},
                        {field: 'bcex_last', title: __('Bcex_last')},
                        {field: 'gate_bid', title: __('Gate_bid')},
                        {field: 'gate_ask', title: __('Gate_ask')},
                        {field: 'gate_high', title: __('Gate_high')},
                        {field: 'gate_low', title: __('Gate_low')},
                        {field: 'gate_vol', title: __('Gate_vol')},
                        {field: 'gate_base_volume', title: __('Gate_base_volume')},
                        {field: 'gate_change_daily', title: __('Gate_change_daily')},
                        {field: 'bcex_bid', title: __('Bcex_bid')},
                        {field: 'bcex_ask', title: __('Bcex_ask')},
                        {field: 'bcex_high', title: __('Bcex_high')},
                        {field: 'bcex_low', title: __('Bcex_low')},
                        {field: 'bcex_vol', title: __('Bcex_vol')},
                        {field: 'bcex_base_volume', title: __('Bcex_base_volume')},
                        {field: 'bcex_change_daily', title: __('Bcex_change_daily')},
                        {field: 'update_stamps', title: __('Update_stamps')},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
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