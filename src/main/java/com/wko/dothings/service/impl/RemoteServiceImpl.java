package com.wko.dothings.service.impl;

import com.wko.dothings.dao.remote.RemoteMapper;
import com.wko.dothings.entities.Person;
import com.wko.dothings.service.RemoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RemoteServiceImpl implements RemoteService {

    @Autowired
    private RemoteMapper remoteMapper;

    @Override
    public List<Person> getAllPerson() {
        return remoteMapper.findAllPerson();
    }
}
