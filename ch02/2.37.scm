(define (accumulate op init seq)
  (if (null? seq)
	  init
	  (op (car seq)
		  (accumulate op init (cdr seq)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
	  '()
	  (cons (accumulate op init (map car seqs))
			(accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (w) (dot-product v w)) m))

(define (transpose m)
  (accumulate-n cons '() m))

(define (matrix-*-matrix m n)
  (let ((n-cols (transpose n)))
	(map (lambda (m-row)
		   (map (lambda (n-col) (dot-product m-row n-col)) n-cols))
		 m)))
; OR
(define (matrix-*-matrix m n)
  (let ((n-cols (transpose n)))
	(map (lambda (m-row) (matrix-*-vector n-cols v))
		 m)))
