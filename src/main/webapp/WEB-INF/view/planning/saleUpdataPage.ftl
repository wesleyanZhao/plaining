<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
    <style>
        .down{
            margin-top: 10px;
        }
    </style>
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>菜单修改</legend>
<div class="layui-field-box" >
    <form class="layui-form">
        <input type="hidden" name="id" value="${result!''}"/>
        <input type="hidden" id="currentPage" name="currentPage" >
        <input type="hidden" id="conType" value="${params.conType!''}"/>
        <input type="hidden" id="spSlType" value="${params.spSlType!''}"/>
        <input type="hidden" id="supId" value="${params.supId!''}"/>
        <input type="hidden" id="segment" value="${params.segment!''}"/>
        <input type="hidden" id="conVipLevel" value="${params.conVipLevel!''}"/>
        <input type="hidden" id="isOtherConCombine" value="${params.isOtherConCombine!''}"/>
        <input type="hidden" id="isUsed" value="${params.isUsed!''}"/>

        <div class="layui-form-item">
            <label class="layui-form-label">促销条件编号</label>
            <div class="layui-input-inline">
                <input type="text" name="conNo"  class="layui-input" value="${(params.conNo)!''}" placeholder="请输入促销条件编号">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">条件名称</label>
            <div class="layui-input-inline">
                <input type="text" name="conName" class="layui-input" value="${(params.conName)!''}" placeholder="请输入条件名称" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">优惠类型</label>
            <div class="layui-input-inline">
                <select name="conType" id="conTypeS">
                    <option value="0" >请选择</option>
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
            <div class="layui-input-inline">
                <select name="spSlType" id="spSlTypeS">
                    <option value="" >请选择</option>
                    <option value="100">网站</option>
                    <option value="200">手机App</option>
                    <option value="300">线下</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">供应商</label>
            <div class="layui-input-inline">
                <select name="supId" id="supIdS">
                    <option value="0" >请选择</option>
                <#list supValue as item>
                    <option value="${item.supId}">${item.supName}</option>
                </#list>
                </select>
            </div>
        </div>

        <div class="layui-form-item">

            <label class="layui-form-label">使用环节</label>
            <div class="layui-input-inline">
                <select name="segment"  id="segmentS">
                    <option value="" >请选择</option>
                    <option value="10">支付前</option>
                    <option value="20">支付后</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">会员等级</label>
            <div class="layui-input-inline">
                <select name="conVipLevel"  id="conVipLevelS">
                    <option value="" >请选择</option>
                    <option value="1">一星</option>
                    <option value="2">二星</option>
                    <option value="3">三星</option>
                    <option value="4">四星</option>
                    <option value="5">五星</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">限制条件</label>
            <div class="layui-input-inline">
                <input type="text" name="conValue"  class="layui-input" value="${(params.conValue)!''}" placeholder="请输入限制条件">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否共存</label>
            <div class="layui-input-inline">
                <select name="isOtherConCombine" id="isOtherConCombineS">
                    <option value="" selected>请选择</option>
                    <option value="y">是</option>
                    <option value="n">否</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否使用</label>
            <div class="layui-input-inline">
                <select name="isUsed"  id="isUsedS">
                    <option value="" selected>请选择</option>
                    <option value="y">是</option>
                    <option value="n">否</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item down">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="registerForm">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
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

        var conType=$("#conType").val();
        var spSlType=$("#spSlType").val();
        var supId=$("#supId").val();

        var segment=$("#segment").val();
        var conVipLevel=$("#conVipLevel").val();
        var isOtherConCombine=$("#isOtherConCombine").val();
        var isUsed=$("#isUsed").val();
        if('0'==conType){
        }else if('10'==conType){
            $("#conTypeS option:eq(1)").attr("selected","selected");
        }else if('20'==conType){
            $("#conTypeS option:eq(2)").attr("selected","selected");
        }else if('30'==conType){
            $("#conTypeS option:eq(3)").attr("selected","selected");
        }else if('40'==conType){
            $("#conTypeS option:eq(4)").attr("selected","selected");
        }else if('50'==conType){
            $("#conTypeS option:eq(5)").attr("selected","selected");
        }else if('60'==conType){
            $("#conTypeS option:eq(6)").attr("selected","selected");
        }

        if('0'==spSlType){
        }else if('100'==spSlType){
            $("#spSlTypeS option:eq(1)").attr("selected","selected");
        }else if('200'==spSlType){
            $("#spSlTypeS option:eq(2)").attr("selected","selected");
        }else if('300'==spSlType){
            $("#spSlTypeS option:eq(3)").attr("selected","selected");
        }

        $("#supIdS option").each(function () {
            if($(this).val()==supId){
                $(this).attr("selected","selected");
            }
        })

        if('0'==segment){
        }else if('10'==segment){
            $("#segmentS option:eq(1)").attr("selected","selected");
        }else if('20'==segment){
            $("#segmentS option:eq(2)").attr("selected","selected");
        }

        if('0'==conVipLevel){
        }else if('1'==conVipLevel){
            $("#conVipLevelS option:eq(1)").attr("selected","selected");
        }else if('2'==conVipLevel){
            $("#conVipLevelS option:eq(2)").attr("selected","selected");
        }else if('3'==conVipLevel){
            $("#conVipLevelS option:eq(3)").attr("selected","selected");
        }else if('4'==conVipLevel){
            $("#conVipLevelS option:eq(4)").attr("selected","selected");
        }else if('5'==conVipLevel){
            $("#conVipLevelS option:eq(5)").attr("selected","selected");
        }
        if('0'==isOtherConCombine){
        }else if('y'==isOtherConCombine){
            $("#isOtherConCombineS option:eq(1)").attr("selected","selected");
        }else if('n'==isOtherConCombine){
            $("#isOtherConCombineS option:eq(2)").attr("selected","selected");
        }

        if('0'==isUsed){
        }else if('y'==isUsed){
            $("#isUsedS option:eq(1)").attr("selected","selected");
        }else if('n'==isUsed){
            $("#isUsedS option:eq(2)").attr("selected","selected");
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
                url: "/sale/saleUpdata.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){           //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    if (data.result == 'success'){   //如果成功了, 则关闭当前layer
                        layer.msg('修改成功',{
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                    },function(){//
                            //do something
                            //注册成功后，自动关闭当前注册页面
                            //先得到当前iframe层的索引
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            //parent.layer.closeAll("iframe");
                        });
                    }else{
                        layer.msg('修改失败!!!',{
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        },function(){//
                            //do something
                            //注册成功后，自动关闭当前注册页面
                            //先得到当前iframe层的索引
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                            //parent.layer.closeAll("iframe");
                        });


                    }
                }
            });
            return false;//return false 表示不通过页面刷新方式提交表单
        });
    })
</script>
</body>
</html>