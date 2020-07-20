/**
 * FileName: DepartmentController
 * Author: ljl
 * Date: 2020/7/19 18:41
 * Description: 处理和部门相关的请求
 * History:
 */


package com.ljl.crud.controller;


import com.ljl.crud.beans.Department;
import com.ljl.crud.beans.Msg;
import com.ljl.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDept(){
        List<Department> departments = departmentService.getDepts();
        return Msg.success().add("depts",departments);
    }
}
