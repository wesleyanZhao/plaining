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
        <input type="hidden" name="id" value="${params.id!''}">
        <div class="layui-form-item">
            <label class="layui-form-label">优惠名称</label>
            <div class="layui-input-block">
                <input type="text" id="disName" name="disName" value="${params.disName!''}" required  lay-verify="required" placeholder="请输入优惠名称" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">优惠类型</label>
            <div id="menu" class="layui-input-inline">
                <select id="conType" name="conType" lay-filter="organization" >
                    <option value="">优惠类型</option>
                <#list list1 as item>
                    <option value="${item.conType}"><#if item.conType=='10'>满减<#elseif item.conType=='30'>返现<#elseif item.conType=='40'>立减<#elseif item.conType=='50'>折扣<#elseif item.conType=='60'>积分加倍</#if>
                    </option>
                </#list>
                </select>
            </div>
            <label class="layui-form-label">条件名称</label>
            <div id="menuList" class="layui-input-inline">
                <select id="conName" name="conName" lay-filter="parentOrganization">
                    <option value="">条件名称</option>
                        <#list list2 as item>
                            <option value="${item.conName!''}">${item.conName!''}
                            </option>
                        </#list>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">优惠值</label>
            <div class="layui-input-block">
                <input type="text" id="disValue" name="disValue" value="${(params.disValue)!''}" required  lay-verify="required" placeholder="请输入优惠值" autocomplete="off" class="layui-input">
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

    layui.use(['form','jquery','layer'], function(){
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;

        form.on('submit(registerForm)', function(params){
            var data = $("form").serializeArray();
            $.ajax({
                type: "POST",
                url: "/preInfo/preferentialUpdateFrom.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){
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
        $("#conType").find("option[value='${params.conType ! ''}']").attr("selected","selected");

        $("#conName").find("option[value='${params.conName ! ''}']").attr("selected","selected");

        form.render();
    });
</script>
</body>
</html>