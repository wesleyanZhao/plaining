<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>添加买赠</legend>
<div class="layui-field-box" >
    <form id="form" class="layui-form">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">买赠名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="gName" name="gName" required  lay-verify="required" placeholder="请输入买赠名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">满减促销方式</label>
                <div class="layui-input-inline">
                    <select id="conNo" name="conNo" lay-filter="conNo" lay-verify="required" >
                    <#list saleConAndPrdBsc.conNo as type>
                        <option value="${type.conNo}">${type.conName}</option>
                    </#list>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品类别</label>
            <div class="layui-input-inline">
                <select id="tpCd" name="tpCd" lay-filter="findZeng">
                    <option value=" ">请选择</option>
                <#list findBuyPresent.tpCd as type>
                    <option value="${type.tpCd}">${type.tpNm}</option>
                </#list>
                </select>
            </div>
            <label class="layui-form-label">赠品类别</label>
            <div class="layui-input-inline">
                <select id="gPrdNo" name="gPrdNo">
                    <option value=" ">请选择</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="addProduct">提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
</fieldset>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script>

    layui.use(['laydate','form','jquery','layer'],function () {
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;


        form.on('submit(addProduct)',function () {
            var data = $('form').serializeArray();

            $.ajax({
                url:"/present/addPresentForm.do",
                data:data,
                type:"post",
                success:function (data) {
                    if(data.result == "success"){
                        layer.msg('添加成功',{
                            icon: 1,
                            time: 1000
                        });
                    }else if(data.result == "error"){
                        layer.msg('添加失败',{
                            icon:0,
                            time:1000
                        });
                    }
                }
            })
            return false;
        })
        var tpCd = "${(tpCd)!''}";
        var gPrdNo = "${(gPrdNo)!''}";
        if(tpCd!=''){
            $("#tpCd option[value='"+tpCd+"']").attr('selected','selected');
            form.render();
        }
        if(gPrdNo!=''){
            $("#gPrdNo option[value='"+gPrdNo+"']").attr('selected','selected');
            form.render();
        }
        form.on('select(findZeng)',function () {
            var tpCd=$("#tpCd").val();
            $.ajax({
                type: "POST",
                url: "/present/findZeng.do?tpCd="+tpCd,  //后台程序地址
                success:function (data) {
                    // alert(data);
                    $("#gPrdNo").text("");
                    if(data.length!=0){
                        for(var i=0;i<data.length;i++){
                            var ka=" <option  value='"+data[i].prdNo+"' >"+data[i].prdName+"</option>";
                            $("#gPrdNo").append(ka);
                            form.render();
                        }
                    }else{
                        var ka=" <option  value='' >无</option>";
                        $("#gPrdNo").append(ka);
                        form.render();
                    }
                }
            })
            form.render();

        });
    });

</script>
</body>
</html>