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
    <%--搭建显示页面--%>
    <div clas="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12 col-md-offset-1">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
         <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary  ">新增</button>
                <button class="btn btn-danger ">删除</button>
            </div>
        </div>
         <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <table class="table table-striped  table-hover">
                    <tr>
                        <th>#</th>
                        <th>name</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="employee">
                        <tr>
                            <td>${employee.empId}</td>
                            <td>${employee.empName}</td>
                            <td>${employee.gender=="m"?"男":"女"}</td>
                            <td>${employee.email}</td>
                            <td>${employee.department.deptName}</td>
                            <td>
                                <button class="btn btn-primary  btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger  btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>


                </table>
            </div>
        </div>
         <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6 col-md-offset-1">
                当前${pageInfo.pageNum}页,总共${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>
                <div class="col-md-6 col-md-offset-6">
                    <%--分页条信息--%>
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li><a href="${basePath}/emps">首页</a></li>
                            <c:if test="${pageInfo.hasPreviousPage}">
                                <li>
                                    <a href="${basePath}/emps?num=${pageInfo.prePage}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach items="${nums}" var="num">
                                <c:if test="${pageInfo.pageNum==num}">
                                    <li class="active"><a href="${basePath}/emps?num=${num}">${num}</a></li>
                                </c:if>
                                <c:if test="${pageInfo.pageNum!=num}">
                                    <li><a href="${basePath}/emps?num=${num}">${num}</a></li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pageInfo.hasNextPage}">
                                <li>
                                    <a href="${basePath}/emps?num=${pageInfo.nextPage}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <li><a href="${basePath}/emps?num=${pageInfo.pages}">末页</a></li>
                        </ul>
                    </nav>

                </div>
        </div>

    </div>


    <%--<table>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>gender</th>
            <th>email</th>
            <th>deptId</th>
            <th>deptName</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="employee">
            <tr>
                <td>${employee.empId}</td>
                <td>${employee.empName}</td>
                <td>${employee.gender}</td>
                <td>${employee.email}</td>
                <td>${employee.department.deptName}</td>
            </tr>
        </c:forEach>
    </table>--%>

</body>
</html>
