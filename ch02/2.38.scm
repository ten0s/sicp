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

(fold-right / 1 '(1 2 3)) ; => 3/2
(fold-left / 1 '(1 2 3))  ; => 1/6
(fold-right list '() '(1 2 3)) ; => (1 (2 (3 ())))
(fold-left list '() '(1 2 3))  ; => (((() 1) 2) 3)

(fold-right + 0 '(1 2 3))
(fold-left  + 0 '(1 2 3))

; The `op' operation should satisfy the Commutativity and Assosiativity properties, that is, the order in which two arguments are applied does not matter, e.g. +, *.

