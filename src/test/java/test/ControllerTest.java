/**
 * FileName: ControllerTest
 * Author: ljl
 * Date: 2020/7/19 20:52
 * Description:
 * History:
 */


package test;

import com.ljl.crud.beans.Msg;
import com.ljl.crud.controller.EmployeeController;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class ControllerTest {

    @Autowired
    EmployeeController employeeController;
    @Test
    public void test(){
        Msg msg = employeeController.checkuser("aa");
        System.out.println(msg.getExtend().get("va_msg"));
    }
}
