(define (cont-frac n d k)
  (cont-frac-iter n d k 0))

(define (cont-frac-iter n d i acc)
  (if (= i 0)
	  acc
	  (cont-frac-iter n
					  d
					  (- i 1)
					  (/ (n i)
						 (+ (d i) acc)))))

; 1.39
(define (tan-cf x k)
  (* 1.0
	 (cont-frac (lambda (i) (if (= i 1) x (- (square x))))
				(lambda (i) (- (* i 2) 1))
				k)))
