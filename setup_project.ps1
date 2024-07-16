# PowerShell script to set up the project directory structure and files

# Define the project root directory
$projectRoot = "new_voting_system"

# Create the directories
$directories = @(
    "css",
    "js",
    "views",
    "includes"
)

foreach ($dir in $directories) {
    $path = Join-Path -Path $projectRoot -ChildPath $dir
    if (-not (Test-Path -Path $path)) {
        New-Item -Path $path -ItemType Directory
    }
}

# Define file paths and their content
$files = @{
    "css/styles.css" = @"
body {
    font-family: Arial, sans-serif;
}
.container {
    max-width: 800px;
    margin: 0 auto;
}
"@
    "js/scripts.js" = @"
document.addEventListener('DOMContentLoaded', function() {
    console.log('JavaScript loaded');
});
"@
    "views/register.php" = @"
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Register</h1>
        <form method="POST" class="mt-3">
            <input type="text" name="phone_number" placeholder="Phone Number" required>
            <input type="text" name="name" placeholder="Name" required>
            <input type="text" name="pin" placeholder="PIN" required>
            <button type="submit" class="btn btn-primary">Register</button>
        </form>
    </div>
</body>
</html>
"@
    "views/vote.php" = @"
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
"@
    "views/results.php" = @"
<!DOCTYPE html>
<html>
<head>
    <title>Results</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Voting Results</h1>
        <ul>
            <!-- Results will be populated here -->
        </ul>
    </div>
</body>
</html>
"@
    "views/ussd.php" = @"
<?php
require 'includes/models.php';

$session_id = $_GET['sessionId'];
$service_code = $_GET['serviceCode'];
$phone_number = $_GET['phoneNumber'];
$text = $_GET['text'];

$response = '';

if ($text == '') {
    $response = 'CON Welcome to the Voting System. Please enter your PIN:';
} else {
    $voter = getVoter($phone_number);
    if ($voter) {
        if ($text == $voter['pin']) {
            $response = 'CON Please select a candidate:\\n';
            $candidates = getCandidates();
            foreach ($candidates as $candidate) {
                $response .= $candidate['id'] . '. ' . $candidate['name'] . '\\n';
            }
        } else {
            $response = 'END Invalid PIN. Please try again.';
        }
    } else {
        $response = 'END You are not registered.';
    }
}

header('Content-type: text/plain');
echo $response;
?>
"@
    "includes/db.php" = @"
<?php
\$dsn = 'sqlite:/var/www/new_voting_system/new_voting_system.db';
try {
    \$pdo = new PDO(\$dsn);
    \$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException \$e) {
    die('Connection failed: ' . \$e->getMessage());
}
?>
"@
    "includes/models.php" = @"
<?php
require 'db.php';

function getVoter(\$phone_number) {
    global \$pdo;
    \$stmt = \$pdo->prepare('SELECT * FROM voters WHERE phone_number = :phone_number');
    \$stmt->execute(['phone_number' => \$phone_number]);
    return \$stmt->fetch(PDO::FETCH_ASSOC);
}

function createVoter(\$phone_number, \$name, \$pin) {
    global \$pdo;
    \$stmt = \$pdo->prepare('INSERT INTO voters (phone_number, name, pin) VALUES (:phone_number, :name, :pin)');
    return \$stmt->execute(['phone_number' => \$phone_number, 'name' => \$name, 'pin' => \$pin]);
}

function getCandidates() {
    global \$pdo;
    \$stmt = \$pdo->query('SELECT * FROM candidates');
    return \$stmt->fetchAll(PDO::FETCH_ASSOC);
}

function createVote(\$voter_id, \$candidate_id, \$position) {
    global \$pdo;
    \$stmt = \$pdo->prepare('INSERT INTO votes (voter_id, candidate_id, position) VALUES (:voter_id, :candidate_id, :position)');
    return \$stmt->execute(['voter_id' => \$voter_id, 'candidate_id' => \$candidate_id, 'position' => \$position]);
}

function getVotes() {
    global \$pdo;
    \$stmt = \$pdo->query('SELECT * FROM votes');
    return \$stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>
"@
    "includes/functions.php" = @"
<?php
// Additional utility functions can be added here
?>
"@
    "create_tables.sql" = @"
CREATE TABLE IF NOT EXISTS voters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    phone_number TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    pin TEXT NOT NULL,
    has_voted BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS candidates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    position TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    voter_id INTEGER,
    candidate_id INTEGER,
    position TEXT NOT NULL,
    FOREIGN KEY(voter_id) REFERENCES voters(id),
    FOREIGN KEY(candidate_id) REFERENCES candidates(id)
);
"@
    "Procfile" = @"
web: php -S 0.0.0.0:\$PORT -t /var/www/new_voting_system index.php
"@
    "index.php" = @"
<?php
\$uri = parse_url(\$_SERVER['REQUEST_URI'], PHP_URL_PATH);

if (\$uri == '/register') {
    require 'views/register.php';
} elseif (\$uri == '/vote') {
    require 'views/vote.php';
} elseif (\$uri == '/results') {
    require 'views/results.php';
} elseif (\$uri == '/ussd') {
    require 'views/ussd.php';
} else {
    echo '404 Not Found';
}
?>
"@
    "start_server.sh" = @"
#!/bin/bash
php -S 127.0.0.1:8000 -t /var/www/new_voting_system index.php
"@
    ".gitignore" = @"
vendor
*.log
*.db
"@
    "composer.json" = @"
{
    \"require\": {}
}
"@
    "README.md" = @"
# Voting System

## Description
This is a secure institutional voting application with a modern UI/UX.

## Setup

- Clone the repository
- Install dependencies (if any)
- Set up the database
- Run the server

## Deployment
- Use Heroku CLI to deploy
"@
}

# Create and populate files
foreach ($file in $files.GetEnumerator()) {
    $filePath = Join-Path -Path $projectRoot -ChildPath $file.Key
    $fileContent = $file.Value
    if (-not (Test-Path -Path $filePath)) {
        New-Item -Path $filePath -ItemType File -Force
    }
    Set-Content -Path $filePath -Value $fileContent
}

Write-Output "Project setup complete."
