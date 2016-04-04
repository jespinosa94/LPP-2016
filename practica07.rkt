;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit))
(define (dato-tree arbol) 
    (car arbol))

(define (hijos-tree arbol) 
    (cdr arbol))

(define (hoja-tree? arbol) 
   (null? (hijos-tree arbol)))
                          ;-----------------;
                          ;;;;Ejercicio 1a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (tostring-tree tree)
  (string-append (symbol->string (dato-tree tree))
                 (tostring-bosque (hijos-tree tree))))
(define (tostring-bosque bosque)
  (if (null? bosque)
      ""
      (string-append (tostring-tree (car bosque)) (tostring-bosque (cdr bosque)))))
(define tree '(a (b (c (d)) (e)) (f)))
(define tree2 '(hola (que) tal (((estas)))))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1a________________ \n")
(display "El resultado de concatenar los elementos del arbol (a (b (c (d)) (e)) (f)) es: ")
(display (tostring-tree tree))
;;Pruebas
(check-equal? (tostring-tree tree) "abcdef")
(check-equal? (tostring-tree '(hola (que) (tal))) "holaquetal")
(check-equal? (tostring-tree '(arbol (que (esta) (en)) (orden))) "arbolqueestaenorden")