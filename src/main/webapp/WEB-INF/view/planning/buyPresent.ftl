<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>商品管理系统 惠买ivalue后台管理</title>
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>

<body>
<form id="pageSubmit" class="layui-form" method="post">
    <input type="hidden" id="currentPage" name="currentPage" >
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">买赠名称</label>
            <div class="layui-input-inline">
                <input type="text" id="gName" name="gName" value="${(cond.gName)!''}" placeholder="请输入买赠名称" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">满减促销方式</label>
            <div class="layui-input-inline">
                <select id="conNo" name="conNo" lay-filter="conNo"  >
                    <option value=" ">请选择</option>
                <#list findBuyPresent.conNo as type>
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
                <option value=" ">请选择</option>
            <#list findBuyPresent.tpCd as type>
                <option value="${type.tpCd}">${type.tpNm}</option>
            </#list>
            </select>
        </div>
        <label class="layui-form-label">赠品类别</label>
        <div class="layui-input-inline">
            <select id="prdNo" name="prdNo">
                <option value=" ">请选择</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label"></label>
            <div class="layui-input-inline">
                <button class="layui-btn" lay-submit lay-filter="getProduct">查询</button>
            <#--<button type="reset" class="layui-btn layui-btn-primary">重置</button>-->
            </div>
        </div>
    </div>

</form>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>买赠查询</legend>
</fieldset>

<div class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="30">
            <col width="60">
            <col width="40">
            <col width="60">
            <col width="70">
            <col width="70">
        </colgroup>
        <thead>
        <tr>
            <th>买赠编号</th>
            <th>买赠名称</th>
            <th>满减促销方式</th>
            <th>赠品类别</th>
            <th>赠品名称</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <#list list as item>
            <tr>
                <#--<input id="hidTpCd" type="hidden" value="${item.tpCd}">-->
                <td>${item.gNo}</td>
                <td>${item.gName}</td>
                <td>${item.conName}</td>
                <td>${item.tpName}</td>
                <td>${item.prdName}</td>
                <td><a class="layui-btn layui-btn-radius amend"  vgNo="${item.gNo!''}" vgName="${item.gName!''}" vconName="${item.conName!''}" vtpName="${item.tpName!''}" vprdName="${item.prdName!''}" name="amend">更改</a>
                </td>
            </tr>
            </#list>
        </tbody>
    </table>
</div>
<div class="layui-form">
    <span id="form_page"></span>&nbsp;共${page.total}条数据
</div>

<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.define([ 'element', 'form', 'layer', 'laypage','laydate'], function(exports) {
        var element = layui.element();
        var form = layui.form();
        var layer = layui.layer;
        var laypage = layui.laypage;
        var $ = layui.jquery;
        var pindex = "${page.pageNum}";// 当前页
        var ptotalpages = "${page.pages}";// 总页数
        var pcount = "${page.total}";// 数据总数

        // 分页
        laypage({
            cont : 'form_page', // 页面上的id
            pages : ptotalpages,//总页数
            curr : pindex,//当前页。
            skip : true,
            jump : function(obj, first) {
                $("#currentPage").val(obj.curr);//设置当前页
                //$("#size").val(psize);
                //防止无限刷新,
                //只有监听到的页面index 和当前页不一样是才出发分页查询
                if (obj.curr != pindex ) {
                    $("#pageSubmit").submit();
                }
            }
        });

        var gName = "${(cond.gName)!''}";
        var conNo = "${(cond.conNo)!''}";
        var tpCd = "${(cond.tpCd)!''}";
        var prdNo = "${(cond.prdNo)!''}";
        if(conNo!=''){
            $("#conNo option[value='"+conNo+"']").attr('selected','selected');
            form.render();
        }
        if(tpCd!=''){
            $("#tpCd option[value='"+tpCd+"']").attr('selected','selected');
            form.render();
        }
        if(prdNo!=''){
            $("#prdName option[value='"+prdNo+"']").attr('selected','selected');
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
        $(".amend").on("click",function () {
            var vgNo = $(this).attr("vgNo");
            var vgName = $(this).attr("vgName");
            var vconName = $(this).attr("vconName");
            var vtpName = $(this).attr("vtpName");
            var vprdName = $(this).attr("vprdName");
            layer.open({
                title: '添加明细信息'
                ,area: ['800px', '700px']
                ,type: 2 //content内容为一个连接  1返回文字是啥返回啥 2 当页面打开
                ,content: '/present/presentUpdate.do?vgNo='+vgNo
                +'&&vgName='+vgName+'&&vconName='+vconName
                +'&&vtpName='+vtpName+'&&vprdName='+vprdName
            });
        });
//        form.on('select(getProduct)',function () {
//            return true;
//        })
    });
</script>
</body>
</html>