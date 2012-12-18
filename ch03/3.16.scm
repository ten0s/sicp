(define (count-pairs x)
  (if (not (pair? x))
	  0
	  (+ (count-pairs (car x))
		 (count-pairs (cdr x))
		 1)))

(define three-pairs '(a b c))

;
; tree-pairs--->[*][*]--->[*][*]--->[*][/]
;                |         |         |
;                v         v         v
;               [a]       [b]       [c]
;

(count-pairs three-pairs) ; => 3


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

(count-pairs four-pairs) ; => 4


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

(count-pairs seven-pairs) ; => 4


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

(count-pairs infinity-pairs) ; => ;Aborting!: maximum recursion depth exceeded
