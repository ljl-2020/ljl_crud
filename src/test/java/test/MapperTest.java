/**
 * FileName: MapperTest
 * Author: ljl
 * Date: 2020/7/18 9:55
 * Description:
 * History:
 */


package test;


import com.ljl.crud.beans.Employee;
import com.ljl.crud.dao.DepartmentMapper;
import com.ljl.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;


    @Test
    public void testCrud(){
        //部门测试
//        System.out.println(departmentMapper);
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //员工测试
//        System.out.println(employeeMapper);
//        employeeMapper.insertSelective(new Employee(null,"张三","男","2830429738@qq.com",1));
        //批量插入
//       EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//       for(int i = 0; i < 999; i++){
//            String name = UUID.randomUUID().toString().substring(0,4)+i;
//           if(i % 2 == 0){
//               mapper.insertSelective(new Employee(null,name,"男",name+"@ljl.com",2));
//           }else{
//               mapper.insertSelective(new Employee(null,name,"女",name+"@ljl.com",1));
//           }
//       }
//        System.out.println("批量操作完成");

    }
}
