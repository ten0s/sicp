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
; tests
;
(define t (make-table equal?))
(insert! 1 'one t)
(insert! 2 'two t)
(insert! 3 'three t)
(lookup 3 t) ; => 3
(lookup 'three t) ; => false
