(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (rand)
  (random 1000000000))

(define (monte-carlo trials expreriment)
  (define (iter trials-remaining trials-passed)
	(cond ((= trials-remaining 0)
		   (/ trials-passed trials))
		  ((expreriment)
		   (iter (- trials-remaining 1) (+ trials-passed 1)))
		  (else
		   (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

; (estimate-pi 1000000)  ; => 3.1424847270408667
; (estimate-pi 10000000) ; => 3.1413495457158005

; 3.5
(define (estimate-integral predicate x1 x2 y1 y2 trials)
  (define (integral-test)
	(let ((x (random-interval x1 x2))
		  (y (random-interval y1 y2)))
	  (predicate x y)))
  (let ((rectangle-area (* (- x2 x1) (- y2 y1)))
		(positive-percentage (monte-carlo trials integral-test)))
	(* rectangle-area positive-percentage)))

(define (estimate-pi-v2 trials)
  (define (in-unit-circle? x y)
	(<= (+ (square x) (square y)) 1))
  (estimate-integral in-unit-circle? -1.0 1.0 -1.0 1.0 trials))

(define (random-interval lower-bound upper-bound)
  (let* ((interval-length (- upper-bound lower-bound))
		 (offset-from-zero (- lower-bound 0))
		 (random-value (random interval-length)))
	(+ random-value offset-from-zero)))

; (estimate-pi-v2 100000)  ; => 3.14276
; (estimate-pi-v2 1000000) ; => 3.14228
