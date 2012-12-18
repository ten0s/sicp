(load "ch03/constraint.scm")
(load "test-manager/load.scm")

(define (squarer a b)
  (define (process-new-value)
	(if (has-value? b)
		(if (< (get-value b) 0)
			(error "square less than 0 -- SQUARER" (get-value b))
			(set-value! a (sqrt (get-value b)) me))
		(set-value! b (square (get-value a)) me)))
  (define (process-forget-value)
	(forget-value! a me)
	(forget-value! b me)
	(process-new-value))
  (define (me request)
	(cond ((eq? request 'I-have-a-value)
		   (process-new-value))
		  ((eq? request 'I-lost-my-value)
		   (process-forget-value))
		  (else
		   (error "Unknown request -- ADDER" request))))
  (connect a me)
  (connect b me)
  me)

(in-test-group
 squarer-tests

 (define-test (squarer-forward-test)
   (define A (make-connector))
   (define B (make-connector))
   (squarer A B)

   (set-value! A 4 'user)
   (assert-equal 16 (get-value B)))

 (define-test (squarer-backward-test)
   (define A (make-connector))
   (define B (make-connector))
   (squarer A B)

   (set-value! B 9 'user)
   (assert-equal 3 (get-value A)))
)
(run-test '(squarer-tests))
