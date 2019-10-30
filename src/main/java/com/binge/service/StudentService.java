package com.binge.service;

import com.binge.beans.Student;
import com.binge.commons.Page;

import java.util.Map;

public interface StudentService {
    Page queryPage(Map paramMap);

    int delete(int id);

    Student getStudentByid(int id);

    int save(Student student);

    int doUpdate(Student student);
}
