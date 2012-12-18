(load "ch03/constraint.scm")
(load "test-manager/load.scm")

(define (averager a b c)
  (let ((sum (make-connector))
		(two (make-connector)))
	(adder a b sum)
	(multiplier c two sum)
	(constant 2 two)
	'ok))

(probe "A" A)
(probe "B" B)
(probe "C" C)
(forget-value! B 'user)
(set-value! C 3 'user)

(in-test-group
 averager-tests

 (define-test (averager-forward-test)
   (define A (make-connector))
   (define B (make-connector))
   (define C (make-connector))
   (averager A B C)

   (set-value! A 2 'user)
   (set-value! B 5 'user)
   (assert-equal 7/2 (get-value C)))

 (define-test (averager-backward-test)
   (define A (make-connector))
   (define B (make-connector))
   (define C (make-connector))
   (averager A B C)

   (set-value! A 2 'user)
   (set-value! C 3 'user)
   (assert-equal 4 (get-value B)))
)
(run-test '(averager-tests))
