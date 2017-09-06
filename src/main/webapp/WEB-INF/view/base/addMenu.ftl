<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>添加新菜单项</legend>
<div class="layui-field-box" >
    <form class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">名字</label>
            <div class="layui-input-inline">
                <input type="text" id="name" name="name" required  lay-verify="required" placeholder="请输入菜单名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <#--<div class="layui-form-item">-->
            <#--<label class="layui-form-label">开关-默认开</label>-->
            <#--<div class="layui-input-block">-->
                <#--<input id="switch" type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="ON|OFF">-->
            <#--</div>-->
        <#--</div>-->
        <div id="address" class="layui-form-item">
            <label class="layui-form-label">地址</label>
            <div class="layui-input-inline">
                <input type="text" id="url" name="url" placeholder="请输入菜单项地址" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜单级别</label>
            <div id="menu" class="layui-input-inline">
                <select id="organization" name="organization" lay-filter="organization" lay-verify="required" >
                    <option value="10" selected>一级菜单</option>
                    <option value="20">二级菜单</option>
                </select>
            </div>
            <label id="menuLabel" class="layui-form-label" style="display:none;">所属菜单</label>
            <div id="menuList" class="layui-input-inline" style="display:none;">
                <select id="parentOrganization" name="organizationOne" lay-filter="parentOrganization">
                    <option></option>
                </select>
            </div>
        </div>

        <#--<div class="layui-form-item">-->
            <#--<label class="layui-form-label">菜单级别</label>-->
            <#--<div class="layui-input-inline">-->
                <#--<select id="parentOrganization" name="organizationOne">-->
                    <#--<option value="10">一级菜单</option>-->
                <#--</select>-->
            <#--</div>-->
        <#--</div>-->

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="registerForm">提交</button>
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

//        form.on('switch(switchTest)', function(data){
//            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
//                offset: '6px'
//            });
//        });form.on('switch(switchTest)', function(data){
//            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
//                offset: '6px'
//            });
//        });

        form.on('select(organization)',function () {
            var val = $('#organization').val();
            if(val==20){
                $.ajax({
                    type:"post",
                    url:"/menu/getFirstMenu.do",
                    success:function (data) {
                        var a = "";
                        for(var i = 0 ; i < data.length ; i++){
                            a = a + "<option value="+data[i].id+">"+data[i].name+"</option>";
                        }
                        $('#parentOrganization').html(a);
                        form.render();
                        $('#menuLabel,#menuList,#address').css('display','block');
                    }
                })
            }else{
                $('#menuLabel,#menuList').css('display','none').css('disabled','disabled');
                $('#parentOrganization').html("<option></option>");
                form.render();
            }
        })
        //监听提交
        form.on('submit(registerForm)', function(params){
            //表单数据
           /* var username = $("#username").val();
            var password = $("#password").val();
            var gender = $("input[name='gender']:checked").val();
            var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();
            $.ajax({
                type:"post",
                url:"/menu/addSureMenu.do",
                data:data,
                success:function(data){
                    if(data.result == "success"){
                        layer.msg('添加成功',{
                            icon:1,
                            time:1000
                        })
                    }else{
                        layer.msg('添加失败',{
                            icon:0,
                            time:1000
                        })
                    }
                }
            })
        });
    });
</script>
</body>
</html>