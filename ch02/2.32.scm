(define (subsets s)
  (if (null? s)
	  (list '())
	  (let ((rest (subsets (cdr s))))
		(append rest
				(map (lambda (r) (cons (car s) r))
					 rest)))))

(subsets '(1 2 3)) ; => '(() (3) (2) (2 3) (1) (1 2) (1 3) (1 2 3))
(let ((rest (subsets '(2 3)))) rest) ; => '(() (3) (2) (2 3))
(append '(() (3) (2) (2 3)) (map (lambda (r) (cons 1 r)) '(() (2) (3) (2 3)))) ; => '(() (3) (2) (2 3) (1) (1 2) (1 3) (1 2 3))
(map (lambda (r) (cons 1 r)) '(() (2) (3) (2 3))) ; => '((1) (1 2) (1 3) (1 2 3))
(append '(() (3) (2) (2 3)) '((1) (1 2) (1 3) (1 2 3))) ; => '(() (3) (2) (2 3) (1) (1 2) (1 3) (1 2 3))

(subsets '(2 3)) ; => '(() (3) (2) (2 3))
(let ((rest (subsets '(3)))) rest) ; => '(() (3))
(append '(() (3)) (map (lambda (r) (cons 2 r)) '(() (3)))) ; => '(() (3) (2) (2 3))
(map (lambda (r) (cons 2 r)) '(() (3))) ; => '((2) (2 3))
(append '(() (3)) '((2) (2 3))) ; => '(() (3) (2) (2 3))

(subsets '(3)) ; => '(() (3))
(let ((rest (subsets '()))) rest) ; => '(())
(append '(()) (map (lambda (r) (cons 3 r)) '(()))) ;  => '(() (3))
(map (lambda (r) (cons 3 r)) '(())) ; => '((3))
(append '(()) '((3))) ;  => '(() (3))

(subsets '()) ; => '(())
