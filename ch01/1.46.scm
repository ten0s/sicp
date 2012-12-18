(define (iterative-improvement good-enuf? improve-guess)
  (define (try guess)
	(let ((next-guess (improve-guess guess)))
	  (if (good-enuf? guess next-guess)
		  next-guess
		  (try next-guess))))
  (lambda (guess)
	(try guess)))

(define tolerance 0.00001)
(define (close-enuf? v1 v2)
  (< (abs (- v1 v2)) tolerance))

(define (fixed-point improve-guess first-guess)
  (let ((improve (iterative-improvement close-enuf? improve-guess)))
	(improve first-guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (average y (/ x y))))
			   1.0))
