(define (make-table same-key?)
  (let ((table (list '*table*)))
	(define (lookup key)
	  (let ((record (assoc key (cdr table))))
		(if record
			(cdr record)
			false)))
	(define (assoc key records)
	  (cond ((null? records) false)
			((same-key? key (caar records)) (car records))
			(else (assoc key (cdr records)))))
	(define (insert! key value)
	  (let ((record (assoc key (cdr table))))
		(if record
			(set-cdr! record value)
			(set-cdr! table
					  (cons (cons key value)
							(cdr table)))))
	  'ok)
	(define (dispatch m)
	  (cond ((eq? m 'lookup) lookup)
			((eq? m 'insert!) insert!)
			(else (error "Unknown procedure -- TABLE" m))))
	dispatch))

(define (lookup key table)
  ((table 'lookup) key))

(define (insert! key value table)
  ((table 'insert!) key value))

;
; 3.27
;

(define (fib n)
  (cond ((= n 0) 0)
		((= n 1) 1)
		(else (+ (fib (- n 1))
				 (fib (- n 2))))))

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
