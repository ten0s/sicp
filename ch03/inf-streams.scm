(load "./ch03/streams.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))

(define no-sevens
  (stream-filter (lambda (x) (not (divisible? x 7)))
				 integers))

(define (sieve stream)
  (cons-stream
   (stream-car stream)
   (sieve (stream-filter
		   (lambda (x)
			 (not (divisible? x (stream-car stream))))
		   (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))

(define ones (cons-stream 1 ones))

(define integers (cons-stream 1 (add-streams ones integers)))

(define fibs
  (cons-stream 0
			   (cons-stream 1
							(add-streams (stream-cdr fibs)
										 fibs))))

(define double (cons-stream 1 (scale-stream double 2)))

(define primes
  (cons-stream
   2
   (stream-filter prime? (integers-starting-from 3))))

(define (prime? n)
  (define (iter ps)
	(cond ((> (square (stream-car ps)) n) true)
		  ((divisible? n (stream-car ps)) false)
		  (else (iter (stream-cdr ps)))))
  (iter primes))