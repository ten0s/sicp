; this is a common problem and a common solution to it
; is to reserve the accumulation list at the end.
(define (square-list items)
  (define (iter things answer)
	(if (null? things)
		(reverse answer)
		(iter (cdr things)
			  (cons (square (car things))
					answer))))
  (iter items '()))

; this doesn't work either, the result are dotted list.
(define (square-list items)
  (define (iter things answer)
	(if (null? things)
		answer
		(iter (cdr things)
			  (cons answer (square (car things))))))
  (iter items '()))
