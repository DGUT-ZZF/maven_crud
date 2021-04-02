package com.zzf.ssm.crud.test;

import com.zzf.ssm.crud.bean.Department;
import com.zzf.ssm.crud.bean.DepartmentExample;
import com.zzf.ssm.crud.bean.Employee;
import com.zzf.ssm.crud.bean.EmployeeExample;
import com.zzf.ssm.crud.dao.DepartmentMapper;
import com.zzf.ssm.crud.dao.EmployeeMapper;
/*包导错了，在@Test有两个包，一个是org.junit.jupiter.api.Test，
另一个是org.junit.Test，而测试需要的Junit是org.junit.Test*/
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * 测试dao层的工作
 * @author DGUT-ZZF
 * 测试DepartmentMapper
 * 推荐Spring的项目就使用Spring的单元测试，可以自动注入我们需要的组件
 * 1 导入SpringTest模块
 * 2 @ContextConfiguration指定Spring配置文件的位置(获取ioc容器)
 *   @RunWith是junit的，指定@Test为SpringJUnit4ClassRunner运行
 * 3 直接AutoWired要使用的组件即可
 * @create 2021-03-30 22:09
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    //批量处理的sqlSession
    @Autowired
    SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
//        原始做法====@RunWith @ContextConfiguration 替代
        //1 创建SpringIOC容器
//        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2 从容器中获取mapper
//        EmployeeMapper employeeMapper = context.getBean(EmployeeMapper.class);


        //1 插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));


        //2 生成员工数据,测试员工插入
//        employeeMapper.insertSelective(new Employee(null,"hyy","f",null,1));
//        employeeMapper.insertSelective(new Employee(null,"zzc","m",null,2));

        //3 删除测试
//        employeeMapper.deleteByPrimaryKey(3);

        //4 修改测试
//        DepartmentExample example = new DepartmentExample();
//        DepartmentExample.Criteria criteria = example.createCriteria();
//        criteria.andDeptIdEqualTo(2);
//        departmentMapper.updateByExampleSelective(new Department(null,"美工部"),example);

        //5 查询测试
//        EmployeeExample example = new EmployeeExample();
//        EmployeeExample.Criteria criteria = example.createCriteria();
//        criteria.andEmpIdEqualTo(1);
//        for (Employee employee : employeeMapper.selectByExampleWithDept(example)) {
//            System.out.println(employee);
//        }

        //★6 批量插入多个员工;批量，使用可以执行批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<1000;i++){
            //生成随机id
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
        }
        System.out.println("批量插入完成");


    }

}
