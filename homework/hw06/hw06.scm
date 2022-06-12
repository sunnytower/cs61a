; ;;;;;;;;;;;;;;
; ; Questions ;;
; ;;;;;;;;;;;;;;
; Scheme
(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cdr (cdr s))))

(define (unique s)
  (if (null? s)
      nil
      (cons (car s)
            (unique
             (filter (lambda (x) (not (equal? x (car s))))
                     (cdr s)
             )
            )
      )
  )
)

(define (cons-all first rests)
  (map (lambda (s) (cons first s)) rests)
)

; ; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  (define (helper n ways)
    (if (null? ways)
        nil
        (if (= 0 n)
            '(nil)
            (if (< n (car ways))
                (helper n (cdr ways))
                (append (cons-all (car ways)
                                  (helper (- n (car ways)) denoms)
                        )
                        (list-change n (cdr ways))
                )
            )
        )
    )
  )
  (helper total denoms)
)

; Tail recursion
(define (replicate x n)
  (define (helper n result)
    (if (= n 0)
        result
        (helper (- n 1) (append (list x) result))
    )
  )
  (helper n nil)
)

(define (accumulate combiner start n term)
  (if (= n 0)
      start
      (combiner (term n)
                (accumulate combiner start (- n 1) term)
      )
  )
)

(define (accumulate-tail combiner start n term)
  (define (helper n result)
    (if (= n 0)
        result
        (helper (- n 1) (combiner result (term n)))
    )
  )
  (helper n start)
)

; Macros
(define-macro
 (list-of map-expr for var in lst if filter-expr)
 (list 'map
       (list 'lambda (list var) map-expr)
       (list 'filter
             (list 'lambda (list var) filter-expr)
             lst
       )
 )
)
