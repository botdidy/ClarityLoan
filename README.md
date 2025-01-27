# Clarity Loan Smart Contract

This Clarity smart contract facilitates simple loans between two parties on the Stacks blockchain.  It allows a lender to create a loan agreement with a borrower, specifying the loan amount, interest rate, and repayment due date.

## Functionality

The contract provides the following functionality:

* **`create-loan`:** This public function allows a lender to create a loan agreement.  It takes the borrower's principal, loan amount, interest rate, and due block height as arguments.  The contract ensures that the loan amount and interest are greater than zero, the due block is in the future, and the borrower is not the same as the lender.

* **Loan Storage:** Loan details are stored in a map called `loans`, keyed by a tuple of lender and borrower principals. The map stores the loan amount, interest, due block, and repayment status.

## Usage

### Creating a Loan

Lenders can create a loan using the `create-loan` function:

```clarity
(create-loan (borrower-principal) (loan-amount) (interest-rate) (due-block))
