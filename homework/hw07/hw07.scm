(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define multiples-of-three
  (cons-stream 3 (map-stream (lambda (s) (+ s 3)) multiples-of-three) )
)

(define (rle s)
  (define (insert-or-inc elem acc)
    (cond
      ((null? acc) (cons-stream (list elem 1) nil))
      ((equal? elem (car (car acc)))
        (cons-stream
          (list (car (car acc)) (+ 1 (car (cdr (car acc)))))
          (cdr-stream acc)))
      (else (cons-stream (car acc) (insert-or-inc elem (cdr-stream acc)))))
  )

  (define (helper s acc) 
    (if (null? s) acc 
        (helper (cdr-stream s) (insert-or-inc (car s) acc))
    )
  )
  (helper s nil)
)

