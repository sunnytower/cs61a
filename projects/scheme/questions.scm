(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))



;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper index s result)
    (if (null? s) result
        (helper (+ index 1) (cdr s) (cons (list index (car s )) result))))
  (define (reverse lst)
    (define (iter remained result)
      (if (null? remained)
        result
        (iter (cdr remained)
              (cons (car remained) result))))
    (iter lst '()))
  (reverse (helper 0 s nil))
  )
  
  ; END PROBLEM 17

;; Problem 18

(define (zip pairs)
  ; BEGIN PROBLEM 18
  (list (map car pairs) (map cadr pairs))
  )
  ; END PROBLEM 18


;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (define params (car (zip values)))
           (define args (map let-to-lambda (cadr (zip values))))
           (define body (map let-to-lambda body))
           (cons (append (list 'lambda params) body) args)
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (cons (car expr) (map let-to-lambda (cdr expr)))
         ; END PROBLEM 19
         )))
