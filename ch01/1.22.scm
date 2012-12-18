(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		(else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

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

(search-for-primes 100000000000 100000000100)
; max time 0.8

(search-for-primes 1000000000000 1000000000100)
; max time 2.6 ~= (* (sqrt 10) 0.8) = 2.5

(search-for-primes 10000000000000 10000000000100)
; max time 8.14 ~= (* (sqrt 10) 2.6) => 8.22

(search-for-primes 100000000000000 100000000000100)
; max time 25.5 ~= (* (sqrt 10) 8.14) => 25.7
