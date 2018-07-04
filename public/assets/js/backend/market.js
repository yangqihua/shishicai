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
                        {field: 'quote_volume', title: __('Quote_volume')},
                        {field: 'base_volume', title: __('Base_volume')},
                        {field: 'highest_bid', title: __('Highest_bid')},
                        {field: 'high24hr', title: __('High24hr')},
                        {field: 'last', title: __('Last')},
                        {field: 'lowest_ask', title: __('Lowest_ask')},
                        {field: 'elapsed', title: __('Elapsed')},
                        {field: 'result', title: __('Result')},
                        {field: 'low24hr', title: __('Low24hr')},
                        {field: 'percent_change', title: __('Percent_change')},
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