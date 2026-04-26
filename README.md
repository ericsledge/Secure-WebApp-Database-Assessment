# 🛡️ Secure WebApp Database Assessment

## 📌 Project Summary

This project is a complete **web application and database security assessment** using a vulnerable local web application environment.

The purpose of this project is to identify, document, and explain how to fix common security vulnerabilities in a database-backed web application.

This project focuses on:

- 💉 **SQL Injection**
- ⚠️ **Cross-Site Scripting (XSS)**
- 🔐 **Cross-Site Request Forgery (CSRF)**
- 🗄️ **Database Hardening**
- ✅ **Testing and Validation**
- 📸 **Screenshot Evidence**
- 📝 **Final Security Report**

---

## 🎯 Project Objectives

The main goals of this project were to:

- Identify vulnerabilities in a vulnerable web application
- Demonstrate each vulnerability in a safe local lab environment
- Document the risk and potential impact of each issue
- Show **before-and-after code examples**
- Apply database security improvements
- Validate that the fixes improve security
- Organize all evidence into a final professional project folder

---

## 🧰 Tools Used

| Tool | Purpose |
|---|---|
| **XAMPP** | Runs Apache, PHP, MySQL, and phpMyAdmin locally |
| **DVWA** | Vulnerable web application used for testing |
| **PHP** | Application language used by DVWA |
| **MySQL / MariaDB** | Backend database |
| **phpMyAdmin** | Database management tool |
| **Visual Studio Code** | Used to view and document code |
| **Microsoft Word** | Used to create the final report |
| **Git** | Version control |
| **GitHub** | Project publishing and repository hosting |

---

## 📁 Project Folder Structure

```text
Secure_WebApp_Database_Project
│
├── Final_Report
├── Screenshots
├── Code_Snippets
├── Database_Hardening
├── Testing_Validation
├── README.md
└── .gitignore
```

### Folder Descriptions

| Folder | Contents |
|---|---|
| **Final_Report** | Final Word report for submission |
| **Screenshots** | Evidence screenshots from setup, testing, fixes, and validation |
| **Code_Snippets** | Before-and-after vulnerable and secure code examples |
| **Database_Hardening** | SQL commands used to harden database access |
| **Testing_Validation** | Notes showing how fixes were validated |

---

## ⚙️ Part 1 — Local Lab Setup

### 1. Install XAMPP

XAMPP was used to run the local web server and database services.

After installation, the following services were started:

```text
Apache
MySQL
```

Both services should show as **Running** in the XAMPP Control Panel.

📸 Evidence captured:

```text
Screenshot_01_XAMPP_Running.png
```

---

### 2. Install DVWA

DVWA was downloaded from GitHub, extracted, renamed, and placed inside the XAMPP web directory.

Final DVWA location:

```text
C:\xampp\htdocs\dvwa
```

📸 Evidence captured:

```text
Screenshot_02_DVWA_In_HTDOCS.png
```

---

### 3. Configure DVWA Database Settings

The DVWA configuration file was updated so the application could connect to the local MySQL database.

Configuration file:

```text
C:\xampp\htdocs\dvwa\config\config.inc.php
```

Database settings used:

```php
$_DVWA[ 'db_user' ]     = 'root';
$_DVWA[ 'db_password' ] = '';
```

📸 Evidence captured:

```text
Screenshot_03_DVWA_Config.png
```

---

### 4. Create the DVWA Database

The DVWA setup page was opened in the browser:

```text
http://localhost/dvwa/setup.php
```

The database was created by selecting:

```text
Create / Reset Database
```

📸 Evidence captured:

```text
Screenshot_04_DVWA_Database_Created.png
```

---

### 5. Log In and Set Security Level

DVWA was accessed through:

```text
http://localhost/dvwa/login.php
```

Login credentials:

```text
Username: admin
Password: password
```

The security level was set to:

```text
Low
```

📸 Evidence captured:

```text
Screenshot_05_DVWA_Security_Low.png
```

---

## 💉 Part 2 — SQL Injection Assessment

### 🔍 Vulnerability Tested

**SQL Injection** occurs when user input is inserted directly into a SQL query without proper protection.

### Test Location

```text
DVWA → SQL Injection
```

### Payload Used

```sql
1' OR '1'='1
```

### Result

The application returned multiple user records instead of one specific record. This showed that the input was being treated as part of the SQL command.

📸 Evidence captured:

```text
Screenshot_06_SQL_Injection_Exploit.png
```

---

### ⚠️ Risk Rating

```text
High
```

### Potential Impact

A successful SQL injection attack can allow an attacker to:

- View unauthorized database records
- Bypass authentication logic
- Modify or delete data
- Extract sensitive information
- Compromise the backend database

---

### 🔧 Secure Code Change

#### Vulnerable Code

```php
$query = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
```

📸 Evidence captured:

```text
Screenshot_07_SQL_Before_Code.png
```

#### Secure Code

```php
$id = $_GET['id'];

$stmt = $pdo->prepare("SELECT first_name, last_name FROM users WHERE user_id = ?");
$stmt->execute([$id]);

$results = $stmt->fetchAll();
```

📸 Evidence captured:

```text
Screenshot_08_SQL_After_Code.png
```

### Why This Fix Works

The secure version uses a **prepared statement**. Prepared statements separate user input from SQL commands, preventing attacker input from being executed as SQL code.

---

## ⚠️ Part 3 — Cross-Site Scripting Assessment

### 🔍 Vulnerability Tested

**Cross-Site Scripting, XSS** occurs when user-controlled input is returned to a webpage without proper output encoding.

### Test Location

```text
DVWA → XSS Reflected
```

### Payload Used

```html
<script>alert('XSS')</script>
```

### Result

The browser executed the JavaScript payload, proving that user input was reflected without being safely encoded.

📸 Evidence captured:

```text
Screenshot_09_XSS_Exploit.png
```

---

### ⚠️ Risk Rating

```text
Medium
```

### Potential Impact

A successful XSS attack can allow an attacker to:

- Execute JavaScript in another user’s browser
- Steal session cookies
- Redirect users to malicious pages
- Display fake login forms
- Perform actions through a victim’s browser session

---

### 🔧 Secure Code Change

#### Vulnerable Code

```php
$html .= '<pre>Hello ' . $_GET['name'] . '</pre>';
```

📸 Evidence captured:

```text
Screenshot_10_XSS_Before_Code.png
```

#### Secure Code

```php
$name = htmlspecialchars($_GET['name'], ENT_QUOTES, 'UTF-8');

$html .= '<pre>Hello ' . $name . '</pre>';
```

📸 Evidence captured:

```text
Screenshot_11_XSS_After_Code.png
```

### Why This Fix Works

The secure version uses **htmlspecialchars()** to encode special characters. This prevents injected HTML or JavaScript from being executed by the browser.

---

## 🔐 Part 4 — CSRF Assessment

### 🔍 Vulnerability Tested

**Cross-Site Request Forgery, CSRF** occurs when a web application accepts a state-changing request without verifying that the request was intentionally submitted by the authenticated user.

### Test Location

```text
DVWA → CSRF
```

### Test Password Used

```text
test123
```

### Result

The password change request was accepted without requiring a unique anti-CSRF token.

📸 Evidence captured:

```text
Screenshot_12_CSRF_Test.png
```

---

### ⚠️ Risk Rating

```text
Medium
```

### Potential Impact

A successful CSRF attack can allow an attacker to trick an authenticated user into performing unwanted actions, such as:

- Changing account passwords
- Updating account settings
- Submitting unauthorized forms
- Performing privileged actions

---

### 🔧 Secure Code Change

#### Vulnerable Behavior

The password change form processed requests without verifying a unique CSRF token.

📸 Evidence captured:

```text
Screenshot_13_CSRF_Before_Code.png
```

#### Secure Code

```php
session_start();

if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        die('Invalid CSRF token');
    }

    // Process password change here
}
```

Hidden form field:

```php
<input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
```

📸 Evidence captured:

```text
Screenshot_14_CSRF_After_Code.png
```

### Why This Fix Works

The secure version uses a random **session-based CSRF token**. The application checks that the submitted token matches the token stored in the user’s session before processing the request.

---

## 🗄️ Part 5 — Database Hardening

### 🔍 Hardening Goal

The database was hardened by creating a limited-privilege database user instead of relying on the root account.

This follows the principle of **least privilege**.

---

### SQL Commands Used

```sql
CREATE USER 'webuser'@'localhost' IDENTIFIED BY 'StrongPassword123!';

GRANT SELECT, INSERT, UPDATE ON dvwa.* TO 'webuser'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'webuser'@'localhost';
```

📸 Evidence captured:

```text
Screenshot_15_Database_User_Grants.png
```

---

### Why This Matters

Using a limited database account reduces risk. If the web application is compromised, the attacker does not automatically receive full administrative database access.

Security improvements demonstrated:

- ✅ **Least privilege**
- ✅ **Reduced attack surface**
- ✅ **Separation of duties**
- ✅ **Limited database permissions**

---

## ✅ Part 6 — Testing and Validation

After documenting the fixes, each vulnerability was reviewed again to explain how the secure version would reduce the risk.

### SQL Injection Validation

Original payload:

```sql
1' OR '1'='1
```

Expected secure result:

```text
The application should not return all user records.
```

Reason:

```text
Prepared statements treat the payload as data instead of executable SQL.
```

---

### XSS Validation

Original payload:

```html
<script>alert('XSS')</script>
```

Expected secure result:

```text
The script should not execute in the browser.
```

Reason:

```text
htmlspecialchars() encodes special characters before output is displayed.
```

---

### CSRF Validation

Original weakness:

```text
The application accepted password changes without a unique token.
```

Expected secure result:

```text
Requests without a valid CSRF token should be rejected.
```

Reason:

```text
The application validates the submitted token against the session token.
```

---

### Database Validation

Validation command:

```sql
SHOW GRANTS FOR 'webuser'@'localhost';
```

Expected result:

```text
The webuser account should only have SELECT, INSERT, and UPDATE permissions on the dvwa database.
```

📸 Evidence captured:

```text
Screenshot_16_Testing_Validation_Results.png
```

---

## 📝 Part 7 — Final Report

The final report includes the following sections:

- **Student Information**
- **Section 1: Vulnerability Assessment**
- **Section 2: Secure Code Changes**
- **Section 3: Database Hardening**
- **Section 4: Testing and Validation**
- **Section 5: Reflection**
- **Submission Checklist**

Final report file:

```text
Secure_WebApp_Database_Final_Report.docx
```

---

## 📸 Screenshot Evidence List

| # | Screenshot | Description |
|---|---|---|
| 1 | Screenshot_01_XAMPP_Running.png | XAMPP running Apache and MySQL |
| 2 | Screenshot_02_DVWA_In_HTDOCS.png | DVWA folder placed in htdocs |
| 3 | Screenshot_03_DVWA_Config.png | DVWA database configuration |
| 4 | Screenshot_04_DVWA_Database_Created.png | DVWA database setup |
| 5 | Screenshot_05_DVWA_Security_Low.png | DVWA security level set to Low |
| 6 | Screenshot_06_SQL_Injection_Exploit.png | SQL injection test result |
| 7 | Screenshot_07_SQL_Before_Code.png | Vulnerable SQL code |
| 8 | Screenshot_08_SQL_After_Code.png | Secure SQL fix |
| 9 | Screenshot_09_XSS_Exploit.png | XSS test result |
| 10 | Screenshot_10_XSS_Before_Code.png | Vulnerable XSS code |
| 11 | Screenshot_11_XSS_After_Code.png | Secure XSS fix |
| 12 | Screenshot_12_CSRF_Test.png | CSRF test result |
| 13 | Screenshot_13_CSRF_Before_Code.png | Vulnerable CSRF code |
| 14 | Screenshot_14_CSRF_After_Code.png | Secure CSRF fix |
| 15 | Screenshot_15_Database_User_Grants.png | Database user grants |
| 16 | Screenshot_16_Testing_Validation_Results.png | Testing and validation notes |

---

## 🚀 Part 8 — GitHub Publishing

The project was published to GitHub using Git.

### Commands Used

```bash
git init
git add .
git commit -m "Add secure web application and database assessment"
git branch -M main
git remote add origin https://github.com/ericsledge/Secure-WebApp-Database-Assessment.git
git push -u origin main
```

---

## 📦 Final Deliverables

The final project package includes:

- ✅ Final Word report
- ✅ Vulnerability assessment
- ✅ Risk ratings and impact explanations
- ✅ Before-and-after code snippets
- ✅ Database hardening SQL commands
- ✅ Testing and validation evidence
- ✅ Screenshot evidence
- ✅ GitHub repository
- ✅ ZIP submission folder

---

## 🔍 Skills Demonstrated

This project demonstrates practical skills in:

- **Web Application Security Testing**
- **Vulnerability Assessment**
- **Secure Coding Practices**
- **Database Security**
- **Risk Analysis**
- **Testing and Validation**
- **Technical Documentation**
- **Git and GitHub Version Control**

---

## 🔒 Security Notice

This project was completed in a **local lab environment** for educational purposes only.

No real systems, production applications, or unauthorized targets were tested.
