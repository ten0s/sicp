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

(define (average-damp f)
  (lambda (x) (average x (f x))))

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

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

; 1.40
(define (cube x) (* x x x))
(define (square x) (* x x))

(define (cubic a b c)
  (lambda (x)
	(+ (cube x)
	   (* a (square x))
	   (* b x)
	   c)))
