(define-map loans
    { lender: principal, borrower: principal }
    { amount: uint, interest: uint, due-block: uint, repaid: bool })

(define-public (create-loan (borrower principal) (amount uint) (interest uint) (due-block uint))
    (begin
        ;; Ensure borrower is not the sender
        (asserts! (not (is-eq tx-sender borrower)) (err "Cannot create a loan to yourself"))
        ;; Ensure loan amount and interest are greater than 0
        (asserts! (> amount u0) (err "Loan amount must be greater than zero"))
        (asserts! (> interest u0) (err "Interest must be greater than zero"))
        ;; Ensure the due-block is in the future
        (asserts! (> due-block stacks-block-height) (err "Due block must be in the future"))
        ;; Record the loan in the map
        (map-insert loans
            { lender: tx-sender, borrower: borrower }
            { amount: amount, interest: interest, due-block: due-block, repaid: false })
        (ok "Loan created successfully")
    ))

(define-public (repay-loan (lender principal) (amount uint))
    (begin
        ;; First verify that the lender is valid
        (asserts! (is-some (map-get? loans { lender: lender, borrower: tx-sender })) (err "Invalid lender"))
        (let ((loan (map-get? loans { lender: lender, borrower: tx-sender })))
            ;; Ensure the loan exists
            (asserts! (is-some loan) (err "Loan not found"))
            (let ((loan-data (unwrap! loan (err "Unexpected error"))))
                ;; Ensure loan has not already been repaid
                (asserts! (not (get repaid loan-data)) (err "Loan has already been repaid"))
                ;; Ensure repayment amount matches the total owed
                (let ((total-owed (+ (get amount loan-data) (get interest loan-data)))
                      (loan-id { lender: lender, borrower: tx-sender }))
                    (asserts! (is-eq amount total-owed) (err "Incorrect repayment amount"))
                    ;; Update the loan status to repaid
                    (asserts! (is-some (map-get? loans loan-id)) (err "Loan not found during update"))
                    (map-set loans
                        loan-id
                        { amount: (get amount loan-data), interest: (get interest loan-data), due-block: (get due-block loan-data), repaid: true })
                    (ok "Loan repaid successfully")
                )
            )
        )
    ))

(define-public (view-loan (lender principal) (borrower principal))
    (begin
        (let ((loan (map-get? loans { lender: lender, borrower: borrower })))
            (if (is-some loan)
                (ok (unwrap! loan (err "Unexpected error")))
                (err "Loan not found")
            )
        )
    ))
