(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

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

(define (encode message tree)
  (if (null? message)
	  '()
	  (append (encode-symbol (car message) tree)
			  (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
	(if (not (element-of-set? symbol (symbols tree)))
		(error "bad symbol -- ENCODE-BRANCH" symbol)
		(encode-symbol-iter symbol tree '())))

(define (encode-symbol-iter symbol tree acc)
  (if (leaf? tree)
	  (reverse acc)
	  (let ((left (left-branch tree))
			(right (right-branch tree)))
		(if (symbol-of-branch? symbol left)
			(encode-symbol-iter symbol left (cons 0 acc))
			(encode-symbol-iter symbol right (cons 1 acc))))))

(define (symbol-of-branch? symbol tree)
  (if (leaf? tree)
	  (equal? symbol (symbol-leaf tree))
	  (element-of-set? symbol (symbols tree))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
		((< (weight x) (weight (car set))) (cons x set))
		(else (cons (car set)
					(adjoin-set x (cdr set))))))

(define (element-of-set? x set)
  (cond ((null? set) false)
		((equal? x (car set)) true)
		(else (element-of-set? x (cdr set)))))

(define (make-leaf-set pairs)
  (if (null? pairs)
	  '()
	  (let ((pair (car pairs)))
		(adjoin-set (make-leaf (car pair)   ; symbol
							   (cadr pair)) ; frequency
					(make-leaf-set (cdr pairs))))))

(define (make-code-tree left right)
  (list left
		right
		(append (symbols left) (symbols right))
		(+ (weight left) (weight right))))

; 2.69
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaves)
  (if (= (length leaves) 1)
	  (car leaves)
	  (let ((first (car leaves))
			(second (cadr leaves))
			(rest (cddr leaves)))
		(successive-merge
		 (adjoin-set (make-code-tree first second)
					 rest)))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
				  (make-code-tree
				   (make-leaf 'B 2)
				   (make-code-tree (make-leaf 'D 1)
								   (make-leaf 'C 1)))))

; test
(define pairs
  '((A 4) (B 2) (C 1) (D 1)))

(equal? (generate-huffman-tree pairs)
		sample-tree)
