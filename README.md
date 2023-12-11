# Account Management System

This repository contains a C++ implementation of an account management system that handles both Current Accounts and Saving Accounts. Key features include:

## Account Class Hierarchy
- `Account`: An abstract base class defining account operations like deposit, withdrawal, and balance checks.
- `CurrentAccount`: Inherits from `Account` and represents a current account with service fees.
- `SavingAccount`: Inherits from `Account` and represents a savings account with interest calculation.

## Functionality
- Users can add current or savings accounts, deposit money, withdraw funds, and check balances through a text-based menu-driven interface.

## Account Validation
- Account creation includes input validations such as valid account numbers, positive balances, proper CNIC format, and account title constraints.

## AccountTest Class
- `AccountTest`: Manages the interaction with the account system via a looped menu system. Users can perform various account-related operations.

## Usage
- Compile the code and run the resulting binary to access the account management system.
- Follow the on-screen prompts to add accounts, deposit or withdraw funds, and check balances.

## How to Use
1. Compile the code.
2. Run the executable.
3. Follow the menu options to perform account operations.
4. Exit the program when finished.


