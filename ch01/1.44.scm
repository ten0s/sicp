(define (compose f g)
  (lambda (x) (f (g x))))

(define (id x) x)

(define (repeated f n)
  (if (= n 0) id
	  (compose f (repeated f (- n 1)))))

(define dx 0.00001)
(define (smooth f)
  (lambda (x)
	(/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))
