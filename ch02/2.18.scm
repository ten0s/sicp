(define (reverse list)
  (define (reverse-helper l acc)
	(if (null? l)
	  acc
	  (reverse-helper (cdr l) (cons (car l) acc))))
  (reverse-helper list '()))
