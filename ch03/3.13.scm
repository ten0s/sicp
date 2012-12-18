(define (last-pair x)
  (if (null? (cdr x))
	  x
	  (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle '(a b c)))

;
;       +----------------------+
;       |                      |
;       v                      |
; z--->[*][*]--->[*][*]--->[*][*]
;       |         |         |
;       v         v         v
;      [a]       [b]       [c]
;
; (last-pair z) will cycle infinitely.
;
