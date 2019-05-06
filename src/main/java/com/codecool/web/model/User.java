package com.codecool.web.model;

import java.util.Objects;

public final class User extends AbstractModel {

    private String name;
    private boolean admin;
    private final String email;
    private final String password;
    
    public User(int id, String name, boolean admin, String email, String password) {
        super(id);
        this.name = name;
        this.admin = admin;
        this.email = email;
        this.password = password;
    }
    
    public String getName() {
        return name;
    }
    
    public boolean isAdmin() {
        return admin;
    }
    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        User user = (User) o;
        return Objects.equals(email, user.email) &&
            Objects.equals(password, user.password);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), email, password);
    }
}
