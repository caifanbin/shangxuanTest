package com.binge.dao;

import com.binge.beans.Student;

import java.util.List;
import java.util.Map;

public interface StudentMapper {
    List<Student> queryList(Map var1);

    Integer querycount(Map var1);

    int dodelete(int id);

    Student getStudentByid(int id);

    int doSave(Student student);

    int doUpdate(Student student);
}
