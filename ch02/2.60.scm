; This data structure is called a multiset or a bag.

; O(n) -- the same as element-of-set?
(define (element-of-bag? x bag)
  (cond ((null? bag) false)
		((equal? x (car bag)) true)
		(else (element-of-bag? x (cdr bag)))))

; O(1) -- we allow duplicates.
(define (adjoin-bag x bag)
	(cons x bag))

; O(n) -- removes first occurrence of x from list.
(define (remove x list)
  (cond ((null? list) '())
		((equal? x (car list)) (cdr list))
		(else (cons (car list)
					(remove x (cdr list))))))

; O(n^2) -- removes those items from list1 that exist in list2.
(define (difference list1 list2)
  (cond ((null? list1) '())
		((null? list2) list1)
		((element-of-bag? (car list1) list2)
		 (difference (cdr list1) (remove (car list1) list2)))
		(else (cons (car list1)
					(difference (cdr list1) list2)))))

; The intersection of sets S and T are those items which are
; elements of both S and T. If a given element appears more than once
; in S or T (or both), the intersection contains m copies of that element,
; where m is the smaller of the number of times the element appears in S or T.
; O(n^2)
(define (intersection-bag bag1 bag2)
  (cond ((null? bag1) '())
		((null? bag2) '())
		((element-of-bag? (car bag1) bag2)
		 (cons (car bag1)
			   (intersection-bag (cdr bag1) (remove (car bag1) bag2))))
		(else (intersection-bag (cdr bag1) bag2))))

; The union  of multisets S and T, is the multiset comprised of
; all the elements of S together with all the element of T.
; O(n) -- because of append.
(define (union-bag bag1 bag2)
  (append bag1 bag2))
