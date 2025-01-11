package org.example.jsppractical.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jsppractical.dto.CustomerDTO;
import org.example.jsppractical.entity.Customer;

import javax.json.Json;
import javax.json.JsonObject;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerServlet", value = "/customer-servlet")
public class CustomerServlet extends HttpServlet {

    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            // Perform JNDI lookup to fetch the DataSource
            Context initContext = new InitialContext();
            dataSource = (DataSource) initContext.lookup("java:comp/env/jdbc/pool");
            System.out.println("CustomerServlet initialized successfully");
        } catch (NamingException e) {
            throw new ServletException("Failed to lookup DataSource", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("CustomerServlet.doGet is called");
        try (Connection connection = dataSource.getConnection()) {
            // Query to fetch customer data
            String query = "SELECT cust_id, name, email FROM Customer";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            // Create a list to hold customers
            List<CustomerDTO> customers = new ArrayList<>();

            while (resultSet.next()) {
                CustomerDTO customer = new CustomerDTO(
                        resultSet.getString("cust_id"),
                        resultSet.getString("name"),
                        resultSet.getString("email")
                );
                customers.add(customer);
            }

            System.out.println("customers = " + customers);
            // Set customer list as request attribute
            req.setAttribute("customerList", customers);

            // Forward to the JSP page to display the customer data
            req.getRequestDispatcher("/customer-list.jsp").forward(req, resp);

        } catch (SQLException e) {
            handleDatabaseError(resp, e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    // Other HTTP methods (doPost, doPut, doDelete) remain as is, for JSON responses


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("CustomerServlet.doPost is called");

        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        try (Connection connection = dataSource.getConnection()) {
            // Query to insert customer data
            String query = "INSERT INTO Customer (cust_id, name, email) VALUES (?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, id);
            statement.setString(2, name);
            statement.setString(3, email);
            statement.executeUpdate();

            // Build JSON response
            JsonObject response = Json.createObjectBuilder()
                    .add("id", id)
                    .add("name", name)
                    .add("email", email)
                    .build();

            // Write JSON response
            resp.getWriter().write(response.toString());

            RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
            dispatcher.forward(req, resp);

        } catch (SQLException e) {
            handleDatabaseError(resp, e);
        }
    }

    private void handleDatabaseError(HttpServletResponse resp, SQLException e) throws IOException {
        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        JsonObject errorResponse = Json.createObjectBuilder()
                .add("error", "Database error occurred")
                .build();
        resp.getWriter().write(errorResponse.toString());
        e.printStackTrace();
    }
}
