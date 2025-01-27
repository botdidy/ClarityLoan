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


