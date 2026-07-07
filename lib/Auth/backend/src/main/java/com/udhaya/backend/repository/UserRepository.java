package com.udhaya.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.udhaya.backend.entity.User;


public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String email);
    
}
