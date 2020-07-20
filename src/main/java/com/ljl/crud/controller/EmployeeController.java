/**
 * FileName: EmployeeController
 * Author: ljl
 * Date: 2020/7/18 10:29
 * Description:
 * History:
 */


package com.ljl.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ljl.crud.beans.Employee;
import com.ljl.crud.beans.Msg;
import com.ljl.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


        /**
         * 功能描述:分页查询
         * @param:
         * @return:
         * @since: 1.0.0
         * @Author: ljl
         * @Date: 2020/7/18 10:36
         */
//    @RequestMapping("/list.do")
//    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpServletRequest request){
//        //分页插件的使用
//        //传入页码和每页的数据
//        PageHelper.startPage(pn,10);
//        //startPage后面紧跟的就是分页查询
//        List<Employee> employees = employeeService.getAll();
//        //使用pageInfo包装list集合,连续现实的页数
//        PageInfo pageInfo = new PageInfo(employees,6);
//        request.setAttribute("pageInfo",pageInfo);
//        return "list";
//    }
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpServletRequest request){
        PageHelper.startPage(pn,10);
        //startPage后面紧跟的就是分页查询
        List<Employee> employees = employeeService.getAll();
        //使用pageInfo包装list集合,连续现实的页数
        PageInfo pageInfo = new PageInfo(employees,6);
        return Msg.success().add("pageInfo",pageInfo);
    }

        /**
         * 功能描述: 保存用户
         * 支持JSR303校验，导入Hibernate-Validator
         * @param:
         * @return:
         * @since: 1.0.0
         * @Author: ljl
         * @Date: 2020/7/19 20:16
         */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmap(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，返回错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError: fieldErrors){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }


        /**
         * 功能描述:验证注册姓名是否一致
         * @param:
         * @return:
         * @since: 1.0.0
         * @Author: ljl
         * @Date: 2020/7/19 20:17
         */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName") String empName){
        //先判断用户名是否正确
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是2~5位的中文或6~16位的英文");
        }

        boolean flag = employeeService.checkuser(empName);
        if(flag){
            return Msg.success();
        }
        return Msg.fail() ;
    }
//根据ID查询用户
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    //数据插入
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //数据单个删除,批量删除(1-2-3)
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            //批量删除
            List<Integer> id = new ArrayList<>();
            String[] str_id = ids.split("-");
            for (String s: str_id){
                id.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(id);
            return Msg.success();
        }else{
            //单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
            return Msg.success();
        }
    }

}
