package com.codecool.web.servlet;

import com.codecool.web.dao.UserDao;
import com.codecool.web.dao.database.DatabaseUserDao;
import com.codecool.web.model.User;
import com.codecool.web.service.UserService;
import com.codecool.web.service.exception.ServiceException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;

import com.codecool.web.service.simple.SimpleUserService;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;


@WebServlet("/auth")
public class GoogleAuthServlet extends AbstractServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            UserDao userDao = new DatabaseUserDao(connection);
            UserService userService = new SimpleUserService(userDao);
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), JacksonFactory.getDefaultInstance())
                // Specify the CLIENT_ID of the app that accesses the backend:
                .setAudience(Collections.singletonList("212389894216-2mat3goncqggvbvqhjfsrb4lods3g2d8.apps.googleusercontent.com"))
                // Or, if multiple clients access the backend:
                //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
                .build();

            String id_token = req.getParameter("id-token");
            GoogleIdToken idToken = verifier.verify(id_token);
            if (idToken != null) {
                Payload payload = idToken.getPayload();
                // Get profile information from payload
                String email = payload.getEmail();
                if (userService.validateEmail(email)) {
                    //ha van email akkor session vagy valami
                    User user = userService.getbyEmail(email);
                    req.getSession().setAttribute("user", user);
                    sendMessage(resp, HttpServletResponse.SC_OK, user);
                } else {
                    String name = (String) payload.get("name");
                    String emailToDb = payload.getEmail();
                    String password = "";
                    boolean isAdmin = false;
                    userService.addUser(name, email, password, isAdmin);
                    sendMessage(resp, HttpServletResponse.SC_OK, userService.getbyEmail(emailToDb));
                }

            }
        } catch (SQLException ex) {
            handleSqlError(resp, ex);

        } catch (GeneralSecurityException e) {
            e.printStackTrace();
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }
}
