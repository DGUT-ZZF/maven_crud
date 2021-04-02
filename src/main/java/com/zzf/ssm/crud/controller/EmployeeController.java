package com.zzf.ssm.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzf.ssm.crud.bean.Employee;
import com.zzf.ssm.crud.bean.Msg;
import com.zzf.ssm.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;

/**
 *
 * 处理员工CRUD请求
 *
 * URI:
 * /emp/{id} GET查询员工
 * /emp      POST保存员工
 * /emp/{id} PUT 修改员工
 * /emp/{id} DELETE 删除员工
 * @author DGUT-ZZF
 * @create 2021-03-31 0:01
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    /**
     * 单个批量二合一的方法
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            String[] str_ids = ids.split("-");
            ArrayList<Integer> del_ids = new ArrayList<>();
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            employeeService.deleteEmp(Integer.parseInt(ids));
        }
        return Msg.success();
    }


    /**
     * 员工更新
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * Employee[empId=3,empName=null,gender=null,email=null,dId=null]
     *
     * 问题:
     * 请求体中有数据;
     * 但是Employee对象封装不上；
     *
     * 原因：
     * Tomcat：
     *      1、将请求体中的数据，封装一个map。
     *      2、request.getParameter("empName")就会从这个map中取值
     *      3、SpringMVC封装POJO对象的时候。
     *              会把POJO中的每个属性的值,request.getParameter("empName");
     *AJAX发送PUT请求引发的血案:
     *      PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     *      Tomcat一看是PUT不会封装请求体中的数据为map,只有POST形式的请求才封装请求体为map
     *org.apache.catalina.connector.Request--parseParameters();
     *
     * 当执行POST请求才会执行后续操作
     * protected String parseBodyMethods = "POST";
     * if( !getConnector().isParseBodyMethod(getMethod()) ) {
         success = true;
         return;
         }
        解决方案:
         我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
        1 配置上HttpPutFormContentFilter;
        2 他的作用；将请求体中的数据解析包装成一个map.
        3 request被重新包装,request.getParameter()被重写，就会从自己封装的map中取数据

     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){

        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){

        Employee employee = employeeService.getEmp(id);


        return Msg.success().add("emp",employee);
    }


    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName")String empName){
        //先判断用户名是否是合法的表达式

        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母的组合或2-5位中文");
        }

        //数据库用户名重复校验
        Boolean flag = employeeService.checkUser(empName);
        if (flag) {
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }


    /**
     * 员工保存
     * 1 支持JSR303校验
     * 2 导入Hibernate Validator
     * @param employee
     * @return
     */

    @RequestMapping(value ="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){

        //后端校验
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                map.put(error.getField(),error.getDefaultMessage());
            }

            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }




    /**
     * 导入jackson包
     * @param num
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "num",defaultValue = "1") Integer num){
        //引入PageHelper分页插件
        //查询之前只需要调用，传入页码以及每页的大小
        PageHelper.startPage(num,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getEmps();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息,包括有我们查询出来的数据,传入连续显示的页数
        PageInfo pageInfo = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo",pageInfo);
    }




    /**
     * 查询员工数据(分页查询)

     * //引入PageHelper分页插件
        //查询之前只需要调用，传入页码以及每页的大小
        PageHelper.startPage(num,30);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getEmps();
        PageInfo<Employee> info = new PageInfo<>(emps);
     * //PageInfo包含了非常全面的分页属性
         assertEquals(1, page.getPageNum());
         assertEquals(10, page.getPageSize());
         assertEquals(1, page.getStartRow());
         assertEquals(10, page.getEndRow());
         assertEquals(183, page.getTotal());
         assertEquals(19, page.getPages());
         assertEquals(1, page.getFirstPage());
         assertEquals(8, page.getLastPage());
         assertEquals(true, page.isFirstPage());
         assertEquals(false, page.isLastPage());
         assertEquals(false, page.isHasPreviousPage());
         assertEquals(true, page.isHasNextPage());
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "num",defaultValue = "1") Integer num, Model model){

        //引入PageHelper分页插件
        //查询之前只需要调用，传入页码以及每页的大小
        PageHelper.startPage(num,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getEmps();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息,包括有我们查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        //连续显示的页面
        int[] nums = page.getNavigatepageNums();
        model.addAttribute("nums",nums);

        return "list";
    }




}
