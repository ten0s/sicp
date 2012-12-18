;;; big numbers cause infinite recursion in sqrt-iter
;;; due to impossibility in good-enough? function to ever
;;; reach the decision because of limited precision.
; (sqrt (square 452117799012347700))

;;; calculation of small numbers gives unsatisfactory
;;; wrong results.
; (sqrt (square 0.02)) ;Value: .0354008825558513 :(

(define (better-sqrt x)
  (better-sqrt-iter 0.9 1 x))

(define (better-sqrt-iter prev-guess next-guess x)
  (if (better-good-enough? prev-guess next-guess)
	  next-guess
	  (better-sqrt-iter next-guess
						(improve next-guess x)
						x)))

(define (better-good-enough? prev-guess next-guess)
  (< (/ (abs (- prev-guess next-guess)) prev-guess) 0.001))

; much better
(better-sqrt (square 452117799012347700)) ;Value: 452117800261202300. :)
(better-sqrt (square 0.02)) ;Value: 2.0000000050877154e-2 :)
