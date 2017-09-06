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
<form id="queryForm" class="layui-form">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">菜单名称</label>
            <div class="layui-input-inline">
                <input type="tel" name="name" lay-verify="phone" autocomplete="off" class="layui-input" value="${(cond.name)!''}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">菜单地址</label>
            <div class="layui-input-inline">
                <input type="text" name="url" lay-verify="email" autocomplete="off" class="layui-input" value="${(cong.url)!''}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">菜单级别</label>
            <div id="menu" class="layui-input-inline">
                <input id="organizationLevel" type="hidden" value="${(cond.organization)!''}">
                <select id="organization" name="organization" lay-filter="organization" lay-verify="required">
                    <option value=" ">请选择</option>
                    <option value="1">一级菜单</option>
                    <option value="2">二级菜单</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">是否使用</label>
            <div id="menu" class="layui-input-inline">
                <input id="isUsedVal" type="hidden" value="${(cond.isUsed)!''}">
                <select id="use" name="isUsed" lay-filter="organization" lay-verify="required">
                    <option value=" ">请选择</option>
                    <option value="y">使用</option>
                    <option value="n">禁用</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-input-inline">
                <button class="layui-btn" lay-filter="query">查询</button>
            </div>
        </div>
    </div>
</form>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>所有菜单</legend>
</fieldset>

<div class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="50">
            <col width="100">
            <col width="100">
            <col width="150">
            <col width="100">
            <col width="50">
        </colgroup>
        <thead>
        <tr>
            <th>菜单名字</th>
            <th>菜单级别</th>
            <th>父级菜单</th>
            <th>菜单地址</th>
            <th>是否使用</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <#list list as item>
            <tr>
                <td>${item.name}</td>
                <td>
                    <#if item.pId=0>一级菜单
                        <#else >二级菜单
                    </#if>
                </td>
                <td>
                    <#if item.pId=0>无
                        <#else>${item.pname}
                    </#if>
                </td>
                <td>${item.url}</td>
                <td>
                    <#if item.isUsed='y'>使用
                        <#else >禁用
                    </#if>
                </td>
                <td><a class="update" val="${item.id}" href="javascript:;">修改</a></td>
            </tr>
            </#list>
        </tbody>
    </table>
</div>
<div class="layui-form">
    <span id="form_page"></span>&nbsp;共${page.total}条数据
</div>
<form id="pageSubmit">
    <input type="hidden" id="currentPage" name="currentPage" >
</form>
<script type="text/javascript" src="/resources/layui/layui.js"></script>
<script type="text/javascript">

    layui.use(['jquery','layer'],function () {
        var $ = layui.jquery;
        var layer = layui.layer;

        var organization = $('#organizationLevel').val();
        var isUsed = $('#isUsedVal').val();
//        if(organization==''){
//        }else if(organization=='1'){
//            $('#organization option:eq(0)').attr('selected','selected');
//        }else{
//            $('#organization option:eq(1)').attr('selected','selected');
//        }

        if(organization=='1'){
            $('#organization option:eq(1)').attr('selected','selected');
        }else if(organization=='2'){
            $('#organization option:eq(2)').attr('selected','selected');
        }else{
            $('#organization option:eq(0)').attr('selected','selected');
        }

//        if(isUsed=='n'){
//            $('#ban').attr('checked','checked');
//        }else {
//            $('#use').attr('checked','checked');
//        }
        if(isUsed == 'n'){
            $('#use option:eq(2)').attr('selected','selected')
        }else if(isUsed == 'y'){
            $('#use option:eq(1)').attr('selected','selected');
        }else{
            $('#use option:eq(0)').attr('selected','selected');
        }

        $('.update').on('click',function () {
            var id = $(this).attr('val');
            layer.open({
                title:'修改菜单'
                ,area:['400px','500px']
                ,type:2
                ,content:"/menu/toModifyMenu.do?id="+id
            })
        })

    })



    layui.define([ 'element', 'form', 'layer', 'laypage'], function(exports) {

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

        form.on('select(query)',function () {
            return true;
        })
    });
</script>
</body>
</html>