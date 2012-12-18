(load "./ch03/streams.scm")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
	  the-empty-stream
	  (cons-stream
	   (apply proc (map stream-car argstreams))
	   (apply stream-map
			  (cons proc (map stream-cdr argstreams))))))

;
; Tests
;
(in-test-group
 stream-map-tests

 (define-test (test1)
   (define s (stream-map +
						 (stream-enumerate-interval 1 3)
						 (stream-enumerate-interval 2 4)))
   (assert-equal 3 (stream-car s))
   (assert-equal 5 (stream-car (stream-cdr s)))
   (assert-equal 7 (stream-car (stream-cdr (stream-cdr s))))
   (assert-equal the-empty-stream (stream-cdr (stream-cdr (stream-cdr s)))))

 (define-test (test2)
   (define s (stream-map 1+ (stream-enumerate-interval 1 3)))
   (assert-equal 2 (stream-car s))
   (assert-equal 3 (stream-car (stream-cdr s)))
   (assert-equal 4 (stream-car (stream-cdr (stream-cdr s))))
   (assert-equal the-empty-stream (stream-cdr (stream-cdr (stream-cdr s)))))
)
(run-test '(stream-map-tests))
