(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enuf? v1 v2)
	(< (abs (- v1 v2)) tolerance))
  (define (try guess)
	(let ((next (f guess)))
	  (if (close-enuf? guess next)
		  next
		  (try next))))
  (try first-guess))

(define (sqrt x)
  (fixed-point
   (lambda (y)
	 (average y (/ x y)))
   1.0))

(define (average x y)
  (/ (+ x y) 2))

; 1.35
(define (golden-ration)
  (fixed-point
   (lambda (x)
	 (+ 1 (/ 1 x)))
   1.0))
