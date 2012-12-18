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

; a
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
			   1.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

; b
(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
			   1.0))

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
			   1.0))

(define dx 0.000001)

(define (deriv g)
  (lambda (x)
	(/ (- (g (+ x dx)) (g x))
	   dx)))

(define (newton-transform g)
  (lambda (x)
	(- x (/ (g x) ((deriv g) x)))))

(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))

; c
(define (sqrt x)
  (newton-method (lambda (y) (- (square y) x))
				 1.0))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

; d
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
							average-damp
							1.0))
; e
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (- (square y) x))
							newton-transform
							1.0))

