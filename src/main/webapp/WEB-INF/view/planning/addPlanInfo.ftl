<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field">
    <legend>添加企划信息</legend>

    <div class="layui-field-box">
        <form class="layui-form">

            <div class="layui-form-item">
                <label class="layui-form-label">企划名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="spName" name="spName"  lay-verify="required" placeholder="请输入企划名称" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">商品类别</label>
                <div class="layui-input-inline">
                    <select id="tpCd" name="tpCd">
                        <option value=""></option>
                        <#list resultPrdType as resultPrdType>
                            <option value="${resultPrdType.tpCd!''}">${resultPrdType.tpNm!''}</option>
                        </#list>
                    </select>
                </div>

                <label class="layui-form-label">销售方式</label>
                <div  class="layui-input-inline">
                    <select  name="cpnTypeNo" id="cpnTypeNo" >
                        <option value="" selected="">请选择销售方式</option>
                        <option value="100">网站</option>
                        <option value="200">手机App</option>
                        <option value="300">线下</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <a class="layui-btn" id="addCpn">显示代金劵信息</a>
                </div>
            </div>
            <div class="layui-form-item"  id="vouCharCpn" hidden>
                <label class="layui-form-label">代金券</label>
                <div class="layui-input-block" id="vouChar">

                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">促销条件</label>
                    <div class="layui-input-inline">
                        <select id="conNo" name="conNo" lay-filter="conNo">
                            <option value=""></option>
                            <#list resultConNo as resultConNo >
                                <option value="${resultConNo.conNo}">${resultConNo.conName}</option>
                            </#list>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item"  id="discount" style="display: none">
                <div class="layui-inline">
                    <label class="layui-form-label">优惠</label>
                    <div class="layui-input-inline">
                        <select id="disNo" name="disNo">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item" id="sale" style="display: none">
                <div class="layui-inline">
                    <label class="layui-form-label">买赠</label>
                    <div class="layui-input-inline">
                        <select id="gNo" name="gNo">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">限额</label>
                <div class="layui-inline">
                    <select id="lmtNo" name="lmtNo">
                        <option value=""></option>
                        <#list resultLmtNo as resultLmtNo >
                            <option value="${resultLmtNo.lmtNo}">${resultLmtNo.lmtName}</option>
                        </#list>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">开始时间</label>
                    <div class="layui-input-inline">
                        <input id="startDate" name="startDate" class="layui-input" required placeholder="请选择开始时间" onclick="layui.laydate({elem: this})">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">结束时间</label>
                    <div class="layui-input-inline">
                        <input id="endDate" name="endDate" class="layui-input" required placeholder="请选择结束时间" onclick="layui.laydate({elem: this})">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">企划可用</label>
                <div class="layui-input-block">
                    <input type="radio" name="isUsedPB" value="y" title="可用" checked/>
                    <input type="radio" name="isUsedPB" value="n" title="不可用"/>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">类别可用</label>
                <div class="layui-input-block">
                    <input type="radio" name="isUsedSPR" value="y" title="可用" checked/>
                    <input type="radio" name="isUsedSPR" value="n" title="不可用"/>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">退换货</label>
                <div class="layui-input-block">
                    <input type="radio" name="isReturn" value="y" title="支持" checked/>
                    <input type="radio" name="isReturn" value="n" title="不支持"/>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="addPlanInfoForm">提交</button>
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


            $("#addCpn").on("click",function () {

                var tpCd=$("#tpCd").val();
                var conTypeNo=$("#cpnTypeNo").val();
                var data= {"tpCd":tpCd,"cpnTypeNo":conTypeNo};
                $("#vouCharCpn").removeAttr("hidden");
                $.ajax({
                    type:"post",
                    url:"/plan/addPlanInfoCpn.do",
                    data:data,
                    success:function(data){
                        $("#vouChar").html("");
                        for(var i=0;i<data.length;i++){
                            $("#vouChar").append("<input type='checkbox' title='"+data[i].cpnContent+"' value='"+data[i].cpnContent+"' name='cpnContent'/>");
                        }
                        form.render();
                    }
                });

            });


        //监听提交
        form.on('submit(addPlanInfoForm)', function(params){
            var data = $("form").serializeArray();
            $.ajax({
                type:"post",
                url:"/plan/addPlanInfoForm.do",
                data:data,
                success:function(data){
                    if(data.result == "success"){
                        layer.msg('添加成功',{
                            icon:1,
                            time:1000
                        })
                    }else{
                        layer.msg('添加失败')
                    }
                }
            });
            return false;
        });

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