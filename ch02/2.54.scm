(define (equal? a b)
  (cond ((and (null? a)
			  (null? b)) true)
		((and (symbol? a)
			  (symbol? b)) (eq? a b))
		(else
		 (and (eq? (car a) (car b))
			  (equal? (cdr a) (cdr b))))))

(equal? '(this is a list) '(this is a list))
(equal? '(a) '(b))
