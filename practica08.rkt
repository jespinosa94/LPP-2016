
;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit)
        (rnrs mutable-pairs))
;(import (rnrs base)
;        (rnrs io simple)
;        (schemeunit))

                          ;-----------------;
                          ;;;;Ejercicio 1;;;;
                          ;-----------------;
;;Definición de las funciones
(define (ultima-pareja olist)
  (if (null? (cdr olist))
      olist
      (ultima-pareja (cdr olist))))

(define (crear-lista-circular! clista)
  (set-cdr! (ultima-pareja clista) (cdr clista)))

(define clista '(clista 1 4 8 7))
(define lista1 '(lista1))
(define lista2 '(lista2 1))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1________________ \n")
(crear-lista-circular! clista)
(crear-lista-circular! lista1)
(crear-lista-circular! lista2)
(display clista)
(display "\n")
(display lista1)
(display "\n")
(display lista2)

                          ;-----------------;
                          ;;;;Ejercicio 2;;;;
                          ;-----------------;
;;Definición de las funciones
(define (intercambia-elementos! lista)
  (if (null? (cddr lista))
      lista
      (
          (intercambia-elementos! (cddr lista))
        (intercambia-elem lista))))

(define (intercambia-elem lista-aux)
   (let ((aux (cdr lista)))
    (set-cdr! lista (cddr lista))
    (if (null? (cddr lista))
        (set-cdr! aux '())
        (set-cdr! aux (cddr lista)))
    (set-cdr! (cdr lista) aux)))
(define listap '(listap 1 2))
(define lista '(clist 1 2 3 4))
;(define clista '(clista 1 4 8 7))
;(define lista2 '(lista2))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 2________________ \n")
(display (intercambia-elementos! listap))
(display (intercambia-elementos! lista))
;(display (intercambia-elementos! clista))
;(display (intercambia-elementos! lista2))

;;Pruebas
