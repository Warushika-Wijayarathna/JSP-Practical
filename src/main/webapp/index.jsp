<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSP - Customer Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fffbf0;
        }

        h2 {
            color: #ff6f61;
        }

        .btn-primary {
            background-color: #ff6f61;
            border-color: #ff6f61;
        }

        .btn-primary:hover {
            background-color: #ff3b2e;
            border-color: #ff3b2e;
        }

        .btn-success {
            background-color: #4caf50;
            border-color: #4caf50;
        }

        .btn-success:hover {
            background-color: #388e3c;
            border-color: #388e3c;
        }
    </style>
</head>
<body>

<div class="container my-5">
    <h2 class="text-center mb-4">Customer List</h2>

    <!-- Check if customers are available -->
    <c:if test="${not empty customers}">
        <table class="table table-bordered table-striped shadow-sm">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <!-- Loop through customer list -->
            <c:forEach var="customer" items="${customers}">
                <tr>
                    <td>${customer.id}</td>
                    <td>${customer.name}</td>
                    <td>${customer.email}</td>
                    <td>
                        <button class="btn btn-primary btn-sm">Edit</button>
                        <button class="btn btn-danger btn-sm">Delete</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- Show message if no customers are found -->
    <c:if test="${empty customers}">
        <p>No customers found.</p>
    </c:if>

    <div class="text-center mt-3">
        <!-- Button to trigger modal -->
        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#customerAddModal">Add New Customer</button>
    </div>
</div>

<!-- Modal for Adding Customer -->
<div class="modal fade" id="customerAddModal" tabindex="-1" aria-labelledby="customerAddModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="customerAddModalLabel">Add New Customer</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addCustomerForm" action="/customer" method="post">
                    <input type="hidden" name="action" value="addOrUpdate">
                    <div class="mb-3">
                        <label for="modalCustomerId" class="form-label">Customer ID:</label>
                        <input type="text" id="modalCustomerId" name="customerId" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalCustomerName" class="form-label">Name:</label>
                        <input type="text" id="modalCustomerName" name="customerName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalCustomerEmail" class="form-label">Email:</label>
                        <input type="email" id="modalCustomerEmail" name="customerEmail" class="form-control" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary" form="addCustomerForm">Submit</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
