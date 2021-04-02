package com.zzf.ssm.crud.controller;

import com.zzf.ssm.crud.bean.Department;
import com.zzf.ssm.crud.bean.Msg;
import com.zzf.ssm.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 * @author DGUT-ZZF
 * @create 2021-03-31 22:25
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;


    /**
     * 返回所有的部门信息
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        //查出的所有部门信息
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
}
