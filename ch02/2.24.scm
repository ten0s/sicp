(list 1 (list 2 (list 3 4)))

; printed by the interpreter
; (1 (2 (3 4)))

; box-and-pointer structure
;
;  --->[*][*]
;       |  |
;       v  +--+
;      [1]	  |
;             v
;            [*][*]
;             |  |
;             v  +--+
;            [2]    |
;                   v
;                  [*][*]-->[*][/]
;                   |        |
;                   v        v
;                  [3]      [4]

; tree structure
; (1 (2 (3 4)))
;      /\
;     /  \
;    1   /\
;       /  \
;      2   /\
;         /  \
;        3   4
