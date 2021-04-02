<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%--
  Created by IntelliJ IDEA.
  User: BHY
  Date: 2021/3/31
  Time: 0:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表页面</title>
    <%
        pageContext.setAttribute("basePath",request.getContextPath());//获得的工程路径是以斜线开始的  :/maven_crud
    %>
<%--web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题.
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:8080);需要加上项目名
        http://localhost:8080/ssm_crud

    --%>


    <%--引入jQuery--%>
    <script type="text/javascript" src="${basePath}/static/js/jquery.min.js"></script>
    <%--引入Bootstrap样式--%>
    <link href="${basePath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <%--加载 Bootstrap 的所有 JavaScript 插件。--%>
    <script src="${basePath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>




<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <%--表单内容--%>
                <form class="form-horizontal" id="emp_update_form">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"> </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="123456@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender"  value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender"  value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select name="dId" class="form-control" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>



    <!-- 员工添加的模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <%--表单内容--%>
                    <form class="form-horizontal" id="emp_form">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                <span  class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="123456@qq.com">
                                <span  class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <%--部门提交部门id即可--%>
                                <select name="dId" class="form-control" id="dept_add_select">

                                </select>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>







    <%--搭建显示页面--%>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12 col-md-offset-1">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
         <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary " id="emp_add_modal_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            </div>
        </div>
         <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <table class="table table-striped  table-hover" id="emps_table">
                    <thead >
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all" />
                            </th>
                            <th>#</th>
                            <th>name</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>


                </table>
            </div>
        </div>
         <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6 col-md-offset-1" id="page_info_area">

            </div>
                <%--分页条信息--%>
                <div class="col-md-6 col-md-offset-6" id="page_nav_area">

                </div>
        </div>

    </div>
    <script type="text/javascript">

        var totalRecord,currentPage,size;
        //1 页面加载完成以后，直接去发送一个ajax请求，要到分页数据
        $(function () {
            //去首页
            to_page(1);
        });

        function to_page(pn){
            $.ajax({
                url:"${basePath}/emps",
                data:"num="+pn,
                type:"GET",
                success:function (result) {
                    //为全局记录数赋值
                    totalRecord = result.extend.pageInfo.total;
                    //为全局当前页码赋值
                    currentPage = result.extend.pageInfo.pageNum;
                    //为全局当前页面数据个数赋值
                    size = result.extend.pageInfo.size;
                    //1 解析并显示员工数据
                    build_emps_table(result);
                    //2 解析并显示分页信息
                    buid_page_info(result);
                    //3 解析并显示分页条数据
                    build_page_nav(result);
                }
            });

        }


        //解析员工数据
        function build_emps_table(result){
            //清空table表格
            $("#emps_table tbody").empty();

            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd=$("<td><input type= 'checkbox' class='check_item'></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                /*<button class="btn btn-primary  btn-sm">
                   <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                   编辑
                   </button>*/
                var editBtn = $("<button></button>").addClass("btn btn-primary  btn-sm edit_btn")
                               .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                               .append("编辑");
                //为编辑按钮添加一个自定义的属性,来表示当前员工id
                $(editBtn).attr("edit-id",item.empId);
                var deleteBtn = $("<button></button>").addClass("btn btn-danger  btn-sm delete_btn")
                                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                                .append("删除");
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
                //为删除按钮添加一个自定义属性，来便是当前员工id
                $(deleteBtn).attr("delete-id",item.empId);
                //apend方法返回完成以后还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                        .append(empIdTd)
                        .append(empNameTd)
                        .append(genderTd)
                        .append(emailTd)
                        .append(deptNameTd)
                        .append(btnTd)
                        .appendTo("#emps_table tbody");
            });
            return ;
        }


        //解析显示分页信息
        function buid_page_info(result){
            var page = result.extend.pageInfo;
            //清空分页信息
            $("#page_info_area").empty();

            $("#page_info_area").append("当前"+page.pageNum+"页,总共"+page.pages+"页,总"+page.total+"条记录");

        }


        //解析显示分页条,点击分页要能去下一页....
        function build_page_nav(result){
            //清空分页条信息
            $("#page_nav_area").empty();

            //page_nav_area
            var ul = $("<ul></ul>").addClass("pagination");
            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

            //如果位于首页 首页和上一页摁扭失效
            if(!result.extend.pageInfo.hasPreviousPage){
                prePageLi.addClass("disabled");
                firstPageLi.addClass("disabled");
            }else{
                //为元素添加点击翻页的事件
                //首页跳转
                firstPageLi.click(function () {
                    to_page(1);
                });
                //上一页跳转
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.prePage)
                });
            }



            //添加首页和前一页的提示
            ul.append(firstPageLi).append(prePageLi);

            //1,2,3 遍历给ul中添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums,function (index,num) {

                var numLi = $("<li></li>").append($("<a></a>").append(num).attr("href","#"));
                if(num==result.extend.pageInfo.pageNum){
                    //当前页码添加高光效果
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(num);
                });

                ul.append(numLi);
            });

            //如果位于末页 末页和下一页摁扭失效
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

            if(!result.extend.pageInfo.hasNextPage){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                //末页跳转
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
                //下一页跳转
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.nextPage)
                });
            }



            //添加下一页和末页的提示
            ul.append(nextPageLi).append(lastPageLi);

            //把ul加入到nav
            var navEle = $("<nav></nav>").attr("aria-label","Page navigation").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        function getDepts(ele){
            $.ajax({
                url:"${basePath}/depts",
                type:"GET",
                success:function (result) {
                    $(ele).empty();

                    // dept_add_select
                    var depts = result.extend.depts;

                    $.each(depts,function () {

                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);

                        optionEle.appendTo(ele);
                    });
                }
            });
        }

        $(function () {

            function reset_form(ele){
                //重置表单内容
                $(ele)[0].reset();
                //清空表单样式
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }

            //点击新增加按钮弹出模态框
            $("#emp_add_modal_btn").click(function () {

                //清除表单数据(表单完整重置(表单的数据，表单的样式))
                reset_form("#empAddModal form");

                //发送ajax请求，查出部门信息，显示在下拉列表中
                getDepts("#dept_add_select");

                //弹出模态框
                $('#empAddModal').modal({
                    backdrop:"static"
                });
            });


        });



        //校验表单数据
        function validate_add_form(){

            //1 拿到要校验的数据，使用正则表达式
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

            //1 校验用户名信息
            if(!regName.test(empName)){
                show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或则6-16位英文和数字的组合");
                return false;
            }else{
                show_validate_msg("#empName_add_input","success","");
            }

            var email = $("#email_add_input").val();
            var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;

            //2 校验邮箱信息
            if(!regEmail.test(email)){
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else{
                show_validate_msg("#email_add_input","success","");
            }
            return true;
        }

        //显示校验结果的提示信息
        function show_validate_msg(ele,status,msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");

            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }


        $(function () {
            //校验用户名是否可用
            $("#empName_add_input").change(function () {
               //发送ajax请求校验校验用户名是否可用
                $.ajax( {
                    url:"${basePath}/checkuser",
                    data:"empName="+$(this).val(),
                    type:"GET",
                    success:function (result) {
                        if(result.code==200){
                            //该用户名可用
                            show_validate_msg("#empName_add_input","success","用户名可用~");
                            $("#emp_save_btn").attr("ajxa-va","success");
                        }else{
                            //该用户名已存在
                            show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                            $("#emp_save_btn").attr("ajxa-va","error");
                        }
                    }
                });

            });
        });


        //点击保存，保存员工
        $(function () {
            $("#emp_save_btn").click(function () {
                //1 模态框中填写的表达数据交给服务器进行保存
                //1 先对要提交给服务器的数据进行校验
                //前端校验
                if(!validate_add_form()){
                    return false;
                };

                //1 判断之前的ajax用户名校验是否成功。如果成功才能继续进行。
                if($(this).attr("ajxa-va")=="error"){
                        return false;
                }
                //2 发送ajax请求保存员工
                $.ajax({
                    url:"${basePath}/emp",
                    data:$("#emp_form").serialize(),
                    type:"POST",
                    success:function (result) {
                        //员工保存成功;
                        if(result.code==200){
                            //1 关闭模态框
                            $('#empAddModal').modal('hide');
                            //2 来到最后一页，显示刚才保存的数据
                            //发送ajax请求显示最后一页数据即可
                            to_page(totalRecord);
                        }else if(result.code==100){
                            //显示失败信息
                            // console.log(result);
                            if(undefined !=result.extend.errorFields.email){
                                //显示邮箱错误信息
                                show_validate_msg("#email_add_input","error","邮箱错误");
                            }
                            if(undefined !=result.extend.errorFields.empName){
                                //显示员工名字错误信息
                                show_validate_msg("#empName_add_input","error","员工名错误");
                            }

                        }


                    }
                });
            })
        });


        //单个删除
        $(document).on("click",".delete_btn",function () {
            var empName =$(this).parent().parent().find("td:eq(2)").text();
            //1 弹出是否确认删除对话框
            var flag = confirm("确认删除【"+empName+"】员工");
            if(flag){
                //确认，发送ajax请求删除员工
                $.ajax({
                url:"${basePath}/emp/"+$(this).attr("delete-id"),
                type:"DELETE",
                success:function(result){

                    to_page(currentPage);
                }
            }) ;
            }
            return false;
        });

        //1 我们是按钮创建之前就绑定了click,所以绑定不上
        //1) 可以在创建按钮的时候绑定
        //2) 绑定点击.live()
        //jquery新版没有live,使用on进行替代
        $(document).on("click",".edit_btn",function(){
           // alert("edit");
            //1 查出部门信息，并且显示部门列表
            getDepts("#dept_update_select");
            //2 查出员工信息，显示员工信息
            getEmp($(this).attr("edit-id"));

            //3 把员工的id传递给模态框的更新按钮
            $('#emp_update_btn').attr("edit-id",$(this).attr("edit-id"));
            //弹出模态框
            $('#empUpdateModal').modal({
                backdrop:"static"
            });
        });

        function getEmp(id){
            $.ajax({
                url:"${basePath}/emp/"+id,
                type:"GET",
                success:function (result) {
                    console.log(result);
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#dept_update_select").val([empData.dId]);
                }

            });
        }


        //点击更新，更新员工信息
        $("#emp_update_btn").click(function () {
            //验证邮箱是否合法
            //1 前端校验邮箱信息
            var email = $("#email_update_input").val();
            var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_update_input","error","邮箱格式不正确");
                return false;
            }else{
                show_validate_msg("#email_update_input","success","");
            }

            //2 发送ajax请求保存更新的员工数据
            $.ajax({
                url:"${basePath}/emp/"+$(this).attr("edit-id"),
                data:$("#emp_update_form").serialize(),
                type:"PUT",
                success:function (result) {
                    console.log(result);
                    // 关闭模态框
                    $('#empUpdateModal').modal('hide');
                    // 回到当前页面
                    to_page(currentPage);

                }
            });
            return false;
        });

        //完成全选/全不选功能
        $("#check_all").click(function () {
            //attr获取checked是undefined
            //我们这些dom原生的属性；attr获取自定义属性的值;
            //prop修改和读取dom原生属性的值
            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        //check_item
        $(document).on("click",".check_item",function(){
            //判断当前选择中的元素数量是否等于该页面数量
            if($(".check_item:checked").length==size){
                $("#check_all").prop("checked",true);
            }else if($(".check_item:checked").length!=size){
                $("#check_all").prop("checked",false);
            }

        });


        //点击全部删除，就批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var del_idstr = "";
            //遍历每一个被选中的选项
            $.each($(".check_item:checked"),function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                //组装员工id的字符串
                del_idstr+= $(this).parents("tr").find("td:eq(1)").text()+"-";
            });

            //去除empNames多余的,
            empNames = empNames.substring(0,empNames.length-1);
            //去除删除的id多余的-
            del_idstr = del_idstr.substring(0,del_idstr.length-1);
            if(confirm("确定要删除【"+empNames+"】员工吗？")){
                //发送ajax请求
                $.ajax({
                    url:"${basePath}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //回到当前页面
                        to_page(currentPage);
                    }
                });
            }

            return false;
        });
    </script>


</body>
</html>
