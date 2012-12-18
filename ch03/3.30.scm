(define (ripple-carry-adder a b s c-out)
  (if (not (= (length a) (length b) (length s)))
	  (error "Vectors are not equal " a b s)
	  (ripple-carry-adder-helper a b s c-out)))

(define (ripple-carry-adder-helper a b s c-out)
  (if (null? a)
	  'ok
	  (let ((a-k (car a))
			(b-k (car b))
			(s-k (car s))
			(c-in-k (make-wire)))
		(full-adder a-k b-k c-in-k s c-out)
		(ripple-carry-adder-helper (cdr a) (cdr b) (cdr s) c-in-k))))

;
; test
;
(define a1 (make-wire))
(define a2 (make-wire))
(define a3 (make-wire))
(define a4 (make-wire))

(define b1 (make-wire))
(define b2 (make-wire))
(define b3 (make-wire))
(define b4 (make-wire))

(define s1 (make-wire))
(define s2 (make-wire))
(define s3 (make-wire))
(define s4 (make-wire))

(define c (make-wire))

(ripple-carry-adder (list a1 a2 a3 a4)
					(list b1 b2 b3 b4)
					(list s1 s2 s3 s4)
					c)

(set-signal! a1 1)
(propagate)