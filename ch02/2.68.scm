(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
		right
		(append (symbols left) (symbols right))
		(+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
	  (list (symbol-leaf tree))
	  (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
	  (weight-leaf tree)
	  (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
	(if (null? bits)
		'()
		(let ((next-branch (choose-branch (car bits) current-branch)))
		  (if (leaf? next-branch)
			  (cons (symbol-leaf next-branch)
					(decode-1 (cdr bits) tree))
			  (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
		((= bit 1) (right-branch branch))
		(else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
		((< (weight x) (weight (car set))) (cons x set))
		(else (cons (car set)
					(adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
	  '()
	  (let ((pair (car pairs)))
		(adjoin-set (make-leaf (car pair)   ; symbol
							   (cadr pair)) ; frequency
					(make-leaf-set (cdr pairs))))))

; 2.68
(define (encode message tree)
  (if (null? message)
	  '()
	  (append (encode-symbol (car message) tree)
			  (encode (cdr message) tree))))

(define (element-of-set? x set)
  (cond ((null? set) false)
		((equal? x (car set)) true)
		(else (element-of-set? x (cdr set)))))

(define (encode-symbol symbol tree)
	(encode-symbol-iter symbol tree '()))

(define (encode-symbol-iter symbol tree acc)
  (if (leaf? tree)
	  (if (equal? symbol (symbol-leaf tree))
		  (reverse acc)
		  (error "bad symbol -- ENCODE-BRANCH" symbol))
	  (let ((left (left-branch tree)))
		(if (symbol-in-branch? symbol left)
			(encode-symbol-iter symbol left (cons 0 acc))
			(let ((right (right-branch tree)))
			  (encode-symbol-iter symbol right (cons 1 acc)))))))

(define (symbol-in-branch? symbol tree)
  (if (leaf? tree)
	  (equal? symbol (symbol-leaf tree))
	  (element-of-set? symbol (symbols tree))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
				  (make-code-tree
				   (make-leaf 'B 2)
				   (make-code-tree (make-leaf 'D 1)
								   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-tree) ; => (a d a b b c a)

; test
(equal? (encode (decode sample-message
						sample-tree)
				sample-tree)
		'(0 1 1 0 0 1 0 1 0 1 1 1 0)) ; => true

(encode-symbol 'E sample-tree) ; => bad symbol -- ENCODE-BRANCH e
