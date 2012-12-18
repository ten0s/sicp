(define (accumulate op initial sequence)
  (if (null? sequence)
	  initial
	  (op (car sequence)
		  (accumulate op initial (cdr sequence)))))

; 2.33
(define (map p sequence)
  (accumulate (lambda (x acc) (cons (p x) acc)) '() sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (_x acc) (1+ acc)) 0 sequence))
