(load "./ch03/streams.scm")
(load "./ch03/inf-streams.scm")

(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define (integrate-series s)
  (scale-stream (div-streams s integers) 1.0))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
