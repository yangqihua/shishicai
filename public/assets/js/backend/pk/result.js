define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'pk/result/index',
                    add_url: 'pk/result/add',
                    edit_url: 'pk/result/edit',
                    del_url: 'pk/result/del',
                    multi_url: 'pk/result/multi',
                    table: 'pk_result',
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
                        {field: 'qihao', title: __('Qihao')},
                        {field: 'yi', title: __('Yi')},
                        {field: 'er', title: __('Er')},
                        {field: 'san', title: __('San')},
                        {field: 'si', title: __('Si')},
                        {field: 'wu', title: __('Wu')},
                        {field: 'liu', title: __('Liu')},
                        {field: 'qi', title: __('Qi')},
                        {field: 'ba', title: __('Ba')},
                        {field: 'jiu', title: __('Jiu')},
                        {field: 'shi', title: __('Shi')},
                        {field: 'updatetime', title: __('Updatetime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
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