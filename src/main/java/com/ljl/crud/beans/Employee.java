package com.ljl.crud.beans;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)"
            ,message = "用户名必须是2~5位的中文或6~16位的英文")
    private String empName;

    private String empEsx;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            ,message = "邮箱格式不正确例xxxx@xxxx.xxx")
    private String email;

    private Integer dId;

    //查询员工时显示部门信息
    private Department department;

    public Employee() {
    }

    public Employee(Integer empId, String empName, String empEsx, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.empEsx = empEsx;
        this.email = email;
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpEsx() {
        return empEsx;
    }

    public void setEmpEsx(String empEsx) {
        this.empEsx = empEsx == null ? null : empEsx.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }




}