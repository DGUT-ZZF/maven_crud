package com.zzf.ssm.crud.service;

import com.zzf.ssm.crud.bean.Department;
import com.zzf.ssm.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author DGUT-ZZF
 * @create 2021-03-31 22:26
 */
@Service
public class DepartmentService {
    @Autowired
    private  DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        return departmentMapper.selectByExample(null);
    }
}
