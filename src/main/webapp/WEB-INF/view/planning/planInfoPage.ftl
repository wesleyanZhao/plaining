<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>惠买企划管理系统</title>
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<form id="pageSubmit" class="layui-form">

    <input type="hidden" id="currentPage" name="currentPage"/>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">企划名称</label>
            <div class="layui-input-inline">
                <input type="text" id="spName" name="spName" value="${params.spName ! ''}" placeholder="请输入企划名称" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">促销条件</label>
            <div class="layui-input-inline">
                <select id="conNo" name="conNo">
                    <option value=""></option>
                    <#list resultConNo as resultConNo>
                        <option value="${resultConNo.conNo}">${resultConNo.conName}</option>
                    </#list>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">活动时间</label>
            <div class="layui-input-inline" style="width: 100px;">
                <input name="startDate" id="startDate" value="${params.startDate ! ''}" placeholder="开始时间" class="layui-input" onclick="layui.laydate({elem: this})" autocomplete="off">
            </div>

            <div class="layui-form-mid">-</div>

            <div class="layui-input-inline" style="width: 100px;">
                <input name="endDate" id="endDate" value="${params.endDate ! ''}" placeholder="结束时间" class="layui-input" onclick="layui.laydate({elem: this})" autocomplete="off">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">代金券</label>
            <div class="layui-input-inline">
                <select id="cpnNo" name="cpnNo">
                    <option value=""></option>
                    <#list resultCpnNo as resultCpnNo>
                        <option value="${resultCpnNo.cpnNo}">${resultCpnNo.cpnContent}</option>
                    </#list>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">企划可用</label>
            <div class="layui-input-inline">
                <select id="isUsedPB" name="isUsedPB">
                    <option value="" selected></option>
                    <option value="y">可用</option>
                    <option value="n">不可用</option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">支持退换货</label>
            <div class="layui-input-block">
                <select id="isReturn" name="isReturn">
                    <option value="" selected></option>
                    <option value="y">支持</option>
                    <option value="n">不支持</option>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="planInfoPageForm">搜索</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>企划信息</legend>
</fieldset>

<div class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="20">
            <col width="70">
            <col width="70">
            <col width="70">
            <col width="70">
            <col width="70">
            <col width="70">
            <col width="80">
            <col width="80">
            <col width="80">
            <col width="70">
            <col width="70">
            <col width="100">

            <col>
        </colgroup>
        <thead>
            <tr>
                <th>ID</th>
                <th>企划编号</th>
                <th>企划名称</th>
                <th>促销条件</th>
                <th>优惠</th>
                <th>买赠</th>
                <th>限额</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>企划可用</th>
                <th>退换货</th>
                <th>代金券</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <#list list as item>
                <tr>
                    <td>${item.pbId}</td>
                    <td>${item.spNo}</td>
                    <td>${item.spName}</td>
                    <td>${item.conName}</td>
                    <td>${item.disName ! ''}</td>
                    <td>${item.gName ! ''}</td>
                    <td>${item.lmtName ! ''}</td>
                    <td>${item.startDate}</td>
                    <td>${item.endDate}</td>
                    <td>
                        <#if item.isUsedPB=='y'>可用
                        <#elseif item.isUsedPB=='n'>不可用
                        </#if>
                    </td>
                    <td>
                        <#if item.isReturn=='y'>支持
                        <#elseif item.isReturn=='n'>不支持
                        </#if>
                    </td>
                    <td>${item.cpnContent ! ''}</td>

                    <td>
                        <a class="layui-btn layui-btn-radius updatePlanInfo" pbId = "${item.pbId}">管理</a>
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
    layui.define([ 'element', 'form', 'layer', 'laypage' , 'laydate'], function(exports) {
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

        //数据回显
        $("#conNo").find("option[value='${conNo ! ''}']").attr("selected","selected");
        $("#cpnNo").find("option[value='${cpnNo ! ''}']").attr("selected","selected");

        //动态赋值
        var isUsedPB = "${params.isUsedPB ! ''}";
        var isReturn = "${params.isReturn ! ''}";

        if(isUsedPB == 'y') {
            $("#isUsedPB").find("option[value = 'y']").attr("selected","selected");
        } else if(isUsedPB == 'n') {
            $("#isUsedPB").find("option[value = 'n']").attr("selected","selected");
        }

        if(isReturn == 'y') {
            $("#isReturn").find("option[value = 'y']").attr("selected","selected");
        } else if(isReturn == 'n') {
            $("#isReturn").find("option[value = 'n']").attr("selected","selected");
        }

        //重新渲染
        form.render();

        //弹出修改框
        $(".updatePlanInfo").on("click",function () {
            var pbId = $(this).attr("pbId");
            layer.open({
                title: '添加明细信息'
                ,area: ['800px', '700px']
                ,type: 2 //content内容为一个连接  1返回文字是啥返回啥 2 当页面打开
                ,content: '/plan/updatePlanInfo.do?pbId='+pbId
            });
        });

    });
</script>
</body>
</html>