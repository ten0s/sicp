(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (print-point point)
  (display "(")
  (display (x-point point))
  (display ",")
  (display (y-point point))
  (display ")"))

(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (midpoint-segment segment)
  (let* ((s (start-segment segment))
		 (e (end-segment segment))
		 (mid-x (average (x-point s) (x-point e)))
		 (mid-y (average (y-point s) (y-point e))))
	(make-point mid-x mid-y)))

(define (print-segment segment)
  (display "{")
  (print-point (x-point segment))
  (display ",")
  (print-point (y-point segment))
  (display "}"))

(define (average x y)
  (/ (+ x y) 2))
