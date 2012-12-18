(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
	  angle
	  (p (sine (/ angle 3.0)))))

;(sine 12.15)
;(p (sine 4.05))
;(p (p (sine 1.35)))
;(p (p (p (sine 0.45))))
;(p (p (p (p (sine 0.15)))))
;(p (p (p (p (p (sine 0.05))))))
;(p (p (p (p (p 0.05)))))
;... depth 5, sine evaluated 6 times

;(sine 120.0)
;(p (sine 40.0))
;(p (p (sine 13.3)))
;(p (p (p (sine 4.4))))
;(p (p (p (p (sine 1.47)))))
;(p (p (p (p (p (sine 0.49))))))
;(p (p (p (p (p (p (sine 0.16)))))))
;(p (p (p (p (p (p (p (sine 0.05))))))))
;... depth 7, sine called 8 times

;(sine 1200)
;(p (sine 400))
;(p (p (sine 133.33)))
;(p (p (p (sine 44.43))))
;(p (p (p (p (sine 14.81)))))
;(p (p (p (p (p (sine 4.94))))))
;(p (p (p (p (p (p (sine 1.65)))))))
;(p (p (p (p (p (p (p (sine 0.55))))))))
;(p (p (p (p (p (p (p (p (sine 0.18)))))))))
;(p (p (p (p (p (p (p (p (p (sine 0.06))))))))))
;... depth 9, sine called 10 times

; procedure p is evaluated 5 times for (sine 12.15)
; Space O(logn)
; Time O(logn)
