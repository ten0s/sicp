(define (pascal-row n)
  (cond ((= n 0) '(1))
		((= n 1) '(1 1))
		(else (cons 1
					(append
					 (shrink (pascal-row (- n 1)))
					 '(1))))))

(define (shrink list)
  (define (shrink-acc list acc)
	(cond ((= (length list) 1) acc)
		  (else (shrink-acc
				 (cdr list)
				 (cons (+ (first list)
						  (second list))
					   acc)))))
  (shrink-acc list '()))
