package com.ac.kr.academy.controller.calendar;

import com.ac.kr.academy.domain.calendar.Calendar;
import com.ac.kr.academy.service.calendar.CalendarService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/calendar")
public class CalendarController {

    private final CalendarService calendarService;

    /**일정 목록 */
    @GetMapping({"", "/", "/list"})
    public String list(Model model) {
        List<Calendar> calendars = calendarService.findAll();
        model.addAttribute("calendars", calendars);
        return "calendar/list";
    }

    /**일정 등록 폼 */
    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("calendar", new Calendar());
        return "calendar/add";
    }

    /**일정 등록 처리 */
    @PostMapping("/add")
    public String add(@ModelAttribute Calendar calendar,
                      RedirectAttributes ra) {
        log.info("일정 등록 요청: {}", calendar);
        calendarService.saveCalendar(calendar);
        ra.addFlashAttribute("message", "일정이 성공적으로 등록되었습니다.");
        return "redirect:/calendar";
    }

    /** ✅ 일정 수정 폼 */
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Calendar calendar = calendarService.findById(id);
        if (calendar == null) {
            return "redirect:/calendar";
        }
        model.addAttribute("calendar", calendar);
        return "calendar/edit";
    }

    /** ✅ 일정 수정 처리 */
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                       @ModelAttribute Calendar calendar,
                       RedirectAttributes ra) {
        log.info("일정 수정 요청: {}", calendar);
        calendar.setId(id); // 안전하게 id 세팅
        calendarService.saveCalendar(calendar);
        ra.addFlashAttribute("message", "일정이 성공적으로 수정되었습니다.");
        return "redirect:/calendar";
    }

    /** ✅ 일정 삭제 */
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id,
                         RedirectAttributes ra) {
        calendarService.delete(id);
        ra.addFlashAttribute("message", "일정이 삭제되었습니다.");
        return "redirect:/calendar";
    }
}
