(define (fold-right op init seq)
  (if (null? seq)
	  init
	  (op (car seq)
		  (fold-right op init (cdr seq)))))

(define (fold-left op init seq)
  (define (iter acc rest)
	(if (null? rest)
		acc
		(iter (op acc (car rest))
			  (cdr rest))))
  (iter init seq))

; 2.39
(define (reverse seq)
  (fold-right (lambda (x acc) (append acc (list x)))
			  '()
			  seq))

(define (reverse seq)
  (fold-left (lambda (acc x) (cons x acc))
			 '()
			 seq))
