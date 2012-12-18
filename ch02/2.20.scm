(define (same-parity . args)
  (let ((list (car args)))
	(if (null? list)
		'()
		(same-parity-helper (if (even? (car list)) even? odd?)
							list))))

(define (same-parity-helper pred? list)
  (cond ((null? list) list)
		((pred? (car list)) (cons (car list) (same-parity-helper pred? (cdr list))))
		(else (same-parity-helper pred? (cdr list)))))