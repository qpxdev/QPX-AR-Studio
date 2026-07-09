package com.monica.backend.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class LoginController {

    @GetMapping("/hello")
    public String hello() {
        return "Spring Boot Backend Running";
    }
}