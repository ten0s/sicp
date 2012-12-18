(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

; b
(define (mobile-weight mobile)
  (+ (branch-weight (left-branch mobile))
	 (branch-weight (right-branch mobile))))

(define (mobile? mobile)
  (list? mobile))

(define (branch-weight branch)
  (let ((mobile-or-weight (branch-structure branch)))
	(if (mobile? mobile-or-weight)
		(+ (branch-weight (left-branch mobile-or-weight))
		   (branch-weight (right-branch mobile-or-weight)))
		mobile-or-weight)))

; c
(define (mobile-balanced? mobile)
  (if (mobile? mobile)
	  (let ((left (left-branch mobile))
			(right (right-branch mobile)))
		(and (= (branch-momentum left)
				(branch-momentum right))
			 (mobile-balanced? (branch-structure left))
			 (mobile-balanced? (branch-structure right))))
	  true))

(define (branch-momentum branch)
  (* (branch-length branch)
	 (branch-weight branch)))

; non-balanced
(define mobile1
  (make-mobile
   (make-branch 4 1)
   (make-branch 3 (make-mobile
				   (make-branch 3 2)
				   (make-branch 2 3)))))

; non-balanced
(define mobile2
  (make-mobile
   (make-branch 2 4)
   (make-branch 1 (make-mobile
				   (make-branch 3 4)
				   (make-branch 2 4)))))

; balanced
(define mobile3
  (make-mobile
   (make-branch 2 4)
   (make-branch 1 (make-mobile
				   (make-branch 2 4)
				   (make-branch 2 4)))))

; d
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

; we need to change only three functions below
((define (right-branch mobile)
  (cdr mobile))

(define (branch-structure branch)
  (cdr branch))

(define (mobile? mobile)
  (pair? mobile))
