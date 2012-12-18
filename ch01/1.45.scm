(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enuf? v1 v2)
	(< (abs (- v1 v2)) tolerance))
  (define (try guess)
	(trace guess)
	(let ((next (f guess)))
	  (if (close-enuf? guess next)
		  next
		  (try next))))
  (try first-guess))

(define (trace x)
  (display x)
  (newline))

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (id x) x)
  (if (= n 0) id
	  (compose f (repeated f (- n 1)))))

(define (sqrt x)
  (nth-root 2 x))

(define (cube-root x)
  (nth-root 3 x))

(define (fourth-root x)
  (nth-root 4 x))

(define (pow b n)
  (define (pow-iter b n a)
	(cond ((= n 0) 1)
		  ((= n 1) (* b a))
		  ((even? n) (pow-iter (* b b) (/ n 2) a))
		  (else (pow-iter b (- n 1) (* b a)))))
  (pow-iter b n 1))

(define (nth-root n x)
  (let ((damp-count (floor (/ (log n) (log 2)))))
	(fixed-point
	 ((repeated average-damp damp-count)
	  (lambda (y) (/ x (pow y (- n 1)))))
	 1.0)))

(define (test-nth-root n)
  (nth-root n (pow 2 n)))

; n| 2 3 4 5 6 7 8 ... 15 16 ... 31 32 ... 63 64 ... n
; -------------------------------------------------------------------
; #| 1 1 2 2 2 2 3 ...  3  4 ...  4  5 ...  5  6 ... (floor (log 2 n))

