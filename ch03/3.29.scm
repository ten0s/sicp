;
; OR gate
; http://en.wikipedia.org/wiki/OR_gate
;
(define (or-gate a b output)
  (let ((c (make-wire))
		(d (make-wire))
		(e (make-wire))
		(f (make-wire))
		(g (make-wire)))
	(and-gate a a c)
	(and-gate b b d)
	(inverter c e)
	(inverter d f)
	(and-gate e f g)
	(inverter g output)
	'ok))
;
; Delay time is 3*and-gate-delay + 3*inverter-delay
;
