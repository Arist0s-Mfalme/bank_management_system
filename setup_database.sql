CREATE DATABASE IF NOT EXISTS BankDB;
USE BankDB;
-- 1. Create the independent Parent Table first
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(100)
);
-- 2. Create the Accounts Table (Child of Customers)
CREATE TABLE IF NOT EXISTS Accounts (
    account_no BIGINT PRIMARY KEY,
    customer_id INT NOT NULL,
    -- Links to Customers
    account_type VARCHAR(20) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0.00,
    CONSTRAINT fk_accounts_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE -- Automatically removes accounts if a customer is deleted
);
-- 3. Create the BankTransactions Table (Child of Accounts)
CREATE TABLE IF NOT EXISTS BankTransactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_no BIGINT NOT NULL,
    -- Links to Accounts
    transaction_type VARCHAR(20) NOT NULL,
    -- 'Deposit', 'Withdrawal', etc.
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transactions_account FOREIGN KEY (account_no) REFERENCES Accounts(account_no) ON DELETE CASCADE -- Drops logs if the account is closed entirely
);