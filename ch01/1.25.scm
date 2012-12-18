(define (fermat-test n)
  (define (try-it a)
	(= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
		((fermat-test n) (fast-prime? n (- times 1)))
		(else false)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder (square (expmod base (/ exp 2) m))
					m))
		(else
		 (remainder (* base (expmod base (- exp 1) m))
					m))))

(define (expmod2 base exp m)
  (remainder (fast-exp base exp) m))

(define (fast-exp b n)
  (cond ((= n 0) 1)
		((even? n) (square (fast-exp b (/ n 2))))
		(else (* b (fast-exp b (- n 1))))))

(fast-prime? 11 3)

; both expmod and expmod2 give the same results
; they both have Time O(logn)and Space O(logn) complexity.
; but internally they work very differently.
; expmod internal state value never grows bigger than (square (- base 1)) due to constant modulos.
; expmod2 internal state value grows proportional to base^exp.
; as a consequence of this, it's impossible to use the expmod2 function to compute fast-prime2
; for big numbers. in my case numbers more than 3000 already computed with valuable delays.

(define r remainder)
(define s square)

(expmod 2 11 11)
(r (* 2 (expmod 2 10 11)) 11)
(r (* 2 (r (s (expmod 2 5 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 (expmod 2 4 11)) 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 (r (s (r (s (r (* 2 (expmod 2 0 11)) 11)) 11)) 11)) 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 (r (s (r (s (r (* 2 1) 11)) 11)) 11)) 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 (r (s (r (s (r 2 11)) 11)) 11)) 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 (r (s (r (s 2) 11)) 11)) 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 (r (s (r 4 11)) 11)) 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 (r (s 4) 11)) 11)) 11)) 11)
(r (* 2 (r (s (r (* 2 5) 11)) 11)) 11)
(r (* 2 (r (s (r 10 11)) 11)) 11)
(r (* 2 (r (s 10) 11)) 11)
(r (* 2 (r 100 11)) 11)
(r (* 2 1) 11)
(r 2 11)
2

(expmod2 2 11 11)
(r (fast-exp 2 11) 11)
(r (* 2 (fast-exp 2 10)) 11)
(r (* 2 (s (fast-exp 2 5))) 11)
(r (* 2 (s (* 2 (fast-exp 2 4)))) 11)
(r (* 2 (s (* 2 (s (fast-exp 2 2))))) 11)
(r (* 2 (s (* 2 (s (s (fast-exp 2 1)))))) 11)
(r (* 2 (s (* 2 (s (s (* 2 (fast-exp 2 0))))))) 11)
(r (* 2 (s (* 2 (s (s (* 2 1)))))) 11)
(r (* 2 (s (* 2 (s (s 2))))) 11)
(r (* 2 (s (* 2 (s 4)))) 11)
(r (* 2 (s (* 2 16))) 11)
(r (* 2 (s 32)) 11)
(r (* 2 1024) 11)
(r 2048 11)
2
