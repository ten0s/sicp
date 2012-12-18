(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder (* (expmod base (/ exp 2) m)
					   (expmod base (/ exp 2) m))
					m))
		(else
		 (remainder (* base (expmod base (- exp 1) m))
					m))))

; original function has Time O(logn), because on almost every iteration exp is divided
; by two, thus producing the logarithmic growing complexity.
; by writing the function like that we neutralize the fact of halving exp by executing the ; same procedure twice, this leads to Time O(n).

