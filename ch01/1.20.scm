(define rem remainder)

(define (gcd a b)
  (if (= b 0)
	  a
	  (gcd b (rem a b))))

;
; Normal order evaluation
;
(gcd 206 40)

(if (= 40 0)
	206
	(gcd 40 (rem 206 40)))

(gcd 40 (rem 206 40))

(if (= (rem 206 40) 0)
	40
	(gcd
	 (rem 206 40)
	 (rem 40 (rem 206 40))))

; if form evaluates (rem 206 40) to 6
; rem is evaluated 1 time so far

(if (= 6 0)
	40
	(gcd
	 (rem 206 40)
	 (rem 40 (rem 206 40))))

(gcd
 (rem 206 40)
 (rem 40 (rem 206 40)))

(if (= (rem 40 (rem 206 40)) 0)
	(rem 206 40)
	(gcd
	 (rem 40 (rem 206 40))
	 (rem (rem 206 40) (rem 40 (rem 206 40)))))

; if form evaluates (rem 40 (rem 206 40)) to 4
; rem is evaluated 3 times so far

(if (= 4 0)
	(rem 206 40)
	(gcd
	 (rem 40 (rem 206 40))
	 (rem (rem 206 40) (rem 40 (rem 206 40)))))

(gcd
 (rem 40 (rem 206 40))
 (rem (rem 206 40) (rem 40 (rem 206 40))))

(if (= (rem (rem 206 40) (rem 40 (rem 206 40))) 0)
	(rem 40 (rem 206 40))
	(gcd
	 (rem (rem 206 40) (rem 40 (rem 206 40)))
	 (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40))))))

; if form evaluates (rem (rem 206 40) (rem 40 (rem 206 40))) to 2
; rem is evaluated 7 times so far

(if (= 2 0)
	(rem 40 (rem 206 40))
	(gcd
	 (rem (rem 206 40) (rem 40 (rem 206 40)))
	 (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40))))))

(gcd
 (rem (rem 206 40) (rem 40 (rem 206 40)))
 (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40)))))

(if (= (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40)))) 0)
	(rem (rem 206 40) (rem 40 (rem 206 40)))
	(gcd
	 (rem (rem 206 40) (rem 40 (rem 206 40)))
	 (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40))))))

; if form evaluates (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40)))) to 0
; rem is evaluated 14 times so far

(if (= 0 0)
	(rem (rem 206 40) (rem 40 (rem 206 40)))
	(gcd
	 (rem (rem 206 40) (rem 40 (rem 206 40)))
	 (rem (rem 40 (rem 206 40)) (rem (rem 206 40) (rem 40 (rem 206 40))))))

(rem (rem 206 40) (rem 40 (rem 206 40)))
; rem is evaluated 18 times so far
2

;
; Applicative order evaluation
;
(gcd 206 40)

(if (= 40 0)
	206
	(gcd 40 (rem 206 40)))

(gcd 40 (rem 206 40))
; (rem 206 40) evaluates to 6
; rem is evaluated 1 time so far

(gcd 40 6)

(if (= 6 0)
	40
	(gcd 6 (rem 40 6)))

(gcd 6 (rem 40 6))
; (rem 40 6) evaluates to 4
; rem is evaluates 2 times so far

(gcd 6 4)

(if (= 4 0)
	6
	(gcd 4 (rem 6 4)))

(gcd 4 (rem 6 4))
; (rem 6 4) evaluates to 2
; rem is evaluates 3 times so far

(gcd 4 2)

(if (= 2 0)
	4
	(gcd 2 (rem 4 2)))

(gcd 2 (rem 4 2))
; (rem 4 2) evaluates to 0
; rem is evaluates 4 times so far

(gcd 2 0)

(if (= 0 0)
	2
	(gcd 0 (rem 2 0)))
2

; rem is evaluated 18 times in Normal evaluation order
; rem is evaluated 4 times in Applicative evaluation order
