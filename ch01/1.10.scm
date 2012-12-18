(define (A x y)
  (cond ((= y 0) 0)
		((= x 0) (* 2 y))
		((= y 1) 2)
		(else (A (- x 1)
				 (A x (- y 1))))))

; (A 1 10) == 2^10 == 1024
; (A 2 4) == 2^16 == 65356
; (A 3 3) == 2^16 == 65356

(define (f n) (A 0 n)) ; == 2n

(define (g n) (A 1 n)) ; == 2^n

(define (h n) (A 2 n))
;(A 2 0)          == 0
;(A 2 1) == 2     == 2
;(A 2 2) == 4     == 2^2
;(A 2 3) == 16    == 2^2^2
;(A 2 4) == 65356 == 2^2^2^2
;(A 2 5) == ...   == 2^2^2^2^2

; linear iterative process
(define (pow x y)
  (pow-iter 1 x y))

(define (pow-iter acc x y)
  (if (= y 0)
	  acc
	  (pow-iter (* acc x) x (- y 1))))

; linear recursive process
(define (pow x y)
  (if (= y 0)
	  1
	  (* x (pow x (- y 1)))))
