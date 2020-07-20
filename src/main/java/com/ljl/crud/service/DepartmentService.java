/**
 * FileName: DepartmentService
 * Author: ljl
 * Date: 2020/7/19 18:42
 * Description:
 * History:
 */


package com.ljl.crud.service;

import com.ljl.crud.beans.Department;
import com.ljl.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
