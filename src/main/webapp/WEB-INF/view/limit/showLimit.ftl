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
<div class="layui-field-box" >
    <form class="layui-form" id="pageSubmit" method="post">
        <input type="hidden" id="currentPage" name="currentPage" >
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">限额名字</label>
                <div class="layui-input-inline">
                    <input type="text" name="lmtName" value="${(params.lmtName)! ''}" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">限额类别</label>
                <div class="layui-input-block">
                    <select name="lmtType" id="ku"  >
                        <option value=" ">请选择</option>
                        <option value="10">库存</option>
                        <option value="20">毛利</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">是否使用</label>
                <div class="layui-input-inline">
                    <select name="isUsed" id="isUsed"  >
                        <option value=" ">请选择</option>
                        <option value="y">是</option>
                        <option value="n">否</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="selectMenu">立即提交</button>
                </div>
            </div>

        </div>
    </form>
</div>


<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>所有用户</legend>
</fieldset>

<div class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="50">
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
            <th>限额编号</th>
            <th>限额名字</th>
            <th>限额类别</th>
            <th>限额数值</th>
            <th>是否可用</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <#list list as item>
            <tr>
                <td>${item.id}</td>
                <td>${item.lmtNo}</td>
                <td>${item.lmtName}</td>
                <td>
                    <#if item.lmtType=='10'>库存
                    <#else>毛利
                    </#if>
                </td>
                <td>${item.lmtCount!''}</td>
                <td>
                    <#if item.isUsed=='y'>是
                    <#else>否
                    </#if>
                </td>

                <td  class="rasc"   itemId="${item.id}"  lmtName="${item.lmtName}" lmtCount="${item.lmtCount!''}"  lmtType="${item.lmtType}" isUsed ="${item.isUsed}">修改</td>
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


        var lmtType = "${params.lmtType ! ''}";
        var isUsed = "${params.isUsed ! ''}";
        if(lmtType=='1'){
            $("#ku").find("option[value='1']").attr('selected','selected');
        }else if(lmtType=='0'){
            $("#ku").find("option[value='0']").attr('selected','selected');

        }
        if(isUsed=='y'){
            $("#isUsed").find("option[value='y']").attr('selected','selected');
        }else if(isUsed=='n'){
            $("#isUsed").find("option[value='n']").attr('selected','selected');
                              }
        form.render();


        $(".rasc").on("click",function(){
            var id=$(this).attr("itemId");
            var lmtName=$(this).attr("lmtName");
            var lmtCount=$(this).attr("lmtCount");
            var lmtType=$(this).attr("lmtType");
            var isUsed = $(this).attr("isUsed")
          layer.open({
               title: '注册 - 惠买ivalue管理系统'
               ,area: ['400px', '500px']
               ,type: 2 //content内容为一个连接
              ,content: '/lim/alter.do?id='+id+ '&&lmtName=' + lmtName+ '&&lmtCount=' + lmtCount+ '&&lmtType=' + lmtType + '&&isUsed=' + isUsed
           });
        });
    });
</script>
</body>
</html>