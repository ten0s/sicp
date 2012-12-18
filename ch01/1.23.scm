(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		(else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

;(define (next n)
;  (+ n 1))
(define (next n)
  (if (= n 2)
	  3
	  (+ n 2)))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
	  (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes actual max)
  (if (> actual max)
	  "done"
	  (begin
		(timed-prime-test actual)
		(search-for-primes (+ actual 1) max))))

; function `(define (next n) (+ n 1))' itself introduces runtime stagnation comparing with 1.22 data

; max time 0.88
; max time 2.78 ~= (* (sqrt 10) 0.88) = 2.78
; max time 8.83 ~= (* (sqrt 10) 2.78) => 8.79

; function  `(define (next n) (if (= n 2) 3 (+ n 2)))' gives almost 2 times speedup. it's not equally 2 times because of `if' form evaluation.

; max time 0.49
; max time 1.56
; max time 4.93

(search-for-primes 100000000000 100000000100)
(search-for-primes 1000000000000 1000000000100)
(search-for-primes 10000000000000 10000000000100)
