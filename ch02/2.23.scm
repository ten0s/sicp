(define (for-each fun list)
  (if (null? list)
	  true
	  (begin
		(fun (car list))
		(for-each fun (cdr list)))))
