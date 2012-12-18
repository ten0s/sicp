; tree-recursive process
(define (fib n)
  (cond ((= n 0) 0)
		((= n 1) 1)
		(else (+ (fib (- n 2)) (fib (- n 1))))))

; linear iterative process
(define (fib n)
  (fib-iter 0 1 n))

(define (fib-iter a b counter)
  (if (= counter 0)
	  a
	  (fib-iter b (+ a b) (- counter 1))))
