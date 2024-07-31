package com.project.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.project.models.Course;
import com.project.models.LoginUser;
import com.project.models.Role;
import com.project.models.User;
import com.project.services.CourseService;
import com.project.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private CourseService courseService;

    private boolean isLoggedIn(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        return userId != null;
    }

    private boolean hasInstructorRole(HttpSession session) {
        List<String> roles = (List<String>) session.getAttribute("roles");
        return roles != null && roles.contains("INSTRUCTOR");
    }

    @PostMapping("/user/login")
    public ResponseEntity<?> loginUser(@Valid @RequestBody LoginUser loginUser, HttpSession session) {
        User user = userService.login(loginUser);
        if (user == null) {
            return new ResponseEntity<>("Invalid login credentials", HttpStatus.UNAUTHORIZED);
        }

        session.setAttribute("userId", user.getId());
        Set<Role> rolesSet = user.getRoles();
        List<String> rolesList = rolesSet.stream()
                                         .map(Role::name)
                                         .collect(Collectors.toList());
        session.setAttribute("roles", rolesList);
        
        String redirectUrl;
        if (user.getRoles().contains(Role.INSTRUCTOR)) {
            redirectUrl = "/api/courses/all";
        } else if (user.getRoles().contains(Role.STUDENT)) {
            redirectUrl = "/api/student/courses";
        } else {
            return new ResponseEntity<>("User has no valid roles.", HttpStatus.FORBIDDEN);
        }

        return new ResponseEntity<>(redirectUrl, HttpStatus.OK);
    }

    @PostMapping("/user/register")
    public ResponseEntity<?> registerUser(@Valid @RequestBody User newUser) {
        if (newUser.getRoles() == null || newUser.getRoles().isEmpty()) {
            newUser.getRoles().add(Role.STUDENT);
        } else {
            newUser.getRoles().add(Role.INSTRUCTOR);
        }

        User registeredUser = userService.register(newUser);
        if (registeredUser == null) {
            return new ResponseEntity<>("Registration failed", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>("Registration successful!", HttpStatus.CREATED);
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<?> getUser(@PathVariable("id") Long id) {
        User user = userService.findById(id);
        if (user == null) {
            return new ResponseEntity<>("User not found", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @PutMapping("/users/{id}")
    public ResponseEntity<?> updateUser(@PathVariable("id") Long id, @Valid @RequestBody User user) {
        user.setId(id);
        User updatedUser = userService.saveUser(user);
        if (updatedUser == null) {
            return new ResponseEntity<>("User update failed", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(updatedUser, HttpStatus.OK);
    }

    @DeleteMapping("/users/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable("id") Long id) {
        userService.deleteUser(id);
        return new ResponseEntity<>("User deleted", HttpStatus.NO_CONTENT);
    }

    @GetMapping("/users")
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.getAllUsers();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @PostMapping("/courses")
    public ResponseEntity<?> saveCourse(@Valid @RequestBody Course course, HttpSession session) {
        if (!isLoggedIn(session) || !hasInstructorRole(session)) {
            return new ResponseEntity<>("Unauthorized", HttpStatus.FORBIDDEN);
        }

        User instructor = userService.findById((Long) session.getAttribute("userId"));
        course.setInstructor(instructor);
        courseService.saveCourse(course);
        return new ResponseEntity<>(course, HttpStatus.CREATED);
    }

    @PutMapping("/courses/{id}")
    public ResponseEntity<?> updateCourse(@PathVariable("id") Long id, @Valid @RequestBody Course course) {
        course.setId(id);
        Course updatedCourse = courseService.saveCourse(course);
        if (updatedCourse == null) {
            return new ResponseEntity<>("Course update failed", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(updatedCourse, HttpStatus.OK);
    }

    @DeleteMapping("/courses/{id}")
    public ResponseEntity<?> deleteCourse(@PathVariable("id") Long id) {
        courseService.deleteCourse(id);
        return new ResponseEntity<>("Course deleted", HttpStatus.NO_CONTENT);
    }

    @GetMapping("/courses")
    public ResponseEntity<List<Course>> getAllCourses() {
        List<Course> courses = courseService.getAllCourses();
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }

    @GetMapping("/courses/{id}")
    public ResponseEntity<?> getCourseDetails(@PathVariable("id") Long id) {
        Course course = courseService.getCourseById(id).orElse(null);
        if (course == null) {
            return new ResponseEntity<>("Course not found", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(course, HttpStatus.OK);
    }

    @PostMapping("/instructor/add-course-to-user")
    public ResponseEntity<?> addCourseToUser(@RequestParam("userId") Long userId,
                                              @RequestParam("courseId") Long courseId, HttpSession session) {
        if (!isLoggedIn(session) || !hasInstructorRole(session)) {
            return new ResponseEntity<>("Unauthorized", HttpStatus.FORBIDDEN);
        }

        User user = userService.findById(userId);
        Course course = courseService.findById(courseId);

        if (user == null || course == null) {
            return new ResponseEntity<>("User or course not found", HttpStatus.NOT_FOUND);
        }

        user.getCourses().add(course);
        userService.saveUser(user);
        return new ResponseEntity<>("Course added to user", HttpStatus.OK);
    }

    @GetMapping("/student/courses")
    public ResponseEntity<?> getStudentCourses(HttpSession session) {
        if (!isLoggedIn(session)) {
            return new ResponseEntity<>("Unauthorized", HttpStatus.FORBIDDEN);
        }

        User student = userService.findById((Long) session.getAttribute("userId"));
        if (student == null || !student.getRoles().contains(Role.STUDENT)) {
            return new ResponseEntity<>("User is not a student", HttpStatus.FORBIDDEN);
        }

        List<Course> courses = student.getCourses();
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }

    @PutMapping("/student/update")
    public ResponseEntity<?> updateStudent(@Valid @RequestBody User user, HttpSession session) {
        if (!isLoggedIn(session)) {
            return new ResponseEntity<>("Unauthorized", HttpStatus.FORBIDDEN);
        }

        Long userId = (Long) session.getAttribute("userId");
        User existingUser = userService.findById(userId);
        if (existingUser == null) {
            return new ResponseEntity<>("User not found", HttpStatus.NOT_FOUND);
        }

        existingUser.setUsername(user.getUsername());
        existingUser.setEmail(user.getEmail());
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            existingUser.setPassword(user.getPassword());
        }

        userService.saveUser(existingUser);
        return new ResponseEntity<>("Student updated", HttpStatus.OK);
    }

    @GetMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        session.invalidate();
        return new ResponseEntity<>("Logged out successfully", HttpStatus.OK);
    }
}
