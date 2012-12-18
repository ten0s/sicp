(define (member? item list)
  (list? (member item list)))

(define (contains-cycle? list)
  (define (cycle pair visited-pairs)
	(cond ((not (pair? pair)) false)
		  ((null? pair) false)
		  ((member? pair visited-pairs) true)
		  (else (cycle (cdr pair) (cons pair visited-pairs)))))
  (cycle list '()))

(define finite-list '(a b c))

;
; finity-list--->[*][*]--->[*][*]--->[*][/]
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
