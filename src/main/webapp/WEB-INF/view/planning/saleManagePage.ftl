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
    <style>

    </style>
</head>

<form id="pageSubmit" class="layui-form">


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

            <label class="layui-form-label">条件名称</label>
            <div class="layui-input-inline">
                <input type="text" name="conName" class="layui-input" value="${(params.conName)!''}" placeholder="请输入条件名称" >
            </div>

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
            <label class="layui-form-label">销售渠道类型</label>
            <div class="layui-input-inline">
                <select name="spSlType" id="spSlTypeS">
                    <option value="0" >请选择</option>
                    <option value="100">网站</option>
                    <option value="200">手机App</option>
                    <option value="300">线下</option>
                </select>
            </div>

            <label class="layui-form-label">供应商</label>
            <div class="layui-input-inline">
                <select name="supId" id="supIdS">
                        <option value="0" >请选择</option>
                    <#list result as item>
                        <option value="${item.supId}">${item.supName}</option>
                    </#list>
                </select>
            </div>
    </div>

    <div class="layui-form-item">

            <label class="layui-form-label">使用环节</label>
            <div class="layui-input-inline">
                <select name="segment"  id="segmentS">
                    <option value="0" >请选择</option>
                    <option value="10">支付前</option>
                    <option value="20">支付后</option>
                </select>
            </div>

            <label class="layui-form-label">会员等级</label>
            <div class="layui-input-inline">
                <select name="conVipLevel"  id="conVipLevelS">
                    <option value="0" >请选择</option>
                    <option value="1">一星</option>
                    <option value="2">二星</option>
                    <option value="3">三星</option>
                    <option value="4">四星</option>
                    <option value="5">五星</option>
                </select>
            </div>

            <label class="layui-form-label">限制条件</label>
            <div class="layui-input-inline">
                <input type="text" name="conValue"  class="layui-input" value="${(params.conValue)!''}" placeholder="请输入限制条件">
            </div>

            <label class="layui-form-label">是否共存</label>
            <div class="layui-input-inline">
                <select name="isOtherConCombine" id="isOtherConCombineS">
                    <option value="0" selected>请选择</option>
                    <option value="y">是</option>
                    <option value="n">否</option>
                </select>
            </div>

            <label class="layui-form-label">是否使用</label>
            <div class="layui-input-inline">
                <select name="isUsed"  id="isUsedS">
                    <option value="0" selected>请选择</option>
                    <option value="y">是</option>
                    <option value="n">否</option>
                </select>
            </div>


    </div>
    <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit >提交</button>
            </div>
    </div>
</form>

<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>所有用户</legend>
</fieldset>


<div class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="10">
            <col width="100">
            <col width="120">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="150">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
        </colgroup>
        <thead>
        <tr>
            <th>ID</th>
            <th>促销条件编号</th>
            <th>条件名称</th>
            <th>优惠类型</th>
            <th>销售渠道类型</th>
            <th>参与供应商</th>
            <th>使用环节</th>
            <th>适用会员等级</th>
            <th>限定条件</th>
            <th>是否可与其他促销条件共存</th>
            <th>是否可用</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <#list list as item>
            <tr>
                <td>${item.Id}</td>
                <td>${item.conNo}</td>
                <td>${item.conName}</td>
                <td>
                    <#if item.conType=='10'>
                        满减
                    <#elseif item.conType=='20'>
                        满赠
                    <#elseif item.conType=='30'>
                        返现
                    <#elseif item.conType=='40'>
                        立减
                    <#elseif item.conType=='50'>
                        折扣
                    <#elseif item.conType=='60'>
                        积分加倍
                    </#if>
                </td>
                <td>
                    <#if item.spSlType=='100'>
                            网站
                        <#elseif item.spSlType=='200'>
                            手机App
                        <#elseif item.spSlType=='300'>
                            线下
                    </#if>
                </td>
                <td>${item.supName!''}</td>
                <td>
                    <#if item.segment=='10'>
                                支付前
                        <#else> 支付后
                    </#if>
                </td>
                <td>
                    <#if item.conVipLevel==1>
                            一星
                        <#elseif item.conVipLevel==2>
                            二星
                        <#elseif item.conVipLevel==3>
                            三星
                        <#elseif item.conVipLevel==4>
                            四星
                        <#elseif item.conVipLevel==5>
                            五星
                    </#if>
                </td>
                <td>${item.conValue}</td>
                <td>
                    <#if item.isOtherConCombine=='y'>
                        是
                        <#else>否
                    </#if>
                </td>
                <td>
                    <#if item.isUsed=='y'>
                        使用
                    <#else>不使用
                    </#if>
                </td>
                <td>
                    <a class="managePageUpdate"  menuId="${item.Id}">
                        信息修改
                    </a>
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
    layui.use(['jquery','form'],function (){
            var $=layui.jquery;
            var form=layui.form();

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

    })

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
        //信息修改弹出框
        $(".managePageUpdate").on("click",function () {
            var id=$(this).attr("menuId");
            //alert(id);
            layer.open({
                title: '促销条件修改 - 惠买ivalue管理系统'
                ,area: ['500px', '400px']
                ,type: 2 //content内容为一个连接
                ,content: "/sale/saleUpdataPage.do?id="+id
            });
        });
    });
</script>
</body>
</html>