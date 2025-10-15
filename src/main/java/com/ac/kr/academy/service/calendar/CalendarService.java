package com.ac.kr.academy.service.calendar;

import com.ac.kr.academy.domain.calendar.Calendar;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CalendarService {

    Calendar insertCalendar(Calendar calendar);


    List<Calendar> getCalendarsByDate(String date);

    List<Calendar> getAllCalendars();

    Calendar getCalendarById(Long id);

    void delete(Long id);

    void save(Calendar calendar);

    Calendar findById(Long id);

    List<Calendar> findAll();

    void update(Calendar calendar);

    void saveCalendar(Calendar calendar);
}
