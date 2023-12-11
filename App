#include <iostream>
#include <string>
#include<cctype>
using namespace std;
class Account {
protected:
 string CNIC;
 string accountNumber;
 string accountTitle;
 double balance;
public:
 static int count;
 Account() {
 count++;
 }
 Account(string cnic, string number, string title, double bal)
 : CNIC(cnic), accountNumber(number), accountTitle(title), balance(bal) {
 count++;
 }
 virtual ~Account() {}
 virtual void addAccount() = 0;
 virtual void deposit(double amount) {
 balance += amount;
 }
 virtual void withdraw(double amount) {
 if (balance >= amount) {
 balance -= amount;
 } else {
 cout << "Insufficient funds!" << endl;
 }
 }
virtual void checkBalance() const {
 cout << "Account Balance: " << balance << endl;
 }
 static int totalAccounts() {
 return count;
 }
 double getBalance() const {
 return balance;
 }
 static bool hasNoNumbers(const std::string& str) {
 for (size_t i = 0; i < str.length(); ++i) {
 if (isdigit(str[i])) {
 return false;
 }
 }
 return true;
 }
 friend string getAccountNumber(const Account& acc);
};
int Account::count = 0;
string getAccountNumber(const Account& acc) {
 return acc.accountNumber;
}
class CurrentAccount : public Account {
private:
 double serviceFee;
public:
 void addAccount() override {
 cout << "Adding a Current Account" << endl;
 while (true) {
 cout << "Enter CNIC: ";
 cin >> CNIC;
 cout << "Enter Account Number: ";
 cin >> accountNumber;
 cout << "Enter Account Title: ";
 cin >> accountTitle;
 cout << "Enter Initial Balance: ";
 cin >> balance;
 cout << "Enter Service Fee: ";
 cin >> serviceFee;
if (accountNumber[0] != '1' || balance <= 0 || Account::hasNoNumbers(CNIC) || !isalpha(accountTitle[0]) ||
!isupper(accountTitle[0])) {
 cout << "Invalid account details for a Current Account! Please re-enter." << endl;
 } else {
 cout << "Current Account created successfully!" << endl;
 break;
 }
 }
 }
 void setServiceFee(double fee) {
 serviceFee = fee;
 }
 void checkBalance() const override {
 cout << "Current Account Balance: " << getBalance() << endl;
 }
 static int totalCurrentAccounts() {
 return count;
 }
};
class SavingAccount : public Account {
private:
 double monthlyInterestRate;
public:
 void addAccount() override {
 cout << "Adding a Saving Account" << endl;
 while (true) {
 cout << "Enter CNIC: ";
 cin >> CNIC;
 cout << "Enter Account Number: ";
 cin >> accountNumber;
 cout << "Enter Account Title: ";
 cin >> accountTitle;
 cout << "Enter Initial Balance: ";
 cin >> balance;
 cout << "Enter Monthly Interest Rate: ";
 cin >> monthlyInterestRate;
 if (accountNumber[0] != '2' || balance <= 0 || Account::hasNoNumbers(CNIC) || !isalpha(accountTitle[0]) ||
!isupper(accountTitle[0])) {
 cout << "Invalid account details for a Saving Account! Please re-enter." << endl;
 } else {
 cout << "Saving Account created successfully!" << endl;
 break;
 }
}
 }
 void calculateInterestRate() {
 double interest = (monthlyInterestRate / 100) * getBalance();
 balance += interest;
 cout << "Interest added: " << interest << endl;
 }
 void checkBalance() const override {
 cout << "Saving Account Balance: " << getBalance() << endl;
 }
 static int totalSavingAccounts() {
 return count;
 }
};
class AccountTest {
public:
 void start() {
 const int maxAccounts = 5;
 Account* accounts[maxAccounts * 2];
 int currentAccounts = 0;
 int savingAccounts = 0;
 bool recur = true;
 while (recur) {
 cout << "\nMenu:" << endl;
 cout << "1. Add Current Account" << endl;
 cout << "2. Add Saving Account" << endl;
 cout << "3. Deposit Money" << endl;
 cout << "4. Withdraw Money" << endl;
 cout << "5. Check Balance" << endl;
 cout << "6. Exit" << endl;
 cout << "Enter choice: ";
 int choice;
 cin >> choice;
 switch (choice) {
 case 1: {
 if (currentAccounts < maxAccounts) {
 CurrentAccount* currAcc = new CurrentAccount();
 currAcc->addAccount();
 accounts[currentAccounts++] = currAcc;
 } else {
 cout << "Cannot add more Current Accounts. Limit reached." << endl;
 }
 break;
}
 case 2: {
 if (savingAccounts < maxAccounts) {
 SavingAccount* savingAcc = new SavingAccount();
 savingAcc->addAccount();
 accounts[savingAccounts++ + maxAccounts] = savingAcc;
 } else {
 cout << "Cannot add more Saving Accounts. Limit reached." << endl;
 }
 break;
 }
 case 3: {
 string accNum;
 cout << "Enter account number for deposit: ";
 cin >> accNum;
 bool accountFound = false;
 for (int i = 0; i < currentAccounts + savingAccounts; ++i) {
 if (getAccountNumber(*accounts[i]) == accNum) {
 double amount;
 cout << "Enter deposit amount: ";
 cin >> amount;
 accounts[i]->deposit(amount);
 cout << "Deposit successful!" << endl;
 accountFound = true;
 break;
 }
 }
 if (!accountFound) {
 cout << "Account not found!" << endl;
 }
 break;
}
case 4: {
 string accNum;
 cout << "Enter account number for withdrawal: ";
 cin >> accNum;
 bool accountFound = false;
 for (int i = 0; i < currentAccounts + savingAccounts; ++i) {
 if (getAccountNumber(*accounts[i]) == accNum) {
 double amount;
 cout << "Enter withdrawal amount: ";
 cin >> amount;
 accounts[i]->withdraw(amount);
accountFound = true;
 break;
 }
 }
 if (!accountFound) {
 cout << "Account not found!" << endl;
 }
 break;
}
case 5: {
 string accNum;
 cout << "Enter account number to check balance: ";
 cin >> accNum;
 bool accountFound = false;
 for (int i = 0; i < currentAccounts + savingAccounts; ++i) {
 if (getAccountNumber(*accounts[i]) == accNum) {
 accounts[i]->checkBalance();
 accountFound = true;
 break;
 }
 }
 if (!accountFound) {
 cout << "Account not found!" << endl;
 }
 break;
}
 case 6: {
 recur = false;
 break;
 }
 default:
 cout << "Invalid choice. Please enter a valid option." << endl;
 }
 }
 }
};
int main() {
 AccountTest test;
 test.start();
 return 0;
}
