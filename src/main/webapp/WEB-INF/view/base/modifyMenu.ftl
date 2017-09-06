<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>修改菜单</legend>
<div class="layui-field-box" >
    <form class="layui-form">
        <input type="hidden" name="id" value="${(menuInfo.id)!''}">
        <div class="layui-form-item">
            <label class="layui-form-label">菜单名称</label>
            <div class="layui-input-block">
                <input type="text" id="username" name="name" value="${(menuInfo.name)!''}" required  lay-verify="required" placeholder="请输入菜单名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜单地址</label>
            <div class="layui-input-inline">
                <input type="text" id="url" name="url" value="${(menuInfo.url)!''}" placeholder="请输入地址" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜单级别</label>
            <div id="menu" class="layui-input-inline">
                <input id="menuLevel" type="hidden" value="${(menuInfo.pId)}">
                <select id="organization" name="organization" lay-filter="organization" lay-verify="required" >
                    <option value="1">一级菜单</option>
                    <option value="2">二级菜单</option>
                </select>
            </div>
            <label id="menuLabel" class="layui-form-label">所属菜单</label>
            <div id="menuList" class="layui-input-inline">
                <select id="parentOrganization" name="organizationOne" lay-filter="parentOrganization">
                    <option></option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否使用</label>
            <div id="menu" class="layui-input-inline">
                <input id="isUsed" type="hidden" value="${(menuInfo.isUsed)!''}">
                <select id="use" name="isUsed" lay-filter="isUsed" lay-verify="required" >
                    <option value="y">使用</option>
                    <option value="n">禁用</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="registerForm">保存</button>
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


        form.on('select(organization)',function () {
            var val = $('#organization').val();

            if(val==2){
                $.ajax({
                    type:"post",
                    url:"/menu/getFirstMenu.do",
                    success:function (data) {
                        var a = "";
                        for(var i = 0 ; i < data.length ; i++){
                            if(val==data[i].id){
                                a = a + "<option value="+data[i].id+" selected>"+data[i].name+"</option>";
                                continue;
                            }
                            a = a + "<option value="+data[i].id+">"+data[i].name+"</option>";
                        }
                        $('#parentOrganization').html(a);
                        $('#organization option:eq(1)').attr('selected','selected');
                        form.render();
                        $('#menuLabel,#menuList,#address').css('display','block');
                    }
                })
            }else{
                $('#organization option:eq(0)').attr('selected','selected');
                $('#menuLabel,#menuList').css('display','none').css('disabled','disabled');
                $('#parentOrganization').html("<option></option>");
                form.render();
            }
        })

        var val = $('#menuLevel').val();

        if(val!=0){
            $('#organization option:eq(1)').attr('selected','selected');
            $.ajax({
                type:"post",
                url:"/menu/getFirstMenu.do",
                success:function (data) {
                    var a = "";
                    for(var i = 0 ; i < data.length ; i++){
                        if(val==data[i].id){
                            a = a + "<option value="+data[i].id+" selected>"+data[i].name+"</option>";
                            continue;
                        }
                        a = a + "<option value="+data[i].id+">"+data[i].name+"</option>";
                    }
                    $('#parentOrganization').html(a);
                    form.render();
                    $('#menuLabel,#menuList,#address').css('display','block');
                }
            });
        }else{
            $('#organization option:eq(0)').attr('selected','selected');
            $('#organization').attr('disabled','disabled');
            $('#menuLabel,#menuList').css('display','none').css('disabled','disabled');
            $('#parentOrganization').html("<option></option>");
            form.render();
        }

        var isUsed = $('#isUsed').val();

        if(isUsed=='y'){
            $('#use option:eq(0)').attr('selected','selected');
        }else{
            $('#use option:eq(1)').attr('selected','selected');
        }
        form.render();
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
                type: "POST",
                url: "/menu/modifyMenu.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){           //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    if(data.result == 'success'){
                        layer.msg('修改成功',{
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        },function(){
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                        });
                    }else{
                        layer.msg('修改失败',{
                            icon:0,
                            time:1000
                        })
                    }
                }
            });
            return false;//return false 表示不通过页面刷新方式提交表单
        });
    });
</script>
</body>
</html>