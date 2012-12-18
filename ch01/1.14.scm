(define (count-change amount)
  (cc amount 5 0))

(define (cc amount kinds-of-coins depth)
  (trace amount kinds-of-coins depth)
  (cond ((= amount 0) 1)
		((or (< amount 0) (= kinds-of-coins 0)) 0)
		(else (+ (cc
				  amount
				  (- kinds-of-coins 1)
				  (1+ depth))
				 (cc
				  (- amount (first-denomination kinds-of-coins))
				  kinds-of-coins
				  (1+ depth))))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
		((= kinds-of-coins 2) 5)
		((= kinds-of-coins 3) 10)
		((= kinds-of-coins 4) 25)
		((= kinds-of-coins 5) 50)))

(define (trace amount kinds-of-coins depth)
  (display depth)
  (display " ")
  (display (indent depth '()))
  (display amount)
  (display " ")
  (display kinds-of-coins)
  (newline))

(define (indent depth acc)
  (if (= depth 0)
	   (list->string acc)
	   (indent (-1+ depth) (cons #\space acc))))

;  n |   T   |  S
;------------------
;  n   O(n^2)  O(n)
; -----------------
;  1     10     5
;  5     18     9
; 10     40    14
; 20    150    24
; 40    835    44
; 50   1570    54
; 60   2750    64
