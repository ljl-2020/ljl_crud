/**
 * FileName: MvcTest
 * Author: ljl
 * Date: 2020/7/18 10:47
 * Description:
 * History:
 */


package test;

import com.github.pagehelper.PageInfo;
import com.ljl.crud.beans.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;
     //虚拟mvc请求
    MockMvc mockMvc;
    @Before
    public void initMokcMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public  void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emp/list.do").param("pn","1")).andReturn();

        //请求成功后，请求与中会有pageInfo
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码："+pi.getPageNum());
        System.out.println("总页码："+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());
        System.out.println("连续显示的页码");
        int[] nums = pi.getNavigatepageNums();
        for(int i : nums){
            System.out.print(" "+i);
        }

        //获取员工信息
        List<Employee> employees = pi.getList();
        for(Employee e: employees){
            System.out.println("员工姓名："+e.getEmpName()+" 员工性别："+e.getEmpEsx()+" 员工邮箱："+e.getEmail());
        }

    }

}
