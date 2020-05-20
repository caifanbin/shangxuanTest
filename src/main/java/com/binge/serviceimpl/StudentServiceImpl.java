package com.binge.serviceimpl;

import com.binge.beans.Student;
import com.binge.commons.Page;
import com.binge.dao.StudentMapper;
import com.binge.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    public Page queryPage(Map paramMap) {
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));
        Integer startIndex = page.getStartIndex();
        paramMap.put("startIndex", startIndex);
        List<Student> datas = studentMapper.queryList(paramMap);
        Integer totalsize = studentMapper.querycount(paramMap);
        page.setDatas(datas);
        page.setTotalsize(totalsize);
        return page;
    }

    public int delete(int id) {

        return studentMapper.dodelete(id);
    }

    public Student getStudentByid(int id) {
        return studentMapper.getStudentByid(id);
    }

    public int save(Student student) {
        return studentMapper.doSave(student);
    }

    public int doUpdate(Student student) {
        return studentMapper.doUpdate(student);
    }
}
