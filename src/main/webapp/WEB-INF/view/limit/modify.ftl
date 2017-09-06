<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/layui/css/layui.css">
</head>
<body>
<fieldset class="layui-elem-field" >
    <legend>修改</legend>
    <div class="layui-field-box" >
        <form class="layui-form">

            <div class="layui-form-item">
                <label class="layui-form-label">限额名字</label>
                <div class="layui-input-block">
                    <input type="text"  name="lmtName"  value="${lmtName ! ''}"  required  lay-verify="required" placeholder="请限额名字" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">限额类别</label>
                    <div class="layui-input-block">
                        <select name="lmtType" id="ku" lay-filter="kuu">
                            <option value=" ">请选择</option>
                            <option value="10">库存</option>
                            <option value="20">毛利</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">限额数值</label>
                <div class="layui-input-block">
                    <input type="text" id="num" name="lmtCount" value="${lmtCount ! ''}" placeholder="限额数值" autocomplete="off" class="layui-input">
                </div>
                <input type="hidden" name="id" value="#{id }"/>
            </div>


            <div class="layui-inline">
                <label class="layui-form-label">是否使用</label>
                <div class="layui-input-inline">
                    <select name="isUsed" id="isUsed" >
                        <option value="y">是</option>
                        <option value="n">否</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="alterLimit">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
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

        //监听提交
        form.on('submit(alterLimit)', function(params){
            //表单数据
            /* var username = $("#username").val();
             var password = $("#password").val();
             var gender = $("input[name='gender']:checked").val();
             var organization = $("#organization").val();*/

            //等同于上面注释掉的部分
            var data = $("form").serializeArray();

            $.ajax({
                type: "POST",
                url: "/lim/alterLimit.do",  //后台程序地址
                data: data,  //需要post的数据
                success: function(data){           //后台程序返回的标签，比如我喜欢使用1和0 表示成功或者失败
                    if (data.result == 'success'){   //如果成功了, 则关闭当前layer
                        layer.msg('注册成功',{
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

        //当为毛利的时候，则不能输入
        var lmtType = "${lmtType ! ''}";
            if(lmtType=='20'){
                $("#num").attr("disabled",true);
            }else if(lmtType=='10'){
                $("#num").removeAttr("disabled");
            }

     //在选择框的时候为毛利，则不能输入
        form.on('select(kuu)', function(){
          var ku=$("#ku").val();
           layer.msg(ku)
            if(ku=='20'){
                $("#num").attr("disabled",true);
            }else if(ku=='10'){
                $("#num").removeAttr("disabled");
            }
        });


        var lmtType = "${lmtType ! ''}";
        var isUsed = "${isUsed ! ''}";
        if(lmtType=='10'){
            $("#ku").find("option[value='10']").attr('selected','selected');
        }else if(lmtType=='20'){
            $("#ku").find("option[value='20']").attr('selected','selected');

        }
        if(isUsed=='y'){
            $("#isUsed").find("option[value='y']").attr('selected','selected');
        }else if(isUsed=='n'){
            $("#isUsed").find("option[value='n']").attr('selected','selected');
        }


        form.render();


    });
</script>
</body>
</html>