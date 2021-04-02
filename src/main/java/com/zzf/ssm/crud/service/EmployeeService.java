package com.zzf.ssm.crud.service;

import com.zzf.ssm.crud.bean.Employee;
import com.zzf.ssm.crud.bean.EmployeeExample;
import com.zzf.ssm.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *
 *
 * @author DGUT-ZZF
 * @create 2021-03-31 9:35
 */
@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;


    public List<Employee> getEmps(){

        return employeeMapper.selectByExampleWithDept(null);

    }

    public int saveEmp(Employee employee) {

        return employeeMapper.insertSelective(employee);
    }

    /**
     * 检验用户名是否可用
     * 如果返回true，表示该用户名可使用
     * 反之false,则该用户名已存在，不可用
     * @param empName
     * @return
     */
    public Boolean checkUser(String empName) {

        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        return employeeMapper.countByExample(example)==0;
    }

    /**
     * 按照员工id查询员工
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {

        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     *员工更新
     * @param employee
     */
    public void updateEmp(Employee employee) {

        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除员工
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除
     * @param str_ids
     */
    public void deleteBatch(List<Integer> str_ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(str_ids);
        employeeMapper.deleteByExample(example);
    }
}
