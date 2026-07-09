package com.monica.backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.monica.backend.entity.User;
import com.monica.backend.repository.UserRepository;

@Service
public class LoginService {

    @Autowired
    UserRepository repository;

    public boolean login(String email, String password) {

        User user = repository.findByEmail(email);

        if (user == null)
            return false;

        return user.getPassword().equals(password);
    }
}