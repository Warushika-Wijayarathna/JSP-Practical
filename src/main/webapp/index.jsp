<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add/Update Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        h2 {
            color: #007bff;
        }

        .container {
            margin-top: 30px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }

        .form-label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 5px;
        }

        .modal-content {
            border-radius: 10px;
        }

        .modal-header {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Add / Update Customer</h2>

    <form action="customer-servlet" method="post">
        <input type="hidden" name="action" value="addOrUpdate">

        <div class="mb-3">
            <label for="customerId" class="form-label">Customer ID:</label>
            <input type="text" id="customerId" name="id" class="form-control" value="${customer.id}" required>
        </div>
        <div class="mb-3">
            <label for="customerName" class="form-label">Name:</label>
            <input type="text" id="customerName" name="name" class="form-control" value="${customer.name}" required>
        </div>
        <div class="mb-3">
            <label for="customerEmail" class="form-label">Email:</label>
            <input type="email" id="customerEmail" name="email" class="form-control" value="${customer.email}" required>
        </div>

        <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    <div class="text-center mt-3">
        <a href="customer-list.jsp" class="btn btn-secondary">Back to Customer List</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
