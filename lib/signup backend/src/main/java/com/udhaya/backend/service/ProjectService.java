package com.udhaya.backend.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.udhaya.backend.entity.Project;
import com.udhaya.backend.repository.ProjectRepository;
    

@Service
public class ProjectService {

    @Autowired
    private ProjectRepository projectRepository;

    public Project createProject(Project project) {
        return projectRepository.save(project);
    }
    
    
}
