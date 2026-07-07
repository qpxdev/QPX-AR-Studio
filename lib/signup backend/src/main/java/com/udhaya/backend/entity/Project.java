package com.udhaya.backend.entity;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity

public class Project {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long id;
    private String projectName;
    private String projectType;
    
}
