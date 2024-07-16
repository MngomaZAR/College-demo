<!DOCTYPE html>
<html>
<head>
    <title>Vote</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Vote</h1>
        <form method="POST" class="mt-3">
            <input type="text" name="phone_number" placeholder="Phone Number" required>
            <input type="text" name="pin" placeholder="PIN" required>
            <select name="candidate" class="form-control">
                <!-- Candidates will be populated here -->
            </select>
            <button type="submit" class="btn btn-primary">Vote</button>
        </form>
    </div>
</body>
</html>
