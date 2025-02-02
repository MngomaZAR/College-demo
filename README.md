﻿# College-demo
Here’s a README.md file explaining how to use the `setup_project.ps1` PowerShell script along with the rest of the program to set up and use your project. This README will guide users through setting up the project on their local machine, initializing the database, and running the server.

```markdown
# College Voting System

## Overview

This repository contains a voting system implemented in PHP, with a SQLite database backend. The project includes both web and USSD interfaces for voter registration and voting. It features a setup script to initialize the project structure and database.

## Project Structure

The project directory is organized as follows:

```
/new_voting_system
│
├── /css
│   └── styles.css                # Custom styles
│
├── /js
│   └── scripts.js                # Custom JavaScript
│
├── /views
│   ├── register.php              # Register page (with enhanced UI)
│   ├── vote.php                 # Vote page (with enhanced UI)
│   ├── results.php              # Results page (with enhanced UI)
│   └── ussd.php                 # USSD endpoint
│
├── /includes
│   ├── db.php                   # Database connection
│   ├── models.php              # Model functions (CRUD operations)
│   └── functions.php           # Additional functions (if needed)
│
├── create_tables.sql            # SQL script to create database tables
├── Procfile                      # Heroku process type
├── index.php                     # Front controller (routes requests)
├── start_server.sh              # Script to start PHP server locally
├── .gitignore                    # Git ignore file
├── composer.json                 # Composer dependencies (if any)
└── README.md                     # Project documentation
```

## Prerequisites

Before running the setup script, ensure you have the following installed on your system:

- **PowerShell** (Windows built-in or updated version)
- **SQLite3**: Download and install from [SQLite Downloads](https://www.sqlite.org/download.html)

## Setting Up the Project

Follow these steps to set up and use the project:

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/MngomaZAR/College-demo.git
cd College-demo
```

### 2. Run the PowerShell Setup Script

The `setup_project.ps1` script will create the necessary project directories and files. 

**Run the Setup Script:**

1. Open PowerShell as Administrator.
2. Navigate to the project directory:

   ```powershell
   cd C:\Users\YourUsername\Desktop\College_demo
   ```

3. Execute the setup script:

   ```powershell
   .\setup_project.ps1
   ```

This script performs the following tasks:

- Creates the project directories and files.
- Populates the files with the initial code.
- Initializes the SQLite database and creates necessary tables.

### 3. Initialize the Database

After running the setup script, you need to initialize the SQLite database with the tables.

**Run the SQLite Initialization:**

1. Ensure `sqlite3.exe` is installed and available in your system's PATH.
2. Run the following command in PowerShell:

   ```powershell
   & 'C:\path\to\sqlite3.exe' 'C:\Users\YourUsername\Desktop\College_demo\new_voting_system.db' < 'C:\Users\YourUsername\Desktop\College_demo\create_tables.sql'
   ```

Replace `C:\path\to\sqlite3.exe` with the actual path to your `sqlite3.exe`.

### 4. Start the Local PHP Server

To start the PHP server locally, run the `start_server.sh` script.

**Run the PHP Server:**

1. Open a command prompt or PowerShell.
2. Navigate to the project directory:

   ```bash
   cd C:\Users\YourUsername\Desktop\College_demo
   ```

3. Run the server script:

   ```bash
   .\start_server.sh
   ```

The server will start at `http://127.0.0.1:8000`.

### 5. Access the Application

Once the server is running, you can access the application through the following URLs:

- **Register**: [http://127.0.0.1:8000/register](http://127.0.0.1:8000/register)
- **Vote**: [http://127.0.0.1:8000/vote](http://127.0.0.1:8000/vote)
- **Results**: [http://127.0.0.1:8000/results](http://127.0.0.1:8000/results)
- **USSD**: [http://127.0.0.1:8000/ussd](http://127.0.0.1:8000/ussd)

### 6. Deploy to Heroku

To deploy the project to Heroku, follow these steps:

1. **Create a Heroku Account**: Sign up at [Heroku](https://www.heroku.com/) if you don’t already have an account.

2. **Install Heroku CLI**: Download and install the Heroku CLI from [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli).

3. **Login to Heroku**: In your terminal, run:

   ```bash
   heroku login
   ```

4. **Create a Heroku App**:

   ```bash
   heroku create
   ```

5. **Push to Heroku**:

   ```bash
   git push heroku main
   ```

6. **Open Your App**:

   ```bash
   heroku open
   ```

Your application should now be live on Heroku.

## Contributing

Feel free to contribute to this project by submitting issues, suggesting improvements, or making pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

For further questions or issues, please open an issue in this repository or contact the project maintainers.

```

Replace placeholders like `C:\Users\YourUsername\Desktop\College_demo` with the actual paths on your system. This README provides clear instructions for setting up, running, and deploying your project.
