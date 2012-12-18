(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
		((even? count)
		 (fib-iter a
				   b
				   (+ (* p p) (* q q))
				   (+ (* q q) (* 2 p q))
				   (/ count 2)))
		(else (fib-iter (+ (* b q) (* a q) (* a p))
						(+ (* b p) (* a q))
						p
						q
						(- count 1)))))

Tpq
a1 = bq + aq + ap
b1 = bp + aq

a2 = b1q + a1q + a1p
b2 = b1p + a1q

    ||
   \  /
    \/

a2 = 2bpq + 2aq^2 + 2apq + ap^2 + bq^2 (1)
b2 = bp^2 + 2apq + bq^2 + aq^2         (2)


Tp1q1
a2 = bq1 + aq1 + ap1                   (3)
b2 = bp1 + aq1                         (4)

    ||
   \  /
    \/

p1 = (a2 - bq1 - aq1)/a                (5)
q1 = (b2 - bp1)/a                      (6)

substitute (2) into (6) and (7) into (5)

    ||
   \  /
    \/

q1 = (ab2 - a2b)/(a^2 - ab - b^2)      (7)
p1 = (a2 - bq1 - aq1)/a                (8)

substitute (1) and (2) into (7) and after many transformations painful :)

    ||
   \  /
    \/

q1 = q^2 + 2pq                         (9)

substitute (1) and (9) into 8 and after also so many paifull transformations

    ||
   \  /
    \/

p1 = p^2 + q^2                        (10)
