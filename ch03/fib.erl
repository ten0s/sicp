-module(fib).

-compile(export_all).

fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N-1) + fib(N-2).


(define memo-fib
  (memoize (lambda (n)
			 (cond ((= n 0) 0)
				   ((= n 1) 1)
				   (else (+ (memo-fib (- n 1))
							(memo-fib (- n 2))))))))

(define (memoize f)
  (let ((table (make-table equal?)))
	(lambda (x)
	  (let ((previously-computed-result (lookup x table)))
		(or previously-computed-result
			(let ((result (f x)))
			  (insert! x result table)
			  result))))))
