package com.umadev.schedulewhiz.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.umadev.schedulewhiz.entity.Issue;

public interface IssueRepository extends JpaRepository<Issue, Integer>  {

}
