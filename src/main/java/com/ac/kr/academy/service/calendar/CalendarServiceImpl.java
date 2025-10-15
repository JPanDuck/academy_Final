package com.ac.kr.academy.service.calendar;


import com.ac.kr.academy.domain.calendar.Calendar;
import com.ac.kr.academy.mapper.calendar.CalendarMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CalendarServiceImpl implements CalendarService {

    private final CalendarMapper calendarMapper;

    public CalendarServiceImpl(CalendarMapper calendarMapper) {
        this.calendarMapper = calendarMapper;
    }

    @Override
    @Transactional
    public Calendar insertCalendar(Calendar calendar) {
        calendarMapper.insert(calendar);
        return calendar;
    }

    @Override
    public List<Calendar> getCalendarsByDate(String date) {
        return calendarMapper.findByDate(date);
    }

    @Override
    public List<Calendar> getAllCalendars() {
        return calendarMapper.findAll();
    }

    @Override
    public Calendar getCalendarById(Long id) {
        return calendarMapper.findById(id);
    }

    @Override
    public void delete(Long id) {
        calendarMapper.delete(id);
    }

    @Override
    public void save(Calendar calendar) {
        if (calendar.getId() == null) {
            calendarMapper.insert(calendar);
        } else {
            calendarMapper.update(calendar);
        }
    }

    @Override
    public Calendar findById(Long id) {
        return calendarMapper.findById(id);
    }

    @Override
    public List<Calendar> findAll() {
        return calendarMapper.findAll();
    }

    @Override
    @Transactional
    public void update(Calendar calendar) {
        calendarMapper.update(calendar);
    }

    @Override
    @Transactional
    public void saveCalendar(Calendar calendar) {
        if (calendar.getColor() == null) {
            calendar.setColor("#3366ff");

            calendar.setUserId(1L);
            calendarMapper.insert(calendar);
        } else {
            calendarMapper.update(calendar);

        }
    }
}

