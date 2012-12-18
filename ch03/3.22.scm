(define (make-queue)
  (let ((front-ptr '())
		(rear-ptr '()))
	(define (empty-queue?)
	  (null? front-ptr))
	(define (front-queue)
	  (if (empty-queue?)
		  (error "FRONT called with an empty queue")
		  (car front-ptr)))
	(define (set-front-ptr! item) (set! front-ptr item))
	(define (set-rear-ptr! item) (set! rear-ptr item))
	(define (insert-queue! item)
	  (let ((new-pair (cons item '())))
		(cond ((empty-queue?)
			   (set-front-ptr! new-pair)
			   (set-rear-ptr! new-pair))
			  (else
			   (set-cdr! rear-ptr new-pair)
			   (set-rear-ptr! new-pair)))))
	(define (delete-queue!)
	  (cond ((empty-queue?)
			 (error "DELETE! called with an empty queue"))
			(else
			 (set-front-ptr! (cdr front-ptr)))))
	(define (print-queue)
	  (if (empty-queue?)
		  '()
		  front-ptr))
	(define (dispatch m)
	  (cond ((eq? m 'empty-queue?) (empty-queue?))
			((eq? m 'front-queue) (front-queue))
			((eq? m 'insert-queue!) insert-queue!)
			((eq? m 'delete-queue!) (delete-queue!))
			((eq? m 'print-queue) (print-queue))
			(else
			 (error "Undefined operation -- DISPATH" m))))
	dispatch))

(define (empty-queue? queue) (queue 'empty-queue?))
(define (front-queue queue) (queue 'front-queue))
(define (insert-queue! queue item) ((queue 'insert-queue!) item) queue)
(define (delete-queue! queue) (queue 'delete-queue!) queue)
(define (print-queue queue) (queue 'print-queue))

;
; tests
;

(load "test-manager/load.scm")
(in-test-group
 queue-tests

 (define-test (test)
   (define q (make-queue))
   (assert-true (empty-queue? q))
   (insert-queue! q 'a)
   (assert-false (empty-queue? q))
   (assert-equal 'a (front-queue q))
   (insert-queue! q 'b)
   (assert-equal 'a (front-queue q))
   (delete-queue! q)
   (assert-equal 'b (front-queue q))
   (delete-queue! q)
   (assert-true (empty-queue? q)))

 (define-test (interactive)
   (interaction
	(define q (make-queue))
	(print-queue q)
	(produces '())
	(insert-queue! q 'a)
	(print-queue q)
	(produces '(a))
	(insert-queue! q 'b)
	(print-queue q)
	(produces '(a b)))))

(run-test '(queue-tests))
