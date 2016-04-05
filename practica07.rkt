;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit)
        (rnrs mutable-pairs))
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
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1a________________ \n")
(display "El resultado de concatenar los elementos del arbol (a (b (c (d)) (e)) (f)) es: ")
(display (tostring-tree tree))
;;Pruebas
(check-equal? (tostring-tree tree) "abcdef")
(check-equal? (tostring-tree '(hola (que) (tal))) "holaquetal")
(check-equal? (tostring-tree '(arbol (que (esta) (en)) (orden))) "arbolqueestaenorden")

                          ;-----------------;
                          ;;;;Ejercicio 1b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (tostring-tree-fos tree)
  (string-append (symbol->string (dato-tree tree))
                 (fold-right string-append "" (map tostring-tree-fos (hijos-tree tree)))))
(define tree2 '(a (b (c (d)) (e)) (f)))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1b________________ \n")
(display "El resultado de concatenar los elementos del arbol (a (b (c (d)) (e)) (f)) es: ")
(display (tostring-tree-fos tree))
;;Pruebas
(check-equal? (tostring-tree-fos tree2) "abcdef")
(check-equal? (tostring-tree-fos '(hola (que) (tal))) "holaquetal")
(check-equal? (tostring-tree-fos '(arbol (que (esta) (en)) (orden))) "arbolqueestaenorden")

                          ;-----------------;
                          ;;;;Ejercicio 2a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (ordenado-tree? tree)
  (map 

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 2a________________ \n")
(display "El arbol (10(5)(7)) está ordenado? ")
(display (ordenado-tree? '(10(5)(7))))
;;Pruebas
(check-true (ordenado-tree? '(10(5)(7))))
(check-true (ordenado-tree? '(50 (10 (4) (6)(8))(25(15)))))
(check-false (ordenado-tree? '(10(8)(7))))
(check-false (ordenado-tree? '(6(5)(7))))
(check-false (ordenado-tree? '(50(10(4)(6)(11))(25)(15))))

                          ;-----------------;
                          ;;;;Ejercicio 4;;;;
                          ;-----------------;
;;Definición de las funciones
(define x (cons (cons (cons 'a 'cambio) 'e)
                (cons (cons 'c 'cambio) 'd)))
(set-cdr! (car (car x)) (car (cdr x)))
(set-cdr! (car (cdr x)) (cdr x))

(define y (cons (cons (cons 'a (cons 'cambio 'cambio)) 'cambio)
                (cons 'cambio 'd)))
(set-cdr! (car y) (cdr y))
(set-car! (cdr (car (car y))) (cdr y))
(set-cdr! (cdr (car (car y))) (cdr y))
(set-car! (cdr y) y)

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 4________________ \n")
(display x)
(display "\n")
(display y)
;;Pruebas
















