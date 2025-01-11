
<%@ page import="org.example.jsppractical.entity.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.jsppractical.dto.CustomerDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer List</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
      font-family: Arial, sans-serif;
    }

    h2 {
      color: #007bff;
    }

    .table {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
    }

    .btn-primary:hover {
      background-color: #0056b3;
      border-color: #004085;
    }

    .btn-success {
      background-color: #28a745;
      border-color: #28a745;
    }

    .btn-success:hover {
      background-color: #218838;
      border-color: #1e7e34;
    }

    .btn-warning {
      background-color: #ffc107;
      border-color: #ffc107;
    }

    .btn-warning:hover {
      background-color: #e0a800;
      border-color: #d39e00;
    }

    .btn-danger {
      background-color: #dc3545;
      border-color: #dc3545;
    }

    .btn-danger:hover {
      background-color: #c82333;
      border-color: #bd2130;
    }

    .text-center {
      margin-top: 20px;
    }

    .pagination {
      justify-content: center;
    }

    .container {
      margin-top: 30px;
    }
  </style>
</head>
<body>

<div class="container">
  <h2 class="text-center mb-4">Customer List</h2>

  <table class="table table-bordered table-striped">
    <thead class="table-dark">
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Email</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customerList");
      System.out.println("Cust"+customers);

      if (customers != null && !customers.isEmpty()) {
        for (CustomerDTO customer : customers) {
          System.out.println("Cust"+customer);
    %>
    <tr>
      <td><%= customer.getId() %></td>
      <td><%= customer.getName() %></td>
      <td><%= customer.getEmail() %></td>
      <td>
        <a href="customer-servlet?action=edit&id=<%= customer.getId() %>" class="btn btn-warning">Edit</a>
        <a href="customer-servlet?action=delete&id=<%= customer.getId() %>" class="btn btn-danger">Delete</a>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="4" class="text-center">No customers found.</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>


  <div class="text-center mt-3">
    <a href="index.jsp" class="btn btn-success">Add New Customer</a>
  </div>

  <!-- Pagination Controls -->
  <div class="text-center mt-3">
    <c:if test="${page > 1}">
      <a href="customer-servlet?page=${page - 1}" class="btn btn-secondary">Previous</a>
    </c:if>

    <c:if test="${page < totalCustomers / 10}">
      <a href="customer-servlet?page=${page + 1}" class="btn btn-secondary">Next</a>
    </c:if>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
