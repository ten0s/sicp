(define (golden-ratio)
  (fixed-point
   (lambda (x)
	 (+ 1 (/ 1 x)))
   1.0))

; 1.37 a
(define (cont-frac n d k)
  (cont-frac-helper n d 1 k))

(define (cont-frac-helper n d i k)
  (if (> i k)
	  0
	  (/ (n i)
		 (+ (d i)
			(cont-frac-helper n d (+ i 1) k)))))

; 1.37 b
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

(define (1/golden-ratio)
  (cont-frac (lambda (i) 1.0)
			 (lambda (i) 1.0)
			 10000))
