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
<div class="layui-field-box" >
    <form id="pageSubmit" class="layui-form">
        <input type="hidden" id="currentPage" name="currentPage" >
        <#list list as item>
        <input type="hidden" id="conNo" name="conNo" value="${item.conNo}">
        </#list>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">优惠名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="disName" name="disName" value="${params.disName!''}" placeholder="请输入优惠名称" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">优惠值</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="disValue1" value="${params.disValue1!''}" placeholder="区" id="disValue1">
                </div>
                <div class="layui-input-inline">
                    <input class="layui-input" name="disValue2" value="${params.disValue2!''}" placeholder="间" id="disValue2">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">优惠类型</label>
                <div class="layui-input-inline">
                    <select id="conType" name="conType" lay-filter="organization" >
                        <option value="666" selected="">请选择</option>
                    <#list list1 as item>
                        <option value="${item.conType}"><#if item.conType=='10'>满减<#elseif item.conType=='30'>返现<#elseif item.conType=='40'>立减<#elseif item.conType=='50'>折扣<#elseif item.conType=='60'>积分加倍</#if>
                        </option>
                    </#list>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">条件名称</label>
                <div id="menuList" class="layui-input-inline">
                    <select id="conName" name="conName" lay-filter="parentOrganization">
                        <option value="666" selected="">请选择</option>
                    <#list list2 as item>
                        <option value="${item.conName}">${item.conName}
                        </option>
                    </#list>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label"></label>
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="getProduct">查询</button>
                </div>
            </div>
        </div>


    </form>
</div>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>所有用户</legend>
</fieldset>

<div class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="100">
        </colgroup>
        <thead>
        <tr>
            <th>优惠编号</th>
            <th>优惠名称</th>
            <th>优惠类型</th>
            <th>条件名称</th>
            <th>优惠值</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <#list list as item>
                <tr>
                    <td>${item.disNo}</td>
                    <td>${item.disName}</td>
                    <td>
                        <#if item.conType=='10'>满减
                        <#elseif item.conType=='20'>满赠
                        <#elseif item.conType=='30'>返现
                        <#elseif item.conType=='40'>立减
                        <#elseif item.conType=='50'>折扣
                        <#elseif item.conType=='60'>积分加倍
                        </#if>
                    </td>
                    <td>${item.conName}</td>
                    <td>${item.disValue}</td>
                    <td>
                        <a class="operate" val="${item.id}" vac="${item.disName!''}"
                           vaa="${item.conName}" vad="${item.conNo}" vae="${item.conType}"
                           vab="${item.disValue}" name="operate">
                            更改
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

    layui.define([ 'element','jquery', 'form', 'layer', 'laypage'], function(exports) {
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
        $('.operate').on('click', function(){
            var id=$(this).attr("val");
            var conName=$(this).attr("vaa");
            var disValue=$(this).attr("vab");
            var disName=$(this).attr("vac");
            var conNo=$(this).attr("vad");
            var conType=$(this).attr("vae");
            layer.open({
                title: '修改个人信息'
                ,area: ['400px', '500px']
                ,type: 2 //content内容为一个连接

                ,content: '/preInfo/preferentialUpdate.do?conName='+conName
                +'&&disValue='+disValue+'&&disName='+disName
                +'&&id='+id+'&&conNo='+conNo+'&&conType='+conType

            });
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