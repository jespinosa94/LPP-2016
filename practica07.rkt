;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit))

                          ;-----------------;
                          ;;;;Ejercicio 1;;;;
                          ;-----------------;
;;Definición de las funciones
(define (tostring-tree tree)
  #t)
(define tree '(a (b (c (d)) (e)) (f)))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1________________ \n")
(display "El resultado de concatenar los elementos del arbol (a (b (c (d)) (e)) (f)) es: ")
(display (tostring-tree tree))
;;Pruebas
(check-equal? (tostring-tree tree) "abcdef")