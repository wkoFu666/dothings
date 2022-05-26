package com.wko.dothings.dao.remote;

import com.wko.dothings.entities.Person;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface RemoteMapper {

    @Select("select * from person")
    List<Person> findAllPerson();
}
