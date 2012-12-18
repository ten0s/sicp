;
; sequence funs
;
(define (accumulate op init seq)
  (if (null? seq)
	  init
	  (op (car seq)
		  (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

;
; 2.42
;
(define (unique-triples n)
  (flatmap (lambda (i)
			 (flatmap (lambda (j)
					(map (lambda (k) (list i j k))
						 (enumerate-interval 1 (- j 1))))
				  (enumerate-interval 2 (- i 1))))
		   (enumerate-interval 3 n)))

(define (sum list)
  (accumulate + 0 list))

(define (ordered-triples-less-than-n-that-sum-to-s n s)
  (filter (lambda (triple) (= (sum triple) s))
		  (unique-triples n)))
