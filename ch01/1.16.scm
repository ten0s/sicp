(define (even? x)
  (= (remainder x 2) 0))

(define (square x)
  (* x x))

; linear recursive process
(define (fexp b n)
  (cond ((= n 0) 1)
		((even? n) (square (fexp b (/ n 2))))
		(else (* b (fexp b (- n 1))))))

; linear iterative process
(define (fexp2 b n)
  (fexp-iter b n 1))

(define (fexp-iter b n a)
  (cond ((= n 0) 1)
		((= n 1) (* b a))
		((even? n) (fexp-iter (* b b) (/ n 2) a))
		(else (fexp-iter b (- n 1) (* b a)))))
