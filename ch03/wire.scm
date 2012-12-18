(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
	(define (set-signal! new-value)
	  (if (not (= signal-value new-value))
		  (begin (set! signal-value new-value)
				 (call-each action-procedures))
		  'done))
	(define (accept-action-procedure! proc)
	  (set! action-procedures (cons proc action-procedures))
	  (proc))
	(define (dispatch m)
	  (cond ((eq? m 'get-signal) signal-value)
			((eq? m 'set-signal!) set-signal!)
			((eq? m 'get-procs) action-procedures)
			((eq? m 'add-action!) accept-action-procedure!)
			(else (error "Unknown operation -- WIRE" m))))
	dispatch))

(define (call-each procedures)
  (if (null? procedures)
	  'done
	  (begin
		((car procedures))
		(call-each (cdr procedures)))))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

(define (get-procs wire)
  (wire 'get-procs))
;
; Tests
;
(load "test-manager/load.scm")

(in-test-group
 wire-tests

 (define-test (wire-test)
   (define w (make-wire))
   (assert-equal 0 (get-signal w))

   (set-signal! w 1)
   (assert-equal 1 (get-signal w))

   ; check that the callback procedures are called
   (define flag1 0)
   (define flag2 0)
   (add-action! w (lambda () (set! flag1 (+ flag1 1))))
   (add-action! w (lambda () (set! flag2 (+ flag2 1))))

   ; signal is 1, set signal to 1 -- should call the functions (initial calls)
   (set-signal! w 1)
   (assert-equal 1 flag1)
   (assert-equal 1 flag2)

   ; signal is 1, set signal to 0 -- should call the functions
   (set-signal! w 0)
   (assert-equal 2 flag1)
   (assert-equal 2 flag2))

)
(run-test '(wire-tests))
