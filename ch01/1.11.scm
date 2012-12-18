; tree-recursive process
; (f 30) ==> 61354575194 > 60 secs
(define (f n)
  (if (< n 3)
	  n
	  (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

; linear iterative process
; (f 30) ==> 61354575194 instantly :)
(define (f n)
  (if (< n 3)
	  n
	  (f-iter 0 1 2 n)))

(define (f-iter a b c n)
  (if (= n 2)
	  c
	  (f-iter b c (+ c (* 2 b) (* 3 a)) (- n 1))))
