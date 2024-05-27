package com.project.services;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.project.models.LoginUser;
import com.project.models.Role;
import com.project.models.User;
import com.project.repositories.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User saveUser(User user) {
        return userRepository.save(user);
    }
    public User register(User newUser, BindingResult result) {
        // Check if email is already in use
        Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
        if (potentialUser.isPresent()) {
            result.rejectValue("email", "Matches", "An account with that email already exists!");
            return null; // Return null immediately if email is already in use
        }

        // Check if password matches confirmation
        if (!newUser.getPassword().equals(newUser.getConfirm())) {
            result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
            return null; // Return null immediately if password doesn't match confirmation
        }

        // Hash the password securely
        String hashedPassword = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
        newUser.setPassword(hashedPassword);

        // Assign roles
        Set<Role> roles = newUser.getRoles();
        if (roles == null || roles.isEmpty()) {
            roles = new HashSet<>(); // Initialize roles if null
            roles.add(Role.STUDENT); // Assign default role
        }
        newUser.setRoles(roles);

        // Save and return the new user
        return userRepository.save(newUser);
    }

    public User login(LoginUser newLogin, BindingResult result) {
        // Check if the user exists
        Optional<User> potentialUser = userRepository.findByEmail(newLogin.getEmail());
        if (!potentialUser.isPresent()) {
            result.rejectValue("email", "Matches", "User not found!");
            return null;
        }

        User user = potentialUser.get();

        // Check if the password is correct
        if (!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
            result.rejectValue("password", "Matches", "Invalid Password!");
            return null;
        }

        return user;
    }

    public User findById(Long id) {
        Optional<User> potentialUser = userRepository.findById(id);
        return potentialUser.orElse(null);
    }
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }
}
