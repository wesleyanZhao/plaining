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
        <input type="hidden" id="gNo" value="${params.vgNo!''}"/>
        <input type="hidden" id="gName" value="${params.vgName!''}"/>
        <input type="hidden" id="conName" value="${params.vconName!''}"/>
        <input type="hidden" id="tpName" value="${params.vtpName!''}"/>
        <input type="hidden" id="prdName" value="${params.vprdName!''}"/>

        <div class="layui-form-item">
            <label class="layui-form-label">买赠编号</label>
            <div class="layui-input-inline">
                <input type="text" name="gNo"  class="layui-input" value="${(params.vgNo)!''}" placeholder="请输入促销条件编号" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">买赠名称</label>
            <div class="layui-input-inline">
                <input type="text" name="gName" class="layui-input" value="${(params.vgName)!''}" placeholder="请输入条件名称" >
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">满减促销方式</label>
                <div class="layui-input-inline">
                    <select id="conNo" name="conNo" lay-filter="conNo"  >
                        <option value=" ">${params.vconName!''}</option>
                    <#list saleConAndPrdBsc.conNo as type>
                        <option value="${type.conNo}">${type.conName}</option>
                    </#list>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">赠品类别</label>
            <div class="layui-input-inline">
                <select id="tpCd" name="tpCd" lay-filter="findZeng">
                    <option value=" ">${params.vtpName!''}</option>
                <#list findBuyPresent.tpCd as type>
                    <option value="${type.tpCd}">${type.tpNm}</option>
                </#list>
                </select>
            </div>
            <label class="layui-form-label">赠品类别</label>
            <div class="layui-input-inline">
                <select id="prdNo" name="prdNo">
                    <option value=" ">${params.vprdName!''}</option>
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

        var conNo = "${(conNo)!''}";
        var tpCd = "${(tpCd)!''}";
        var prdNo = "${(prdNo)!''}";
        if(conNo!=''){
            $("#conNo option[value='"+conNo+"']").attr('selected','selected');
            form.render();
        }
        if(tpCd!=''){
            $("#tpCd option[value='"+tpCd+"']").attr('selected','selected');
            form.render();
        }
        if(prdNo!=''){
            $("#prdNo option[value='"+prdNo+"']").attr('selected','selected');
            form.render();
        }
        form.on('select(findZeng)',function () {
            var tpCd=$("#tpCd").val();
            $.ajax({
                type: "POST",
                url: "/present/findZeng.do?tpCd="+tpCd,  //后台程序地址
                success:function (data) {
                    // alert(data);
                    $("#prdNo").text("");
                    if(data.length!=0){
                        for(var i=0;i<data.length;i++){
                            var ka=" <option  value='"+data[i].prdNo+"' >"+data[i].prdName+"</option>";
                            $("#prdNo").append(ka);
                            form.render();
                        }
                    }else{
                        var ka=" <option  value='' >无</option>";
                        $("#prdNo").append(ka);
                        form.render();
                    }
                }
            })
            form.render();

        });


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
                url: "/present/UpdatePresent.do",  //后台程序地址
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