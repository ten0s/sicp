(define (product term a next b)
  (define (iter a result)
	(if (> a b)
		result
		(iter (next a) (* (term a) result))))
  (iter a 1))

(define (product term a next b)
  (if (> a b)
	  1
	  (* (term a)
		 (product term (next a) next b))))

(define (id x) x)

(define (inc x)
  (+ x 1))

(define (factorial n)
  (product id 1 inc n))

(define (pi)
  (define (max-seq) 1000)
  (define (add-two x)
	(+ x 2))
  (* (/ 2.0 (max-seq)) (/ (product square 2 add-two (max-seq))
						  (product square 3 add-two (- (max-seq) 1)))))
