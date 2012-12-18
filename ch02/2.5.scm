(define (pow x n)
  (define (pow-iter x n res)
	(if (= n 0)
		res
		(pow-iter x (- n 1) (* x res))))
  (pow-iter x n 1))

(define (mult-count p m count)
  (if (= (remainder p m) 0)
	  (mult-count (/ p m) m (+ count 1))
	  count))

(define (cons a b)
  (* (pow 2 a)
	 (pow 3 b)))

(define (car p)
  (mult-count p 2 0))

(define (cdr p)
  (mult-count p 3 0))
