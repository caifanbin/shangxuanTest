package com.binge.controller;

import com.binge.beans.Student;
import com.binge.commons.AjaxResult;
import com.binge.commons.Page;
import com.binge.commons.StringUtil;
import com.binge.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/sx")
public class SxtestController {

    @Autowired
    private StudentService studentService;

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/toindex")
    public String toindex() {
        return "/index";
    }

    @RequestMapping("/toupdate")
    public String toupdate(int id, Map map) {
        Student student = studentService.getStudentByid(id);
        map.put("updateStudent", student);
        return "/update";
    }

    @RequestMapping("/tosave")
    public String tosave() {
        return "/save";
    }


    @ResponseBody
    @RequestMapping("/list")
    public Object list(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno,
                       @RequestParam(value = "pagesize", required = false, defaultValue = "10") Integer pagesize
            , String querytext) {
        AjaxResult result = new AjaxResult();
        Map paramMap = new HashMap();
        paramMap.put("pageno", pageno);
        paramMap.put("pagesize", pagesize);
        if (StringUtil.iNotEmpty(querytext)) {
            paramMap.put("querytext", querytext);
        }
        try {
            Page page = studentService.queryPage(paramMap);
            result.setPage(page);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            e.printStackTrace();
            result.setMessage("查询失败");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("dodelete")
    public Object dodelete(int id) {
        AjaxResult result = new AjaxResult();
        try {
            int i = studentService.delete(id);
            if (i != 0) {
                result.setSuccess(true);

            }
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除失败");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("dosave")
    public Object save(Student student) {
        AjaxResult result = new AjaxResult();
        try {
            int i = studentService.save(student);
            if (i != 0) {
                result.setSuccess(true);
            }
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("保存失败");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("doupdate")
    public Object update(Student student) {
        AjaxResult result = new AjaxResult();
        try {
            int i = studentService.doUpdate(student);
            if (i != 0) {
                result.setSuccess(true);
            }
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("修改失败");
        }
        return result;
    }
}
