(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder (square (expmod base (/ exp 2) m))
					m))
		(else
		 (remainder (* base (expmod base (- exp 1) m))
					m))))

(define (fermat-test n)
  (define (try-it a)
	(= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
		((fermat-test n) (fast-prime? n (- times 1)))
		(else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 1000)
	  (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes actual max)
  (if (> actual max)
	  'done
	  (begin
		(timed-prime-test actual)
		(search-for-primes (+ actual 1) max))))

; one additional level of indirection causes
; minor performance decrease.

; we don't see precisely doubled performance boost
; due to the interpreter has to evaluate the special `if' form

;(define (next n) (+ n 1))
(define (next n) (if (= n 2) 3 (+ n 2)))

(timed-prime-test 10000000019)
;0.44999999999998863
;0.25
;0.22000000000002728
(timed-prime-test 10000000033)
;0.46000000000000796
;0.25
;0.20999999999997954
(timed-prime-test 10000000061)
;0.46000000000000796
;0.2599999999999909
;0.21999999999997044

(timed-prime-test 100000000003)
;1.4499999999999886
;0.8100000000000023
;0.2400000000000091
(timed-prime-test 100000000019)
;1.4799999999999898
;0.8100000000000023
;0.2400000000000091
(timed-prime-test 100000000057)
;1.4399999999999977
;0.8199999999999932
;0.25

(timed-prime-test 1000000000039)
;4.600000000000023
;2.57000000000005
;0.25
(timed-prime-test 1000000000061)
;4.610000000000014
;2.569999999999993
;0.2599999999999909
(timed-prime-test 1000000000063)
;4.589999999999975
;2.569999999999993
;0.27000000000003865

(timed-prime-test 10000000000037)
;14.689999999999998
;8.159999999999968
;0.2799999999999727
(timed-prime-test 10000000000051)
;14.649999999999977
;8.180000000000007
;0.29000000000002046
(timed-prime-test 10000000000099)
;14.680000000000007
;8.120000000000005
;0.2799999999999727
