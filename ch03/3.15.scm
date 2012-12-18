(define x (list 'a 'b))
(define z1 (cons x x))

;
; z1--->[*][*]
;        |  |
;        v  v
;  x--->[*][*]--->[*][/]
;        |         |
;        v         v
;       [a]       [b]
;

(define z2 (cons (list 'a 'b) (list 'a 'b)))

;
; z2--->[*][*]--->[*][*]--->[*][/]
;        |         |         |
;        |         v         v
;        |        [a]       [b]
;        |         ^         ^
;        |         |         |
;        +------->[*][*]--->[*][/]
;

(eq? z1 z2)    ; => false
(equal? z1 z2) ; => true

(define (set-to-wow! x)
  (set-car! (car x) 'wow)
  x)

(set-to-wow! z1) ; => ((wow b) wow b)

;
;z1'--->[*][*]
;        |  |
;        v  v
; x'--->[*][*]--->[*][/]
;        |         |
;        v         v
;      [wow]      [b]
;

(set-to-wow! z2) ; => ((wow b) a b)

;
;z2'--->[*][*]--->[*][*]--->[*][/]
;        |         |         |
;        |         v         v
;        |        [a]       [b]
;        |                   ^
;        |                   |
;        +------->[*][*]--->[*][/]
;                  |
;                  v
;                [wow]
;
