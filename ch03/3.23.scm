;
; node
;
(define (make-node item) (cons item (cons '() '())))
(define (item-node node) (car node))
(define (front-ptr-node node) (cadr node))
(define (rear-ptr-node node) (cddr node))
(define (set-front-ptr-node! node ptr) (set-car! (cdr node) ptr))
(define (set-rear-ptr-node! node ptr) (set-cdr! (cdr node) ptr))

;
; deque
;
(define (make-deque) (cons '() '()))

(define (front-ptr-deque deque) (car deque))
(define (rear-ptr-deque deque) (cdr deque))

(define (set-front-ptr-deque! deque ptr) (set-car! deque ptr))
(define (set-rear-ptr-deque! deque ptr) (set-cdr! deque ptr))

(define (empty-deque? deque) (null? (front-ptr deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
	  (error "Empty queue -- FRONT-DEQUE" deque)
	  (item-node (front-ptr-deque deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
	  (error "Empty queue -- REAR-DEQUE" deque)
	  (item-node (rear-ptr-deque deque))))

(define (front-insert-deque! deque item)
  (let ((new-node (make-node item)))
	(cond ((empty-deque? deque)
		   (set-front-ptr-deque! deque new-node)
		   (set-rear-ptr-deque! deque new-node)
		   deque)
		  (else
		   (set-front-ptr-node! new-node (front-ptr-deque deque))
		   (set-rear-ptr-node! (front-ptr-deque deque) new-node)
		   (set-front-ptr-deque! deque new-node)
		   deque))))

(define (rear-insert-deque! deque item)
  (let ((new-node (make-node item)))
	(cond ((empty-deque? deque)
		   (set-front-ptr-deque! deque new-node)
		   (set-rear-ptr-deque! deque new-node)
		   deque)
		  (else
		   (set-rear-ptr-node! new-node (rear-ptr-deque deque))
		   (set-front-ptr-node! (rear-ptr-deque deque) new-node)
		   (set-rear-ptr-deque! deque new-node)
		   deque))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
		 (error "Empty queue -- FRONT-DELETE-DEQUE!" deque))
		(else
		 (let* ((first-node (front-ptr-deque deque))
				(next-node (front-ptr-node first-node)))
		   (if (null? next-node)
			   (begin
				 (set-front-ptr-deque! deque '())
				 (set-rear-ptr-deque! deque '()))
			   (begin
				 (set-front-ptr-deque! deque next-node)
				 (set-rear-ptr-node! next-node '())))
		   deque))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
		 (error "Empty queue -- REAR-DELETE-DEQUE!" deque))
		(else
		 (let* ((last-node (rear-ptr-deque deque))
				(prev-node (rear-ptr-node last-node)))
		   (if (null? prev-node)
			   (begin
				 (set-front-ptr-deque! deque '())
				 (set-rear-ptr-deque! deque '()))
			   (begin
				 (set-rear-ptr-deque! deque prev-node)
				 (set-front-ptr-node! prev-node '())))
		   deque))))

(define (print-deque deque)
  (if (empty-deque? deque)
	  '()
	  (print-nodes (front-ptr-deque deque))))

(define (print-nodes nodes)
  (if (null? nodes)
	  '()
	  (cons (item-node nodes)
			(print-nodes (front-ptr-node nodes)))))

;
; tests
;

(define d (make-deque))

(front-insert-deque! d 'a)
(front-deque d) ; => a
(rear-deque d) ; => a
(print-deque d) ; => (a)

(front-insert-deque! d 'b)
(front-deque d) ; => b
(rear-deque d) ; => a
(print-deque d) ; => (b a)

(rear-insert-deque! d 'c)
(front-deque d) ; => b
(rear-deque d) ; => c
(print-deque d) ; => (b a c)

(front-delete-deque! d)
(front-deque d) ; => a
(rear-deque d) ; => c
(print-deque d) ; => (a c)

(rear-delete-deque! d)
(front-deque d) ; => a
(rear-deque d) ; => a
(print-deque d) ; => (a)

(rear-delete-deque! d)
(empty-deque? d) ; => #t
(print-deque d) ; => ()
