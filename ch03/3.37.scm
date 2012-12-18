(load "ch03/constraint.scm")
(load "test-manager/load.scm")

(define (c+ x y)
  (let ((z (make-connector)))
	(adder x y z)
	z))

(define (c* x y)
  (let ((z (make-connector)))
	(multiplier x y z)
	z))

(define (c/ x y)
  (let ((z (make-connector)))
	(multiplier y z x)
	z))

(define (cv c)
  (let ((v (make-connector)))
	(constant c v)
	v))

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
		  x)
	  (cv 32)))

(in-test-group
 cf-tests

 (define-test (cf-forward-test)
   (define C (make-connector))
   (define F (celsius-fahrenheit-converter C))
   (set-value! C 25 'user)
   (assert-equal 77 (get-value F)))

 (define-test (cf-backward-test)
   (define C (make-connector))
   (define F (celsius-fahrenheit-converter C))
   (set-value! F 212 'user)
   (assert-equal 100 (get-value C)))
)
(run-test '(cf-tests))
