;;;
;;; point
;;;

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

;;;
;;; segment
;;;

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

;;;
;;; rect
;;;

(define (make-rect tl-point br-point)
  (make-segment tl-point br-point))

(define (tl-point rect)
  (start-segment rect))

(define (br-point rect)
  (end-segment rect))

(define (rect-width rect)
  (let ((tl (tl-point rect))
		 (br (br-point rect)))
	(abs (- (x-point br) (x-point tl)))))

(define (rect-height rect)
  (let ((tl (tl-point rect))
		 (br (br-point rect)))
	(abs (- (y-point br) (y-point tl)))))

(define (rect-perimeter rect)
  (+ (* 2 (rect-width rect))
	 (* 2 (rect-height rect))))

(define (rect-area rect)
  (* (rect-width rect)
	 (rect-height rect)))

; I can easily get rid of segment undelying structure and directly
; use cons, car, cdr instead, without any modifications outside
; make-rect, tl-point, and br-point functions.
