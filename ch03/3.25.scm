(define (make-table)
  (cons '*table* '()))

(define (assoc key records)
  (cond ((null? records) false)
		((equal? key (caar records)) (car records))
		(else (assoc key (cdr records)))))

(define (lookup keys table)
  (cond ((null? keys) false)
		((null? table) false)
		((not (list? table)) false)
		(else
		 (let ((subtable (assoc (car keys) (cdr table))))
		   (if subtable
			   (if (= (length keys) 1) ; if this is the last key
				   (cdr subtable) ; return the value
				   (lookup (cdr keys) subtable)) ; continue recursively otherwize
			   false)))))

(define (insert! keys value table)
  (let* ((key (car keys))
		 (subtable (assoc key (cdr table))))
	(if subtable
		; true
		(if (= (length keys) 1)
			 (set-cdr! subtable value)
			 (insert! (cdr keys) value subtable))
		; false
		(let ((new-subtable (cons (cons key '())
								  (cdr table))))
		  (set-cdr! table new-subtable)
		  (insert! keys value table))))
  'ok)

;
; tests
;
(define t1 (make-table))
(insert! '(0) 'zero t1)
(insert! '(1) 'one t1)
(lookup '(0) t1)
(insert! '(0) 'zeroq t1)
(lookup '(0) t1)
(lookup '(1) t1)
(lookup '(2) t1)

(define t2 (make-table))
(insert! '(0 1) 'zero-one t2)
(insert! '(0 2) 'zero-two t2)
(insert! '(1 2) 'one-two t2)
(lookup '(0 1) t2)
(lookup '(0 2) t2)
(lookup '(1 2) t2)
(lookup '(2 3) t2)

(define t3 (make-table))
(insert! '(0 1 2) 'zero-one-two t3)
(insert! '(1 2 3) 'one-two-three t3)
(lookup '(0 1 2) t3)
(lookup '(1 2 3) t3)
