(load "./ch03/streams.scm")

(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)

;initial initial result
;stream  sum     sum
;
;1       0       1
;2       1       3
;3       3       6
;4       6       10
;5       10      15
;6       15      21
;7       21      28
;8       28      36
;9       36      45
;10      45      55
;11      55      66
;12      66      78
;13      78      91
;14      91      105
;15      105     120
;16      120     136
;17      136     153
;18      153     171
;19      171     190
;20      190     210

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; sequence == (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210)
; seq => (1 . promise), sum => 1
(define y (stream-filter even? seq))
; sequence == (3 10 28 36 66 78 120 136 190 210)
; y => (6 . promise), sum => 6
(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
; sequence == (10 15 45 55 105 120 190 120)
; z => (10 . promise), sum => 10
(stream-ref y 7)
; => 136, sum => 136
(display-stream z)
; sum => 210

; The responses would differ if we had implemented the delay without optimization,
; because this way the accum procedure would be called each time the stream-cdr is
; evaluated and the sum would be increased every time.
