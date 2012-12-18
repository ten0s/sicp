(define (deep-reverse list)
  (reverse-helper list '()))

(define (reverse-helper list acc)
  (cond ((null? list) acc)
		((not (pair? list)) list)
		(else (reverse-helper (cdr list)
							  (cons (deep-reverse (car list)) acc)))))
