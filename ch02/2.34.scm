(define (accumulate op initial sequence)
  (if (null? sequence)
	  initial
	  (op (car sequence)
		  (accumulate op initial (cdr sequence)))))

; my initial solution
; (((an + 0)*x + an-1)*x + ... + a1)*x + a0
(define (hornel-eval x coeffs)
  (+ (accumulate (lambda (coeff acc) (* (+ coeff acc) x))
				 0
				 (cdr coeffs))
	 (car coeffs)))

; right solution
; (((0*x + an)*x + an-1)*x + ... + a1)*x + a0
(define (hornel-eval x coeffs)
  (accumulate (lambda (coeff acc) (+ (* x acc) coeff)) 0 coeffs))
