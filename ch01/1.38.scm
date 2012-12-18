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

; 1.38
(define (e-seq i)
  (if (or (= i 1) (= i 2))
	  i
	  (let ((r (remainder i 3)))
		(if (or (= r 0) (= r 1))
			1
			(let ((q (quotient i 3)))
			  (* 2 (+ 1 q)))))))

(define (e)
  (+ 2 (cont-frac (lambda (i) 1.0)
				  e-seq
				  10000)))
