# Clarity Loan Smart Contract

This Clarity smart contract facilitates simple loans between two parties on the Stacks blockchain. It allows a lender to create a loan agreement with a borrower, specifying the loan amount, interest rate, and repayment due date.  Borrowers can repay loans, and anyone can view the details of a loan.

## Functionality

The contract provides the following functionality:

* **`create-loan`:** This public function allows a lender to create a loan agreement. It takes the borrower's principal, loan amount, interest rate, and due block height as arguments. The contract ensures that the loan amount and interest are greater than zero, the due block is in the future, and the borrower is not the same as the lender.

* **`repay-loan`:** This public function allows a borrower to repay a loan. It takes the lender's principal and the repayment amount as arguments. The contract ensures that the correct amount is repaid (including interest) and updates the loan status to repaid.

* **`view-loan`:** This public function allows anyone to view the details of a specific loan. It takes the lender's and borrower's principals as arguments and returns the loan details if the loan exists.

* **Loan Storage:** Loan details are stored in a map called `loans`, keyed by a tuple of lender and borrower principals. The map stores the loan amount, interest, due block, and repayment status.

## Usage

### Creating a Loan

Lenders can create a loan using the `create-loan` function:

```clarity
(create-loan (borrower-principal) (loan-amount) (interest-rate) (due-block))
borrower-principal: The principal of the borrower.
loan-amount: The amount of the loan in micro-STX.

interest-rate: The interest rate of the loan, represented as a uint. For example, an interest rate of 5% would be represented as u500 (500 basis points).
due-block: The block height by which the loan must be repaid.

Repaying a Loan
Borrowers can repay a loan using the repay-loan function:
(repay-loan (lender-principal) (amount))
lender-principal: The principal of the lender.
amount: The total amount to repay (loan amount + interest), in micro-STX.

Viewing a Loan
Anyone can view a loan's details using the view-loan function:
(view-loan (lender-principal) (borrower-principal))

lender-principal: The principal of the lender.
borrower-principal: The principal of the borrower.
Example:
(create-loan 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JSJKS u1000000 u500 u50000)
(repay-loan 'ST2NEB8A94P2C99R92963F637ZA3S6490J9579 u1050000)
(view-loan 'ST2NEB8A94P2C99R92963F637ZA3S6490J9579 'ST1HTBVD3JG9C05J7HBJTHGR0GGW7KXW28M5JSJKS)
This example creates a loan of 1 STX (1,000,000 micro-STX) with a 5% interest rate, then repays the loan with the correct total amount (1,050,000 micro-STX), and finally views the loan details.

Future Enhancements
Default Handling: Logic to handle loan defaults and potential penalties.
Development
Building
This contract can be built using the Clarity compiler.

Testing
Unit tests can be written using the Clarity testing framework.

Deployment
This contract can be deployed to the Stacks blockchain using the Stacks CLI.
