package com.wko.dothings.controller;

import com.wko.dothings.common.annotation.LogAno;
import com.wko.dothings.common.annotation.RedisCache;
import com.wko.dothings.common.base.Response;
import com.wko.dothings.service.LocalService;
import com.wko.dothings.service.RemoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test/")
public class TestController {

    @Autowired
    private LocalService localService;

    @Autowired
    private RemoteService remoteService;

    @LogAno(logModule = "testModule",logType = "QUERY",logDesc = "使用查询接口测试日志注解")
    @GetMapping("/getAllPerson")
    public Response getAllPerson() {
        return Response.ok(localService.getAllPerson());
    }

    @RedisCache(nameSpace = "Person",key = "getRemoteAllPerson")
    @LogAno(logModule = "testModule",logType = "QUERY",logDesc = "使用查询接口测试日志注解")
    @GetMapping("/getRemoteAllPerson")
    public Response getRemoteAllPerson() {
        return Response.ok(remoteService.getAllPerson());
    }
}
