; Lab 14: Final Review

(define (compose-all funcs)
  (define (helper funcs acc )
    (if (null? funcs) acc
                      (helper (cdr funcs)  ((car funcs) acc) ) ))
  (lambda (x) (helper funcs x))
)

(define (has-cycle? s)
  (define (pair-tracker seen-so-far curr)
    (cond ((null? (cdr-stream curr)) #f)
          ((contains? seen-so-far (car curr)) #t)
          (else (pair-tracker (cons (car curr) seen-so-far) (cdr-stream curr)))))
  (pair-tracker (list s) s)
)

(define (contains? lst s)
  (if (null? lst) #f
      (if (eq? (car lst) s) #t
          (contains? (cdr lst) s)))
)