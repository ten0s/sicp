;;;
;;; `new-sqrt' starts to recurse infinitely, because
;;; new-if isn't a special form and it evaluates
;;; both of its parameters.
;;;

(define (new-if predicate then-clause else-clase)
  (cond (predicate then-clause)
		(else else-clase)))

(define (wrong-sqrt x)
  (wrong-sqrt-iter 1 x))

(define (wrong-sqrt-iter guess x)
  (new-if (good-enough? guess x)
	  guess
	  (wrong-sqrt-iter (improve guess x)
				 x)))
