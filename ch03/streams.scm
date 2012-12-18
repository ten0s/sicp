(define (stream-ref s n)
  (if (= n 0)
	  (stream-car s)
	  (stream-ref (stream-cdr s) (- n 1))))

;(define (stream-map proc s)
;  (if (stream-null? s)
;	  the-empty-stream
;	  (cons-stream (proc (stream-car s))
;				   (stream-map proc (stream-cdr s)))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
	  the-empty-stream
	  (cons-stream
	   (apply proc (map stream-car argstreams))
	   (apply stream-map
			  (cons proc (map stream-cdr argstreams))))))


(define (stream-filter pred s)
  (cond ((stream-null? s) the-empty-stream)
		((pred (stream-car s))
		 (cons-stream (stream-car s)
					  (stream-filter pred
									 (stream-cdr s))))
		(else (stream-filter pred (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
	  the-empty-stream
	  (begin (proc (stream-car s))
			 (stream-for-each proc (stream-cdr s)))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (stream-enumerate-interval low high)
  (if (> low high)
	  the-empty-stream
	  (cons-stream low
				   (stream-enumerate-interval (+ low 1) high))))

;
; Tests
;
(load "test-manager/load.scm")

(in-test-group
 streams-tests

 (define-test (stream-ref-test)
   (assert-true true))

 (define-test (stream-map-test)
   (define s (stream-map 1+ (stream-enumerate-interval 1 3)))
   (assert-equal 2 (stream-car s))
   (assert-equal 3 (stream-car (stream-cdr s)))
   (assert-equal 4 (stream-car (stream-cdr (stream-cdr s))))
   (assert-equal the-empty-stream (stream-cdr (stream-cdr (stream-cdr s)))))
)
(run-test '(streams-tests))
