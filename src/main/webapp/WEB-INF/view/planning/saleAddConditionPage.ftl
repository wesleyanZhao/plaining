<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>添加新菜单</legend>
    <div class="layui-field-box" >
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">条件名称</label>
                <div class="layui-input-inline">
                    <input type="text"  name="conName"  required  lay-verify="required" placeholder="请输入条件名称"  class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">优惠类型</label>
                <div id="menu" class="layui-input-inline">
                    <select  name="conType"  lay-verify="required" >
                        <option value="0" selected="">请选择</option>
                        <option value="10">满减</option>
                        <option value="20">满赠</option>
                        <option value="30">返现</option>
                        <option value="40">立减</option>
                        <option value="50">折扣</option>
                        <option value="60">积分加倍</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">销售渠道类型</label>
                <div id="menu" class="layui-input-inline">
                    <select  name="spSlType"  lay-verify="required" >
                        <option value="" selected="">请选择级别</option>
                        <option value="100">网站</option>
                        <option value="200">手机App</option>
                        <option value="300">线下</option>
                    </select>
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">供应商</label>
                <div id="menu" class="layui-input-inline">
                    <select id="use" name="supId" lay-filter="isUsed"  >
                        <option value="0" selected="">请选择</option>
                    <#list params as item>
                        <option value="${item.supId}">${item.supName}</option>
                    </#list>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">使用环节</label>
                <div id="menu" class="layui-input-inline">
                    <select id="use" name="segment" lay-filter="isUsed" lay-verify="required" >
                        <option value="" selected="">请选择</option>
                        <option value="10">支付前</option>
                        <option value="20">支付后</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">使用会员等级</label>
                <div id="menu" class="layui-input-inline">
                    <select id="use" name="conVipLevel" lay-filter="isUsed" lay-verify="required" >
                        <option value="" selected="">请选择</option>
                        <option value="1">一星</option>
                        <option value="2">二星</option>
                        <option value="3">三星</option>
                        <option value="4">四星</option>
                        <option value="5">五星</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">限定条件</label>
                <div class="layui-input-inline">
                    <input type="text" name="conValue"
                           placeholder="请输入限定条件"  class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">是否可与其他促销条件共存
                </label>
                <div id="menu" class="layui-input-inline">
                    <select id="use" name="isOtherConCombine" lay-filter="isUsed" lay-verify="required" >
                        <option value="" selected="">请选择</option>
                        <option value="y">是</option>
                        <option value="n">否</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">是否使用</label>
                <div id="menu" class="layui-input-inline">
                    <select id="use" name="isUsed" lay-filter="isUsed"
                            lay-verify="required" >
                        <option value="" selected="">请选择</option>
                        <option value="y">使用</option>
                        <option value="n">禁用</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="insertMenuForm">立即提交</button>
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
        form.on('submit(insertMenuForm)', function(params){
            //表单数据
            /* var username = $("#username").val();
             var password = $("#password").val();
             var gender = $("input[name='gender']:checked").val();
             var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();

            $.ajax({
                type: "POST",
                url: "/sale/insertSaleValue.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){
                    //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    console.log(data);
                    if (data == 'success'){   //如果成功了, 则关闭当前layer
                        layer.msg('提交成功');
                    }
                }
            });
            return false;//return false 表示不通过页面刷新方式提交表单
        });
    });
</script>
</body>
</html>