(define (cube x)
  (* x x x))

(define (cube-root x)
  (cube-root-iter 0.9 1.0 x))

(define (cube-root-iter prev-guess next-guess x)
  ;(display next-guess)
  ;(display "\n")
  (if (better-good-enough? prev-guess next-guess)
	  next-guess
	  (cube-root-iter next-guess
					  (cube-improve next-guess x)
					  x)))

(define (cube-improve y x)
  (/ (+ (/ x (square y)) (* 2 y))
	 3.0))
