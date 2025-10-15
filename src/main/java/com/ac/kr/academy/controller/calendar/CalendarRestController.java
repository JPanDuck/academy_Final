package com.ac.kr.academy.controller.calendar;


import com.ac.kr.academy.domain.calendar.Calendar;
import com.ac.kr.academy.service.calendar.CalendarService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/calendar")
public class CalendarRestController {

    private final CalendarService calendarService;

    public CalendarRestController(CalendarService calendarService) {
        this.calendarService = calendarService;
    }

    @GetMapping
    public ResponseEntity<List<Calendar>> getAllCalendars() {
        List<Calendar> calendars = calendarService.getAllCalendars();
        return ResponseEntity.ok(calendars);
    }

    @PostMapping
    public ResponseEntity<Calendar> addCalendar(@RequestBody Calendar newCalendar) {
        Calendar createdCalendar = calendarService.insertCalendar(newCalendar);
        return new ResponseEntity<>(createdCalendar, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Calendar> updateCalendar(@PathVariable Long id,  @RequestBody Calendar updatedCalendar) {
       Calendar existingCalendar = calendarService.getCalendarById(id);
        if (existingCalendar != null) {
            updatedCalendar.setId(id);
            Calendar result = calendarService.insertCalendar(updatedCalendar);
            return ResponseEntity.ok(result);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCalendar(@PathVariable Long id) {
      calendarService.delete(id);
       return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
