package com.wko.dothings.service.impl;

import com.wko.dothings.dao.local.LocalMapper;
import com.wko.dothings.dao.remote.RemoteMapper;
import com.wko.dothings.entities.Person;
import com.wko.dothings.service.LocalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LocalServiceImpl implements LocalService {

    @Autowired
    private LocalMapper localMapper;

    @Autowired
    private RemoteMapper remoteMapper;

    @Override
    public List<Person> getAllPerson() {
        return localMapper.findAllPerson();
    }
}
