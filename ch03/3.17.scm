(define (member? item list)
  (list? (member item list)))

(define (refined-count-pairs pairs)
  (define (count-pairs pair visited-pairs)
	(cond ((not (pair? pair)) 0)
		  ((and (pair? pair) (member? pair visited-pairs)) 0)
		  (else
		   (+ (count-pairs (car x) (cons pair visited-pairs))
			  (count-pairs (cdr x) (cons pair visited-pairs))
			  1))))
  (count-pairs pairs '()))

(define three-pairs '(a b c))

;
; tree-pairs--->[*][*]--->[*][*]--->[*][/]
;                |         |         |
;                v         v         v
;               [a]       [b]       [c]
;

(refined-count-pairs three-pairs) ; => 3


(define b-nil (cons 'b '()))
(define four-pairs (cons 'a (cons b-nil b-nil)))

;
; four-pairs--->[*][*]--->[*][*]
;                |         |  |
;                v         v  v
;               [a]       [*][/]
;                          |
;                          v
;                         [b]
;

(refined-count-pairs four-pairs) ; => 3


(define a.a (cons 'a 'a))
(define a.a-a.a (cons a.a a.a))
(define seven-pairs (cons a.a-a.a a.a-a.a))

;
; seven-pairs--->[*][*]
;                 |  |
;                 v  v
;                [*][*]
;                 |  |
;                 v  v
;                [*][*]
;                 |  |
;              +--+  |
;              |     |
;              v     |
;             [a]<---+
;

(refined-count-pairs seven-pairs) ; => 3


(define (last-pair x)
  (if (null? (cdr x))
	  x
	  (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define infinity-pairs (make-cycle '(a b c)))

;
;                    +----------------------+
;                    |                      |
;                    v                      |
; infinity-pairs--->[*][*]--->[*][*]--->[*][*]
;                    |         |         |
;                    v         v         v
;                   [a]       [b]       [c]
;

(refined-count-pairs infinity-pairs) ; => 3
