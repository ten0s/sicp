(define (accumulate combiner null-value term a next b)
  (define (iter a result)
	(if (> a b)
		result
		(iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
	  null-value
	  (combiner (term a)
				(accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (inc x)
  (+ x 1))
(define (sum-cubes a b)
  (sum cube a inc b))

(define (id x) x)

(define (factorial n)
  (product id 1 inc n))

(define (pi)
  (define (max-seq) 1000)
  (define (add-two x)
	(+ x 2))
  (* (/ 2.0 (max-seq)) (/ (product square 2 add-two (max-seq))
						  (product square 3 add-two (- (max-seq) 1)))))
