(define (compose f g)
  (lambda (x) (f (g x))))

(define (id x) x)

; 1 recursive process
(define (repeated-1 f n)
  (if (= n 0) id
	  (compose f (repeated-1 f (- n 1)))))

; 2 iterative process
(define (repeated-2 f n)
  (define (repeated-iter f n f-acc)
	(if (= n 0) f-acc
		(repeated-iter
		 f
		 (- n 1)
		 (compose f f-acc))))
  (repeated-iter f n id))


((repeated-1 square 15) 5)
((repeated-2 square 15) 5)
