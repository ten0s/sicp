(define (fringe list)
  (fringe-helper list '()))

(define (fringe-helper lst acc)
  (cond ((null? lst) acc)
		((not (pair? lst)) (append acc (list lst)))
		(else (fringe-helper (cdr lst) (fringe-helper (car lst) acc)))))
