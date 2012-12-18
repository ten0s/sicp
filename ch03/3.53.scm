(load "./ch03/streams.scm")

(define s (cons-stream 1 (add-streams s s)))

; the stream above is equal to `double' stream. it produces
; 1, 2, 4, 8, 16, 32, ...

