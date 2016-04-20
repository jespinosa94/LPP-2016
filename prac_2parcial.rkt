#lang r6rs
(import (rnrs)
        (schemeunit)
        (mutable-pairs))
;;Práctica 5 ejercicio 4a
(define (suma-iter lista)
  (suma-iter-aux lista 0))

(define (suma-iter-aux lista resultado)
  (if (null? lista)
      resultado
      (suma-iter-aux (cdr lista) (+ resultado (car lista)))))
(display "\nEjercicio 4a: ")
(display (suma-iter '(1 2 3 4 5)))

;;Práctica 5 ejercicio 4b
(define (cuadrado-lista-iter lista)
  (cuadrado-lista-iter-aux lista '()))

(define (cuadrado-lista-iter-aux lista resultado)
  (if (null? lista)
      resultado
      (cuadrado-lista-iter-aux (cdr lista) (append resultado
                                           (list (* (car lista)
                                                    (car lista)))))))
(display "\nEjercicio 4b: ")
(display (cuadrado-lista-iter '(2 3 4 5)))

;;Práctica 5 ejercicio 5
(define (asteriscos-iter n)
  (asteriscos-iter-aux n '()))
(define (asteriscos-iter-aux n resultado)
  (if (= n 0)
      resultado
      (asteriscos-iter-aux (- n 1) (cons (pinta n) resultado))))
(define (pinta n)
  (pinta-aux n '()))
(define (pinta-aux n resultado)
  (if (= n 0)
      resultado
      (pinta-aux (- n 1) (cons '* resultado))))

(display "\nEjercicio 5: ")
(display (asteriscos-iter 5))



;;;;;;;;;;;;;;;;arboles;;;;;;;;;;;;;;;
(define (make-tree dato lista-arboles)  
   (cons dato lista-arboles))

(define (make-hoja-tree dato) 
    (make-tree dato '()))
(define (dato-tree arbol) 
    (car arbol))

(define (hijos-tree arbol) 
    (cdr arbol))

(define (hoja-tree? arbol) 
   (null? (hijos-tree arbol)))
(define (cuadrado n)
  (* n n))