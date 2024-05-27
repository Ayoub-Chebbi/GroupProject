package com.project.controllers;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.models.Course;
import com.project.models.LoginUser;
import com.project.models.Role;
import com.project.models.User;
import com.project.services.CourseService;
import com.project.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private CourseService courseService;

    private boolean isLoggedIn(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        return userId != null;
    }

    @GetMapping("/")
    public String showUserForm(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "login.jsp";
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model,HttpSession session) {
    	if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
    	if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        model.addAttribute("newUser", new User());
        return "register.jsp";
    }

    @PostMapping("/user/register")
    public String registerUser(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "register.jsp";
        }

        if (newUser.getRoles() == null || newUser.getRoles().isEmpty()) {
            newUser.getRoles().add(Role.STUDENT);
        } else {
            newUser.getRoles().add(Role.INSTRUCTOR);
        }

        User registeredUser = userService.register(newUser, result);
        if (registeredUser == null) {
            return "register.jsp";
        }

        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        model.addAttribute("successMessage", "Registration successful!");
        return "redirect:/api/courses/all";
    }

    @GetMapping("/api/users/{id}/edit")
    public String showEditUserForm(@PathVariable("id") Long id, Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        User user = userService.findById(id);
        if (user == null) {
            return "error.jsp"; // Handle user not found error
        }
        model.addAttribute("user", user);
        return "edit_user.jsp";
    }

    @PostMapping("/api/users/{id}/edit")
    public String updateUser(@PathVariable("id") Long id, 
                             @Valid @ModelAttribute("user") User user, 
                             BindingResult bindingResult, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (bindingResult.hasErrors()) {
            return "edit_user.jsp"; // Return to the form page with errors displayed
        }
        user.setId(id);
        userService.saveUser(user);
        return "redirect:/api/users/all";
    }

    @GetMapping("/api/users/{id}/delete")
    public String deleteUser(@PathVariable("id") Long id, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        userService.deleteUser(id);
        return "redirect:/api/users/all";
    }

    
    @GetMapping("/api/users/all")
    public String showAllUsers(Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "all_users.jsp";
    }


    @PostMapping("/user/login")
    public String loginUser(@Valid @ModelAttribute("newLogin") LoginUser loginUser, BindingResult result, Model model, HttpSession session) {
        if (result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "login.jsp";
        }

        User user = userService.login(loginUser, result);
        if (user == null) {
            model.addAttribute("newUser", new User());
            return "login.jsp";
        }

        session.setAttribute("userId", user.getId());
        Set<Role> rolesSet = user.getRoles(); // Assuming user.getRoles() returns a Set<Role>
        List<String> rolesList = rolesSet.stream()
                                         .map(Role::name) // Assuming Role is an enum
                                         .collect(Collectors.toList());
        session.setAttribute("roles", rolesList);
        String redirectUrl;
        if (user.getRoles().contains(Role.INSTRUCTOR)) {
            redirectUrl = "redirect:/api/courses/all";
        } else if (user.getRoles().contains(Role.STUDENT)) {
            redirectUrl = "redirect:/student/courses";
        } else {
            model.addAttribute("newUser", new User());
            model.addAttribute("errors", "User has no valid roles.");
            return "login.jsp";
        }

        return redirectUrl;
    }
    
    @GetMapping("/api/users2/{id}/edit")
    public String showEditUserForm1(@PathVariable("id") Long id, Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        
        User user = userService.findById(id);
        if (user == null) {
          return  "redirect:/login";
        }
        

        if (!user.getRoles().contains(Role.INSTRUCTOR)) {
            return "redirect:/error.jsp";
        }
        
        model.addAttribute("user", user);
        return "edit_user.jsp";
    }

    
    private boolean hasInstructorRole(HttpSession session) {
    	List<String> roles = (List<String>) session.getAttribute("roles");
        return roles != null && roles.contains("INSTRUCTOR");
    }
    
	@GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Invalidate the session to log out the user
        return "redirect:/"; // Redirect to the login page or home page
    }

    @GetMapping("/api/courses/new")
    public String showNewCourseForm(Model model , HttpSession session) {
    	if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
    	if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        model.addAttribute("course", new Course());
        return "new_course.jsp";
    }

    @PostMapping("/api/courses/new")
    public String saveCourse(@Valid @ModelAttribute("course") Course course,
                             BindingResult bindingResult, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/";
        }
        if (bindingResult.hasErrors()) {
            return "new_course.jsp"; // Return to the form page with errors displayed
        }
        User instructor = userService.findById((Long) session.getAttribute("userId"));
        course.setInstructor(instructor);
        courseService.saveCourse(course);
        return "redirect:/api/courses/all";
    }

    
    @GetMapping("/api/courses/{id}/edit")
    public String showEditCourseForm(@PathVariable("id") Long id, Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        Course course = courseService.getCourseById(id).orElse(null);
        if (course == null) {
            // Handle course not found error
            return "error.jsp";
        }
        model.addAttribute("course", course);
        return "edit_course.jsp";
    }

    @PostMapping("/api/courses/{id}/edit")
    public String updateCourse(@PathVariable("id") Long id,
                               @Valid @ModelAttribute("course") Course course,
                               BindingResult bindingResult, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (bindingResult.hasErrors()) {
            return "edit_course.jsp"; // Return to the form page with errors displayed
        }
        course.setId(id);
        courseService.saveCourse(course);
        return "redirect:/api/courses/all";
    }

    @GetMapping("/api/courses/{id}/delete")
    public String deleteCourse(@PathVariable("id") Long id, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        courseService.deleteCourse(id);
        return "redirect:/api/courses/all";
    }

    @GetMapping("/api/courses/{id}")
    public String showCourseDetails(@PathVariable("id") Long id, Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        Course course = courseService.getCourseById(id).orElse(null);
        if (course == null) {
            // Handle course not found error
            return "error.jsp";
        }
        model.addAttribute("course", course);
        return "show_course_details.jsp";
    }

    @GetMapping("/api/courses/all")
    public String getAllCourses(Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/login.jsp"; // Redirect to login page if user not logged in
        }
        System.out.print(hasInstructorRole(session));
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("courses", courses);
        return "all_courses.jsp";
    }

    @GetMapping("/api/instructor/add-course-to-user")
    public String showAddCourseToUserForm(Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/";
        }
        if (!hasInstructorRole(session)) {
            return "error.jsp"; // Redirect to error page if user doesn't have instructor role
        }
        List<User> users = userService.getAllUsers();
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("users", users);
        model.addAttribute("courses", courses);
        return "add_course_to_user.jsp";
    }

    @PostMapping("/api/instructor/add-course-to-user")
    public String addCourseToUser(@RequestParam("userId") Long userId,
                                  @RequestParam("courseId") Long courseId,
                                  HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }

        User user = userService.findById(userId);
        Course course = courseService.findById(courseId);

        if (user == null || course == null) {
            return "error.jsp";
        }

        user.getCourses().add(course);
        userService.saveUser(user);

        return "redirect:/api/courses/all";
    }

    @GetMapping("/student/courses")
    public String showStudentCourses(Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }

        User student = userService.findById((Long) session.getAttribute("userId"));
        if (student == null || !student.getRoles().contains(Role.STUDENT)) {
            // Handle case where user is not found or is not a student
            return "error.jsp";
        }

        List<Course> courses = student.getCourses();
        model.addAttribute("courses", courses);
        model.addAttribute("user", student); // Add the user to the model
        return "student_courses.jsp";
    }

    @PostMapping("/student/update")
    public String updateStudent(@Valid @ModelAttribute("user") User user, 
                                BindingResult bindingResult, HttpSession session, Model model) {
        if (!isLoggedIn(session)) {
            return "redirect:/"; // Redirect to login page if user not logged in
        }
        if (bindingResult.hasErrors()) {
            // Return to the form page with errors displayed
            return "student_courses.jsp";
        }

        // Update the student information
        Long userId = (Long) session.getAttribute("userId");
        User existingUser = userService.findById(userId);
        if (existingUser == null) {
            // Handle case where user is not found
            return "error.jsp";
        }

        existingUser.setUsername(user.getUsername());
        existingUser.setEmail(user.getEmail());
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            existingUser.setPassword(user.getPassword());
        }

        userService.saveUser(existingUser);
        return "redirect:/student/courses";
    }
}
