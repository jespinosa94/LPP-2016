;;-------------------------
;; Solución práctica 3
;--------------------------

#lang r6rs
(import (rnrs base)
        (rnrs io simple)
        (schemeunit))


;------------------------------------
; Ejercicio 1
;------------------------------------
(display "Ejercicio 1\n")
; a)
(define p1 (list (cons 1 2) 3))
(define p2 (cons (list 'a 'b)
                 '()))
(define p3 (cons 4
                 (cons p1
                       (cons p2
                             5))))




; b)
(display "p1 y p2 son listas porque contienen parejas cuyas partes derechas
tienen a su vez otras listas, incluyendo la última pareja que contiene
una lista vacía. p1 tiene 2 elementos y p2 tiene 1.
p3 no es una lista porque la parte derecha de su última pareja es
el símbolo 5 y no es una lista vacía.\n")

; c)
(display (cadr (cadr p3))) ; => 3
(newline)
(display (cdddr p3)) ; => 5
(newline)


;------------------------------------
; Ejercicio 2
;------------------------------------
; a)
(define (intercambia-elem pareja)
  (cons (cdr pareja)
        (car pareja)))

;; Demostración
(display "\nEjercicio 2.a\n")
(display "(intercambia-elem '(10 . 5)) : ")
(display (intercambia-elem '(10 . 5)))
(newline)


;; Pruebas
(check-equal? (intercambia-elem '(10 . 5)) '(5 . 10))
(check-equal? (intercambia-elem '(1 . 2)) '(2 . 1))
(check-equal? (intercambia-elem '((1 . 2) . (3 . 4))) '((3 . 4) . (1 . 2)))



; b)
(define (suma-izq n pareja)
  (cons (+ n (car pareja))
        (cdr pareja)))

(define (suma-der n pareja)
  (cons (car pareja)
        (+ n (cdr pareja))))


;; Demostración
(display "\nEjercicio 2.b\n")
(display "(suma-izq 5 '(10 . 20)) : ")
(display (suma-izq 5 (cons 10 20)))
(newline)
(display "(suma-der 6 '(10 . 20)) : ")
(display (suma-der 6 (cons 10 20)))
(newline)

;; Pruebas
(check-equal? (suma-izq 5 '(10 . 20)) '(15 . 20))
(check-equal? (suma-der 6 '(10 . 20)) '(10 . 26))
(check-equal? (suma-izq -3 '(0 . 20)) '(-3 . 20))
(check-equal? (suma-der 0 '(10 . 20)) '(10 . 20))


; c)
(define (suma-impares-pares lista-num)
  (if (null? lista-num)
      (cons 0 0)
      (if (odd? (car lista-num))
          (suma-izq (car lista-num)
                    (suma-impares-pares (cdr  lista-num)))
          (suma-der (car lista-num)
                    (suma-impares-pares (cdr  lista-num))))))


;; Demostración
(display "\nEjercicio 2.c\n")
(display "(suma-impares-pares '(3 2 1 4 8 7 6 5))) : ")
(display (suma-impares-pares '(3 2 1 4 8 7 6 5)))
(newline)

;; Pruebas
(check-equal? (suma-impares-pares '(3 2 1 4 8 7 6 5)) '(16 . 20))
(check-equal? (suma-impares-pares '(3 1 5))  '(9 . 0))
(check-equal? (suma-impares-pares '(2))  '(0 . 2))
(check-equal? (suma-impares-pares '(2 4 6))  '(0 . 12))




;------------------------------------
; Ejercicio 3
;------------------------------------
(define (es-multiplo? x y)
  (= (mod x y) 0))

(define (multiplo-de n lista-num)
  (if (null? lista-num)
      '()
      (cons (es-multiplo? (car lista-num) n)
            (multiplo-de n  (cdr lista-num)))))

;; Demostración
(display "\nEjercicio 3\n")
(display "(multiplo-de 10 '(100 23 10 300  48 7))  : ")
(display (multiplo-de 10 '(100 23 10 300  48 7)))
(newline)

;; Pruebas
(check-equal? (multiplo-de 10 '(100 23 10 300  48 7)) '(#t #f #t #t #f #f))
(check-equal? (multiplo-de 2 '(3 7 9)) '(#f #f #f))
(check-equal? (multiplo-de 2 '(2 8 6)) '(#t #t #t))



;------------------------------------
; Ejercicio 4
;------------------------------------
; a)
(define (filtra-cadenas lista-cadenas lista-num)
  (cond ((null? lista-cadenas)
         '())
        ((= (string-length  (symbol->string (car lista-cadenas))) (car lista-num))
         (cons (cons (car lista-cadenas)
                     (car lista-num))
               (filtra-cadenas (cdr lista-cadenas) (cdr lista-num))))
        (else
         (filtra-cadenas (cdr lista-cadenas) (cdr lista-num)))))

;; Demostración
(display "\nEjercicio 4.a\n")
(display "(filtra-cadenas '(este es un ejercicio de examen) '(2 1 2 9 1 6))  : ")
(display (filtra-cadenas '(este es un ejercicio de examen) '(2 1 2 9 1 6)))
(newline)

;; Pruebas
(check-equal? (filtra-cadenas '(este es un ejercicio de examen) '(2 1 2 9 1 6)) '((un . 2) (ejercicio . 9) (examen . 6)))
(check-equal? (filtra-cadenas '( este es un ejercicio de examen) '(2 1 3 4 1 5)) '())
(check-equal? (filtra-cadenas '(ejercicio) '(9)) '((ejercicio . 9)))


; b)
(define (expande-pareja pareja)
  (if (= (cdr pareja) 0)
      '()
      (cons (car pareja)
            (expande-pareja (cons (car pareja)
                                  (- (cdr pareja) 1))))))

(define (expande lista-parejas)
  (if (null?  lista-parejas)
      '()
      (append (expande-pareja (car lista-parejas))
              (expande (cdr lista-parejas)))))


;; Demostración
(display "\nEjercicio 4.b\n")
(display "(expande (list (cons #t 3) (cons \"LPP\" 2) (cons 'b 4)))  : ")
(display (expande (list (cons #t 3) (cons "LPP" 2) (cons 'b 4))))
(newline)

;; Pruebas
(check-equal? (expande-pareja (cons 'a 6)) '(a a a a a a))
(check-equal? (expande-pareja (cons 'a 0)) '())
(check-equal? (expande (list (cons #t 3) (cons "LPP" 2) (cons 'b 4))) '(#t #t #t "LPP" "LPP" b b b b))
(check-equal? (expande (list)) '())
(check-equal? (expande (list (cons 4 3))) '(4 4 4))



;------------------------------------
; Ejercicio 5
;------------------------------------
(define (suma-parejas-impar-par lista-parejas)
  (cond ((null? lista-parejas)
         (cons 0 0))
        ((and (odd? (caar lista-parejas)) (even?  (cdar lista-parejas)))
         (suma-izq (caar lista-parejas)
                   (suma-der (cdar lista-parejas)
                             (suma-parejas-impar-par (cdr lista-parejas)))))
        ((odd? (caar lista-parejas))
         (suma-izq (caar lista-parejas)
                   (suma-parejas-impar-par (cdr lista-parejas))))
        ((even? (cdar lista-parejas))
         (suma-der (cdar lista-parejas)
                   (suma-parejas-impar-par (cdr lista-parejas))))
        (else
         (suma-parejas-impar-par (cdr lista-parejas)))))


;; Demostración
(display "\nEjercicio 5\n")
(display "(suma-parejas-impar-par '((3 . 2) (6 . 5) (7 . 4)))  : ")
(display (suma-parejas-impar-par '((3 . 2) (6 . 5) (7 . 4))))
(newline)

;; Pruebas
(check-equal? (suma-parejas-impar-par '((3 . 2) (6 . 5) (7 . 4))) '(10 . 6))
(check-equal? (suma-parejas-impar-par '((1 . 5) (4 . 9) (8 . 3))) '(1 . 0))
(check-equal? (suma-parejas-impar-par '((2 . 1))) '(0 . 0))
(check-equal? (suma-parejas-impar-par '((2 . 1) (4 . 6))) '(0 . 6))
