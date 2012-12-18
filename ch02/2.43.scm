;
; sequences funs
;
(define (enumerate-interval low high)
  (if (> low high)
	  '()
	  (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op init seq)
  (if (null? seq)
	  init
	  (op (car seq)
		  (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

;
; queens
;
(define (queens board-size)
  (define (queen-cols k)
	(if (= k 0)
		(list empty-board)
		(filter
		 (lambda (position) (safe? k position))
		 (flatmap
		  (lambda (new-row)
			(map (lambda (rest-of-queens)
				   (adjoin-position new-row k rest-of-queens))
				 (queen-cols (- k 1))))
		  (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

(define empty-board '())

(define (safe? k position)
  (not
   (or
	(horizontal-conflict? k position)
	(forward-diagonal-conflict? k position)
	(backward-diagonal-conflict? k position)
)))

(define (remove n seq)
  (filter (lambda (x) (not (= n x))) seq))

(define (unique? seq)
  (if (null? seq)
	  true
	  (let ((len1 (length seq))
			(len2 (length (remove (car seq) seq))))
		(if (= len2 (- len1 1))
			(unique? (cdr seq))
			false))))

(define (reverse seq)
  (accumulate (lambda (x acc) (append acc (list x))) '() seq))

(define (horizontal-conflict? _k position)
  (not (unique? position)))

(define (forward-diagonal-conflict? k position)
  (define (car-match? seq1 seq2)
	(cond ((null? seq1) false)
		  ((null? seq2) false)
		  ((= (car seq1) (car seq2)) true)
		  (else (car-match? (cdr seq1) (cdr seq2)))))
  (define (conflict? k position)
	(let ((diagonal-values (enumerate-interval (1+ (car position)) k)))
	  (car-match? diagonal-values (cdr position))))
  (cond ((null? position) false)
		((conflict? k position) true)
		(else (forward-diagonal-conflict? k (cdr position)))))

(define (backward-diagonal-conflict? k position)
  (forward-diagonal-conflict? k (reverse position)))

(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list new-row)))

;
; 2.43
;
; Louis regenerates entire k-1 solutions on every k iteration.
; Runtime estimation is T!, i.e. factorial of T
