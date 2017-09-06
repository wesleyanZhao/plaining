<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>设置新密码</legend>
<div class="layui-field-box" >
    <form class="layui-form">
        <input type="hidden" name="user_id" value="${(userInfo.userId)!''}">
        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-inline">
                <input type="password" id="newPassword1" name="newPassword1" required lay-verify="required" placeholder="请输入新密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline">
                <input type="password" id="newPassword2" name="newPassword2" required lay-verify="required" placeholder="请确认密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="modifyPassword">确定</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
</fieldset>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script>
    //Demo
    // 待学生自主完成
    layui.use(['form','jquery','layer'], function(){
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;

        //监听提交
        form.on('submit(modifyPassword)', function(params){
            //表单数据
           /* var username = $("#username").val();
            var password = $("#password").val();
            var gender = $("input[name='gender']:checked").val();
            var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();

            $.ajax({
                type:"post",
                url:"/user/setNewPassword.do",
                data:data,
                success:function (data) {
                    if(data.result == "success"){
                        layer.msg('修改成功',{
                            icon:1
                            time:1000
                        },function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                        });
                    }else if(data.result == "different"){
                        layer.msg('两次密码不一致，请重新输入',{
                            icon:0
                            time:1000
                        });
                    }
                }
            })
            return false;//return false 表示不通过页面刷新方式提交表单
        });
    });
</script>
</body>
</html>