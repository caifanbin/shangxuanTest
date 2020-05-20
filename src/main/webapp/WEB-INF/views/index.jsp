<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
        }

        body {
            background-image: url("/image/123.jpg");
        }
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="row">
        <div class="panel-heading">
            <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
        </div>
        <div class="panel-body">
            <form class="form-inline" role="form" style="float:left;">
                <div class="form-group has-feedback">
                    <div class="input-group">
                        <div class="input-group-addon">查询条件</div>
                        <input id="querytext" class="form-control has-success" type="text" placeholder="请输入查询条件">
                    </div>
                </div>
                <button id="quertBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i>
                    查询
                </button>
                <button onclick="window.location.href='/sx/tosave.htm'" type="button" class="btn btn-success"><i
                        class="glyphicon glyphicon-plus"></i>新增
                </button>
            </form>
            <br>
            <hr style="clear:both;">
            <div class="table-responsive">
                <table class="table  table-bordered">
                    <thead>
                    <tr>
                        <th width="30">id</th>
                        <th>姓名</th>
                        <th>年龄</th>
                        <th>性别</th>
                        <th width="100">操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="6" align="center">

                            <div id="Pagination" class="pagination"><!--这里显示分页--></div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script TYPE="text/javascript" src="${APP_PATH}/jquery/layer/layer.js"></script>
<script type="text/javascript" src="${APP_PATH}/jquery/pagination/jquery.pagination.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
        //调用异步开发
        queryPageUser(0);
    });


    var jsonObj = {
        "pageno": 1,
        "pagesize": 10
    };

    function queryPageUser(pageIndex) {
        jsonObj.pageno = pageIndex + 1;
        $.ajax({
            type: "post",
            data: jsonObj,
            url: "/sx/list.do",
            beforeSend: function () {
                return true;
            },
            success: function (result) {
                if (result.success) {
                    var page = result.page;
                    var data = page.datas;
                    var content = "";

                    $.each(data, function (i, n) {
                        content += '<tr>';
                        content += '<td>' + n.id + '</td>';
                        content += '<td>' + n.name + '</td>';
                        content += '<td>' + n.age + '</td>';
                        content += '<td>' + n.gender + '</td>';
                        content += '<td>';
                        content += '<button onclick="window.location.href=\'${APP_PATH}/sx/toupdate.htm?id=' + n.id + '\'" type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        content += '<button onclick="deleteStudent(' + n.id + ',\'' + n.name + '\')" type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        content += '</td>';
                        content += '</tr>';
                    });
                    //获取tbody标签，并把content设置到里边去
                    $("tbody").html(content);

                    $("#Pagination").pagination(page.totalsize, {
                        num_edge_entries: 1, //边缘页数
                        num_display_entries: 2, //主体页数
                        callback: queryPageUser,
                        items_per_page: 10, //每页显示1项
                        current_page: (page.pageno - 1),
                        prev_text: "上一页",
                        next_text: "下一页"

                    });


                } else {
                    layer.msg(result.message, {time: 1000, icon: 5, shift: 6});
                }
            },
            error: function () {
                layer.msg("加载数据失败", {time: 1000, icon: 5, shift: 6});
            }
        });
    }

    $("#quertBtn").click(function () {
        var querytext = $("#querytext").val();
        jsonObj.querytext = querytext;
        queryPageUser(0);
    });

    function deleteStudent(id, name) {
        layer.confirm("确认要删除[" + name + "]学生吗？", {icon: 3, title: '提示'}, function (cindex) {
            layer.close(cindex);
            $.ajax({
                type: "post",
                data: {
                    "id": id
                },
                url: "${APP_PATH}/sx/dodelete.do",
                beforeSend: function () {
                    return true;
                },
                success: function (result) {
                    if (result.success) {
                        window.location.href = "/sx/toindex.htm";
                    } else {
                        layer.msg("删除失败", {time: 1000, icon: 5, shift: 6});
                    }
                }
            });
        }, function (cindex) {
            layer.close(cindex);
        });
    }

</script>
</body>
</html>
