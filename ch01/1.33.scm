; 1.33
(define (accumulate-filter combiner null-value predicate term a next b)
  (define (iter predicate a result)
	(cond ((> a b) result)
		  ((predicate a) (iter predicate (next a) (combiner (term a) result)))
		  (else (iter predicate (next a) result))))
  (iter predicate a null-value))

(define (accumulate-filter combiner null-value predicate term a next b)
  (cond ((> a b) null-value)
		((predicate a)
		 (combiner (term a)
				   (accumulate-filter combiner null-value predicate term (next a) next b)))
		(else
		 (accumulate-filter combiner null-value predicate term (next a) next b))))

; 1.33 a
; the sum of the squares of the prime numbers in the interval a to b
(define (sum-of-prime-squares a b)
  (accumulate-filter + 0 prime? square a inc b))

; 1.33 b
; the product of all the positive integers less than n that are relatively prime to n
(define (product-of-pos-integers-relatively-prime-to n)
  (define (relatively-prime? i)
	(= (gcd i n) 1))
  (accumulate-filter * 1 relatively-prime? id 1 inc n))

;;;
;;; primes?
;;;
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		(else (find-divisor n (next test-divisor)))))

(define (next n) (if (= n 2) 3 (+ n 2)))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

;;;
;;; gcd
;;;
(define (gcd a b)
  (if (= b 0)
	  a
	  (gcd b (remainder a b))))


;;;
;;; helpers
;;;
(define (id x) x)

(define (inc x)
  (+ x 1))
