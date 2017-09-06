<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>添加优惠信息</legend>
<div class="layui-field-box" >
    <form class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">优惠名称</label>
            <div class="layui-input-inline">
                <input type="text" id="disName" name="disName" required  lay-verify="required" placeholder="请输入优惠名称" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">优惠类型</label>
            <div id="menu" class="layui-input-inline">
                <select id="conType" name="conType" lay-filter="organization" lay-verify="required" >
                    <option value="">优惠类型</option>
                    <#list list as item>
                        <option value="${item.conType}"><#if item.conType=='10'>满减<#elseif item.conType=='20'>满赠<#elseif item.conType=='30'>返现<#elseif item.conType=='40'>立减<#elseif item.conType=='50'>折扣<#elseif item.conType=='60'>积分加倍</#if>
                        </option>
                    </#list>
                </select>
            </div>
        <label class="layui-form-label">条件名称</label>
        <div id="menuList" class="layui-input-inline">
            <select id="conName" name="conName" lay-filter="parentOrganization">
                <option value="">条件名称</option>
            </select>
        </div>
        </div>

        <div id="address" class="layui-form-item">
            <label class="layui-form-label">优惠值</label>
            <div class="layui-input-inline">
                <input type="text" id="disValue" name="disValue" placeholder="请输入优惠值" autocomplete="off" class="layui-input">
            </div>
        </div>

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

        form.on('select(organization)',function () {
            var val = $('#conType').val();
            $.ajax({
                type:"post",
                url:"/preInfo/conditionName.do?conType="+val,
                success:function (data) {
                    console.log(data);
                    $('#conName').text("");
                    for(var i = 0 ; i < data.length ; i++){
                        var a="<option value="+data[i].name+">"+data[i].name+"</option>";
                        $('#conName').append(a);
                    }
                    form.render();
                }
            })

        });

        //监听提交
        form.on('submit(registerForm)', function(params){
            //表单数据

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();
            $.ajax({
                type:"post",
                url:"/preInfo/addPreferential.do",
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