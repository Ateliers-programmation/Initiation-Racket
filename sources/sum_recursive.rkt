#lang racket

(define (somme x)
  (+ x (if (not(= x 0))
           (somme (- x 1))
           0)))
