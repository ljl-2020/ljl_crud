<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="static/js/jquery-1.12.4.min.js"></script>
    <link
            href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<html>
<body>


<!--员工更新的模块框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_name_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="emp_email_update_input" placeholder="email@user.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empEsx" id="sex1_update_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empEsx" id="sex2_update_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_save">更新</button>
            </div>
        </div>
    </div>
</div>



<!--员工添加的模块框-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_name_input" placeholder="姓名">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="emp_email_input" placeholder="email@user.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empEsx" id="sex1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empEsx" id="sex2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_add_save">保存</button>
            </div>
        </div>
    </div>
</div>




<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-2 col-md-offset-9">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>员工ID</th>
                    <th>员工姓名</th>
                    <th>员工性别</th>
                    <th>员工邮箱</th>
                    <th>员工部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>





<script type="text/javascript">
    //全局变量，保存总记录数
    var totalRecord,currentPage;
    //去首页
    $(function () {
       toPage(1);
    });

    function toPage(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //数据显示
                build_emp_table(result);
                //分页信息显示
                build_page_info(result);
                //分页条显示
                build_page_nav(result);
            }
        });
    }

    //解析数据显示
    function build_emp_table(result) {
        //清空表格信息
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empEsxTd = $("<td></td>").append(item.empEsx);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append(
                $("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //添加一个自定义的属性，来表示当前的员工ID
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append(
                $("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("delete-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(empEsxTd).append(emailTd).
            append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result) {
        //清空表格信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
            result.extend.pageInfo.pages+"页,总"+
            result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }
    //显示分页条
    function build_page_nav(result) {
        //清空表格信息
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        var firstLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));


        if(result.extend.pageInfo.hasPreviousPage == false){
            prePageLi.addClass("disabled");
        }else{
            firstLi.click(function () {
                toPage(1);
            });
        }
        prePageLi.click(function () {
            toPage(result.extend.pageInfo.pageNum - 1);
        });
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                toPage(result.extend.pageInfo.pageNum + 1);
            });
        }
        lastLi.click(function () {
            toPage(result.extend.pageInfo.pages);
        });

        //ul中添加首页和上一页
        ul.append(firstLi).append(prePageLi);

        //遍历给ul中添加页码
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                toPage(item);
            });
            ul.append(numLi);
        });

        //在页码后面添加下一页和末页
        ul.append(nextPageLi).append(lastLi);

        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }
    //重置表单方法
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增弹出模态框
    $("#emp_add_modal_btn").click(function() {
        //表单完整重置
        reset_form("#empAddModal form");
        //发送Ajax请求查出部门信息，显示在下拉列表
        getDepts("#dept_add_select");
        //弹出模块框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //查询部门信息，并显示在下拉列表
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                //显示部门信息在下拉列表
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验用户数据
    function validate_add_form() {
        //校验姓名
        var empName = $("#emp_name_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if(!regName.test(empName)){
            show_validate_msg("#emp_name_input","error","用户名可以是2~5位的中文或6~16位的英文");
            return false;
        }else {
            show_validate_msg("#emp_name_input","success","");
        }
        //校验邮箱
        var emailName = $("#emp_email_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(emailName)){
            show_validate_msg("#emp_email_input","error","邮箱格式不正确例xxxx@xxxx.xxx");
            return false;
        }else {
            show_validate_msg("#emp_email_input","success","");
        }
        return true;
    }

    //显示错误或成功信息
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#emp_name_input").change(function(){
        //发送Ajax的请求验证数据库中的姓名是否存在
        var empName = $("#emp_name_input").val();
        $.ajax({
            url:"${APP_PATH}/checkuser",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                if(result.codes == 100){
                    show_validate_msg("#emp_name_input","success","用户名可用");
                    $("#emp_add_save").attr("ajax-va","success");
                }else{
                    show_validate_msg("#emp_name_input","error",result.extend.va_msg);
                    $("#emp_add_save").attr("ajax-va","error");
                }
            }
        });
    });

    //保存操作的点击事件
    $("#emp_add_save").click(function() {
        //1,将模态框中的数据保存至数据库中
        //数据校验
        if(!validate_add_form()){
            return false;
        }
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //2，发送Ajax请求
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success:function (result) {
                if(result.codes == 100){
                    //员工保存成功；
                    //1、关闭模态框
                    $("#empAddModal").modal("hide");
                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    toPage(totalRecord);
                }else{
                    //显示失败信息
                    //console.log(result);
                    //有哪个字段的错误信息就显示哪个字段的；
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#emp_email_input", "error", result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#emp_name_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //编辑即修改的单击事件
    //1,按钮创建之前就绑定了Click：1）、可以在创建按钮的时候绑定。2）、绑定点击.live()可以为一个元素添加事件（现在用on方法替代）
    $(document).on("click",".edit_btn",function () {
        //弹出模态框
        //1.查出部门信息，并显示部门列表
        getDepts("#dept_update_select");
        //2.，查出员工信息，并显示信息
        getEmp($(this).attr("edit-id"));
        //把员工的ID传递给模态框的更新按钮
        $("#emp_update_save").attr("edit-id",$(this).attr("edit-id"));
        //显示模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empEle = result.extend.emp;
                $("#emp_name_update_static").text(empEle.empName);
                $("#emp_email_update_input").val(empEle.email);
                $("#empUpdateModal input[name=empEsx]").val([empEle.empEsx]);
                $("#empUpdateModal select").val([empEle.dId]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#emp_update_save").click(function () {
        //校验邮箱
        var emailName = $("#emp_email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(emailName)){
            show_validate_msg("#emp_email_update_input","error","邮箱格式不正确例xxxx@xxxx.xxx");
            return false;
        }else {
            show_validate_msg("#emp_email_update_input","success","");
        }
        //发送ajax请求，保存信息
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                $("#empUpdateModal").modal("hide");
                toPage(currentPage);
            }
        });
    });

    //点击单个删除事件
    $(document).on("click",".delete_btn",function () {
        //1弹出确认删除对话框
        var empName =  $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【"+empName+"】吗？")){
            //确认则返回true
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("delete-id"),
                type:"DELETE",
                success:function (result) {
                    //回到本页
                    alert(result.msg);
                    toPage(currentPage);
                }
            });
        }
    });

    //批量删除之全选全不选
    $("#check_all").click(function () {
        var flag = $(this).prop("checked");
        $(".check_item").prop("checked",flag);
    });
    $(document).on("click",".check_item",function () {
        //判断选中的元素是否为十个
        var f = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",f);
    })

    //批量删除的实现
    $("#emp_delete_all_btn").click(function () {
        var message_delete_all = "确认删除选中的用户吗？";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm(message_delete_all)){
            //发送Ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    toPage(currentPage);
                }
            });
        }
    });

</script>
</body>
</html>
