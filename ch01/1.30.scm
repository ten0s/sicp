; 1.30
(define (sum term a next b)
  (define (iter a result)
	(if (> a b)
		result
		(iter (next a) (+ (term a) result))))
  (iter a 0))

(define (cube x)
  (* x x x))
(define (inc x)
  (+ x 1))
(define (sum-cubes a b)
  (sum cube a inc b))

(define (id x) x)
(define (sum-integers a b)
  (sum id a inc b))

(define (pi-sum a b)
  (define (pi-term x)
	(/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
	(+ x 4))
  (sum pi-term a pi-next b))

(define (integral f a b dx)
  (define (add-dx x)
	(+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (integral-simpson-rule f a b n)
  (define (coeff k)
	(cond ((= k 0) 1)
		  ((= k n) 1)
		  ((even? k) 2)
		  (else 4)))
  (let ((h (* 1.0 (/ (- b a) n))))
	(define (yk k)
	  (* (coeff k) (f (+ a (* k h)))))
	(* (/ h 3) (sum yk 0 inc n))))
