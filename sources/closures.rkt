#lang racket

(define (fct x) 
  (local [(define a 5)] 
    (lambda () (+ x a))))

(define toto (fct 5))
((fct 10))
(toto)
((fct 30))