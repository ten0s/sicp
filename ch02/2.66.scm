(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; 2.66
(define (make-record key value)
  (cons key value))
(define (record-key record)
  (car record))
(define (record-value record)
  (cadr record))

(define (lookup key set-of-records)
  (if (null? set-of-records)
	  false
	  (let* ((curr-entry (entry set-of-records))
			 (curr-key (record-key curr-entry)))
		(cond ((= key curr-key) curr-entry)
			  ((< key curr-key) (lookup key (left-branch set-of-records)))
			  ((> key curr-key) (lookup key (right-branch set-of-records)))))))

(define tree
  '((2 . two)
	((1 . one) () ())
	((3 . three) () ())))
