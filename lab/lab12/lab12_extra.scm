(define-macro (switch expr cases)
    (let ((val (eval expr)))
    (cons
      'cond
      (map
        (lambda (case) (cons (equal? val (car case)) (cdr case)))
        cases)))
)

(define (flatmap f x)
  (define (helper x acc)
    (if (null? x) acc
        (helper (cdr x) (append acc (f (car x))))))
  (helper x nil)
  )

(define (expand lst)
  (flatmap (lambda (elem)
                    (cond ((equal? elem 'x) '(x r y f r))
                          ((equal? elem 'y) '(l f x l y))
                          (else (list elem))))
            lst)
  )

(define (interpret instr dist)
  'YOUR-CODE-HERE)

(define (apply-many n f x)
  (if (zero? n)
      x
      (apply-many (- n 1) f (f x))))

(define (dragon n d)
  (interpret (apply-many n expand '(f x)) d))