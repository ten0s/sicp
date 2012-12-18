(define (make-accumulator initial)
  (lambda (value)
	(set! initial (+ initial value))
	initial))
