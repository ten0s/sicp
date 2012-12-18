(define (make-fun)
  (let ((init -2))
	(lambda (x)
	  (set! init (+ init x 1))
	  init))

(let ((f (make-fun)))
  (+ (f 0) (f 1)))

(let ((f (make-fun)))
  (+ (f 1) (f 0)))
