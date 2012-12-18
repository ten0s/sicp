(define (make-monitor fun)
  (let ((calls-count 0))
	(lambda (arg)
	  (if (eq? arg 'how-many-calls?)
		  calls-count
		  (begin (set! calls-count (+ calls-count 1))
				 (fun arg))))))
