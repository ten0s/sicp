(define zero (lambda (f) (lambda (x) x)))

(define (add-one n)
  (lambda (f) (lambda (x) (f ((n f) x)))))


; by substituting (add-one zero) we get
(lambda (f) (lambda (x) (f x))) ; => one

(define one (lambda (f) (lambda (x) (f x))))


; by substitution (add-one one) we get
(lambda (f) (lambda (x) (f (f x)))) ; => two

(define two (lambda (f) (lambda (x) (f (f x)))))


; by looking for a pattern in zero, one, and two we can realize that
(define (add-two n)
  (lambda (f) (lambda (x) (f (f ((n f) x))))))

; and to generalize it futher to
(define (add m n)
  (lambda (f) (lambda (x) (m ((n f)) x))))

; ||
; \/

(define zero (lambda (f) (lambda (x) x)))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
; ...

(define (add-one n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
(define (add-two n)
  (lambda (f) (lambda (x) (f (f ((n f) x))))))
;  ...

(define (add m n)
  (lambda (f) (lambda (x) (m ((n f)) x))))
