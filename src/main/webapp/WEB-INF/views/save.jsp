<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        body {
            background-image: url("/image/123.jpg");
        }
    </style>
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <div class="panel-heading">表单数据
            <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                    class="glyphicon glyphicon-question-sign"></i></div>
        </div>
        <div class="panel-body">
            <form role="form" id="saveform">
                <div class="form-group">
                    <label for="name">姓名</label>
                    <input type="text" class="form-control" id="name">
                </div>
                <div class="form-group">
                    <label for="age">年龄</label>
                    <input type="text" class="form-control" id="age">
                </div>
                <div class="form-group">
                    <label for="gender">性别</label>
                    <input type="text" class="form-control" id="gender">
                </div>
                <button id="saveBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 添加
                </button>
                <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>
                    重置
                </button>
            </form>
        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
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
    });
    $("#saveBtn").click(function () {
        var name = $("#name").val();
        var age = $("#age").val();
        var gender = $("#gender").val();
        $.ajax({
            type: "post",
            data: {
                "name": name,
                "age": age,
                "gender": gender
            },
            url: "/sx/dosave.do",
            beforeSend: function () {
                return true;
            },
            success: function (result) {
                if (result.success) {
                    window.location.href = "${APP_PATH}/sx/toindex.htm";
                } else {
                    alert("添加成功");
                }
            },
            error: function () {
                alert("添加失败");
            }

        });
    });
    $("#resetBtn").click(function () {
        $("#saveform")[0].reset();
    })
</script>
</body>
</html>

