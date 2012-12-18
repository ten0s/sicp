;
; Implements Floyd's Tortoise and hare algorithm
; http://en.wikipedia.org/wiki/Cycle_detection
;
(define (contains-cycle? list)
  (define (loop l1 l2)
	(cond ((null? l1) false)
		  ((null? l2) false)
		  ((null? (cdr l1)) false)
		  ((or (null? (cdr l2)) (null? (cddr l2))) false)
		  (else
		   (let ((next-l1 (cdr l1))
				 (next-l2 (cddr l2)))
			 (if (eq? next-l1 next-l2)
				 true
				 (loop next-l1 next-l2))))))
  (loop list list))


(define finite-list '(a b c))

;
; finite-list--->[*][*]--->[*][*]--->[*][/]
;                 |         |         |
;                 v         v         v
;                [a]       [b]       [c]
;

(contains-cycle? finite-list) ; => false



(define (last-pair x)
  (if (null? (cdr x))
	  x
	  (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define infinite-list (make-cycle '(a b c)))

;
;                   +----------------------+
;                   |                      |
;                   v                      |
; infinite-list--->[*][*]--->[*][*]--->[*][*]
;                   |         |         |
;                   v         v         v
;                  [a]       [b]       [c]
;

(contains-cycle? infinite-list) ; => true
