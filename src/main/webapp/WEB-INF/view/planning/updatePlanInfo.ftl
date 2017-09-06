<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>惠买企划管理系统</title>
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>企划操作</legend>
<div class="layui-field-box" >

    <form class="layui-form">

        <input type="hidden" id="pbId" name="pbId" value="${result.pbId ! ''}">

        <input type="hidden" id="spNo" name="spNo" value="${result.spNo ! ''}">

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">企划名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="spName" name="spName" value="${result.spName ! ''}" placeholder="请输入企划名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">促销条件</label>
                <div class="layui-input-inline">
                    <select id="conNo" name="conNo" lay-filter="conNo">
                        <option value="">请选择</option>
                        <#list resultConNo as resultConNo>
                            <option value="${resultConNo.conNo}">${resultConNo.conName}</option>
                        </#list>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item"  id="discount">
            <div class="layui-inline">
                <label class="layui-form-label">优惠</label>
                <div class="layui-input-inline">
                    <select id="disNo" name="disNo">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item" id="sale">
            <div class="layui-inline">
                <label class="layui-form-label">买赠</label>
                <div class="layui-input-inline">
                    <select id="gNo" name="gNo">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">限额</label>
            <div class="layui-inline">
                <select id="lmtNo" name="lmtNo">
                    <option value="">请选择</option>
                    <#list resultLmtNo as resultLmtNo >
                        <option value="${resultLmtNo.lmtNo}">${resultLmtNo.lmtName}</option>
                    </#list>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">代金券</label>
                <div class="layui-input-inline">
                    <select id="cpnNo" name="cpnNo">
                        <option value="">请选择</option>
                        <#list resultCpnNo as resultCpnNo>
                            <option value="${resultCpnNo.cpnNo}">${resultCpnNo.cpnContent}</option>
                        </#list>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">活动时间</label>
                <div class="layui-input-inline" style="width: 100px;">
                    <input name="startDate" id="startDate" value="${result.startDate ! ''}" placeholder="开始时间" class="layui-input" onclick="layui.laydate({elem: this})" autocomplete="off">
                </div>

                <div class="layui-form-mid">-</div>

                <div class="layui-input-inline" style="width: 100px;">
                    <input name="endDate" id="endDate" value="${result.endDate ! ''}" placeholder="结束时间" class="layui-input" onclick="layui.laydate({elem: this})" autocomplete="off">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">企划可用</label>
                <div class="layui-input-inline" id="isUsedPB">
                    <input type="radio" name="isUsedPB" value="y" title="可用">
                    <input type="radio" name="isUsedPB" value="n" title="不可用">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">支持退换货</label>
                <div class="layui-input-block" id="isReturn">
                    <input type="radio" name="isReturn" value="y" title="支持">
                    <input type="radio" name="isReturn" value="n" title="不支持">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="updatePlanInfoForm">确定</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>

    </form>
</div>
</fieldset>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script>
    layui.use(['form','jquery','layer','laydate'], function(){
        var $ = layui.jquery;
        var form = layui.form();
        var layer = layui.layer;

        //监听提交
        form.on('submit(updatePlanInfoForm)', function(params){
            var data = $("form").serializeArray();
            $.ajax({
                type: "POST",
                url: "/plan/updatePlanInfoForm.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){           //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    if (data.result == 'success'){   //如果成功了, 则关闭当前layer
                        layer.msg('成功',{
                            icon: 1,
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        },function(){
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                        });
                    }else {
                        layer.msg('失败')
                    }
                }
            });
            return false;//return false 表示不通过页面刷新方式提交表单
        });

        //将数据回显
        var disNo = "${result.disNo ! ''}";
        var disName = "${result.disName ! ''}";
        if('' == disNo){
            $("#discount").css("display","none");
        }else {
            $("#disNo").append("<option value='"+disNo+"' >"+disName+"</option>");
            $("#disNo").find("option[value='"+disNo+"']").attr("selected","selected");
        }

        //将数据回显
        var gNo = "${result.gNo ! ''}";
        var gName = "${result.gName ! ''}";
        if('' == gNo){
            $("#sale").css("display","none");
        }else{
            $("#gNo").append("<option value='"+gNo+"' >"+gName+"</option>");
            $("#gNo").find("option[value='"+gNo+"']").attr("selected","selected");
        }

        //动态赋值
        $("#conNo").find("option[value='${conNo ! ''}']").attr("selected","selected");
        $("#lmtNo").find("option[value='${lmtNo ! ''}']").attr("selected","selected");
        $("#cpnNo").find("option[value='${cpnNo ! ''}']").attr("selected","selected");

        //带回页面的select参数进行动态赋值
        var isUsedPB = "${result.isUsedPB ! ''}";
        var isReturn = "${result.isReturn ! ''}";

        // 是否使用动态赋值
        if(isUsedPB == 'y') {
            $("#isUsedPB").find("input[value = 'y']").attr("checked","checked");
        } else if(isUsedPB == 'n') {
            $("#isUsedPB").find("input[value = 'n']").attr("checked","checked");
        }

        //支持退换货动态赋值
        if(isReturn == 'y') {
            $("#isReturn").find("input[value = 'y']").attr("checked","checked");
        } else if(isReturn == 'n') {
            $("#isReturn").find("input[value = 'n']").attr("checked","checked");
        }

        // 重新渲染页面
        form.render();

        //监听促销的select
        form.on('select(conNo)',function () {
            var conNo=$("#conNo").val();
            $.ajax({
                type: "POST",
                url: "/plan/findConType.do?conNo="+conNo,
                success:function (data) {
                    var conType = data.conType;
                    if (conType == '20'){
                        $("#sale").css("display","block");
                        $("#discount").css("display","none");
                        $("#disNo").attr("disabled",true);
                        $("#gNo").attr("disabled",false);
                        $.ajax({
                            type: "POST",
                            url: "/plan/findGNo.do?conNo="+conNo,  //后台程序地址
                            success:function (resultGNo) {
                                $("#gNo").text("");
                                for(var i=0;i<resultGNo.length;i++){
                                    $("#gNo").append("<option value='"+resultGNo[i].gNo+"' >"+resultGNo[i].gName+"</option>");
                                    form.render();
                                }
                            }
                        });
                        form.render();
                    }else{
                        $("#discount").css("display","block");
                        $("#sale").css("display","none");
                        $("#gNo").attr("disabled",true);
                        $("#disNo").attr("disabled",false);
                        $.ajax({
                            type: "POST",
                            url: "/plan/findDisNo.do?conNo="+conNo,  //后台程序地址
                            success:function (resultDisNo) {
                                $("#disNo").text("");
                                for(var i=0;i<resultDisNo.length;i++){
                                    $("#disNo").append("<option value='"+resultDisNo[i].disNo+"' >"+resultDisNo[i].disName+"</option>");
                                    form.render();
                                }
                            }
                        });
                        form.render();
                    }
                }
            });
        });

    });
</script>
</body>
</html>