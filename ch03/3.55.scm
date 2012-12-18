(load "./ch03/streams.scm")
(load "./ch03/inf-streams.scm")

(define partial-sums (cons-stream 1 (add-streams partial-sums (stream-cdr integers))))
