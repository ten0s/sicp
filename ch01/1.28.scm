(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 ; better refactor it ;-)
		 (let*
			 ((rt (expmod base (/ exp 2) m))
			  (sq (square rt))
			  (rm (remainder sq m)))
		   (if (and (not (or (= rt 1) (= rt (- m 1))))
					(= rm 1))
			   0
			   rm)))
		(else
		 (remainder (* base (expmod base (- exp 1) m))
					m))))

(define (miller-rabin-test n)
  (define (try-it a)
	(= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
		((miller-rabin-test n) (fast-prime? n (- times 1)))
		(else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 1)
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

(define (next n) (if (= n 2) 3 (+ n 2)))
