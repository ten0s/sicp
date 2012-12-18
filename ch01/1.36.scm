(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enuf? v1 v2)
	(< (abs (- v1 v2)) tolerance))
  (define (try guess)
	(trace guess)
	(let ((next (f guess)))
	  (if (close-enuf? guess next)
		  next
		  (try next))))
  (try first-guess))

(define (trace x)
  (display x)
  (newline))

(define (average x y)
  (/ (+ x y) 2))

; 1.36
;; 34 steps for n = 1000
(define (x-power-x-equals n)
  (fixed-point
   (lambda (x)
	 (/ (log n) (log x)))
   2))

;; 9 steps for n = 1000
(define (x-power-x-equals n)
  (fixed-point
   (lambda (x)
	 (average x (/ (log n) (log x))))
   2))
