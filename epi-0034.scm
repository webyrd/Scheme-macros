(load "mk-vicare.scm")
(load "mk.scm")

;; Macros from Episode 0006
;; https://www.youtube.com/watch?v=0alYb4ZAHxE
;; 
;; Cleaned up in Epi 0028
;; https://github.com/webyrd/Scheme-macros/blob/main/epi-0006.scm
;;
;; This file expects to live in the top-level directory of:
;;
;; https://github.com/michaelballantyne/faster-miniKanren
;;
;; Tested in Chez Scheme.  Should work in any R6RS Scheme impl, and in
;; Racket, with a minimum of fuss.

(define-syntax define-relation
  (syntax-rules ()
    [(_ (r x ...) g g* ...)
     (define r
       (lambda (x ...)
         (fresh ()
           g g* ...)))]))

(define-syntax new-test
  (syntax-rules ()
    [(_ name test-expression expected-expression)
     (if (equal? test-expression expected-expression)
         'passed
         (error 'test
                (format "test ~s failed!\nExpression ~s\nhas value ~s\ninstead of expected value ~s\n"
                        name
                        'test-expression
                        test-expression
                        expected-expression)))]))

(define-syntax newer-test
  (syntax-rules ()
    [(_ name test-expression expected-expression)
     (let ((tv test-expression)
           (ev expected-expression)
           (te 'test-expression))
       (if (equal? tv ev)
           'passed
           (error 'test
                  (format "test ~s failed!\nExpression ~s\nhas value ~s\ninstead of expected value ~s\n"
                          name
                          te
                          tv
                          ev))))]))

(define *diverge-ticks-box* (box 1000))
(define (fast-test-mode) (set-box! *diverge-ticks-box* 1))
(define (careful-test-mode)
  (set-box! *diverge-ticks-box* (expt 10 9)))
(define (get-test-starting-fuel)
  (unbox *diverge-ticks-box*))

;; another approach: parameters



#;(define-syntax test-diverge
  (syntax-rules ()
    [(_ name test-expression)
     (test-diverge
      name
      (get-test-starting-fuel)
      test-expression)]
    [(_ name fuel test-expression)
     (let ((eng (make-engine (lambda () test-expression))))
       (eng
        fuel                 ; ticks of fuel
        (lambda (t v)        ; complete
          (error 'test-diverge
                 (format "Divergent test ~s failed!\nExpression ~s\n converged to value ~s\n(with ~s out of ~s ticks of fuel remaining)\ninstead of diverging\n"
                         name
                         'test-expression
                         v
                         t
                         fuel))) 
        (lambda (e) 'passed) ; expire
        ))]))

(define (test-diverge-helper name fuel test-thunk quoted-test-expression)
  (let ((eng (make-engine test-thunk)))
    (eng
     fuel                               ; ticks of fuel
     (lambda (t v)                      ; complete
       (error 'test-diverge
              (format "Divergent test ~s failed!\nExpression ~s\n converged to value ~s\n(with ~s out of ~s ticks of fuel remaining)\ninstead of diverging\n"
                      name
                      quoted-test-expression
                      v
                      t
                      fuel))) 
     (lambda (e) 'passed)               ; expire
     )))

(define-syntax test-diverge
  (syntax-rules ()
    [(_ name test-expression)
     (test-diverge name (get-test-starting-fuel) test-expression)]
    [(_ name fuel test-expression)
     (test-diverge-helper name
                          fuel
                          (lambda () test-expression)
                          'test-expression)]))



#;(define appendo
    (lambda (l s ls)
      (conde
        ((== '() l) (== s ls))
        ((fresh (a d res)
           (== (cons a d) l)
           (== (cons a res) ls)
           (appendo d s res))))))

#;(define-relation appendo (l s ls)
  (conde
    ((== '() l) (== s ls))
    ((fresh (a d res)
       (== (cons a d) l)
       (== (cons a res) ls)
       (appendo d s res)))))

(define-relation (appendo l s ls)
  (conde
    ((== '() l) (== s ls))
    ((fresh (a d res)
       (== (cons a d) l)
       (== (cons a res) ls)
       (appendo d s res)))))


(define square
  (lambda (n)
    (* n n)))
; <=>
(define (square n)
  (* n n))


(new-test "appendo-abcde"
  (run* (x y)
    (appendo x y '(a b c d e)))
  '((() (a b c d e))
    ((a) (b c d e))
    ((a b) (c d e))
    ((a b c) (d e))
    ((a b c d) (e))
    ((a b c d e) ())))

(newer-test "appendo-abcde"
  (run* (x y)
    (appendo x y '(a b c d e)))
  '((() (a b c d e))
    ((a) (b c d e))
    ((a b) (c d e))
    ((a b c) (d e))
    ((a b c d) (e))
    ((a b c d e) ())))

(test-diverge "omega"
  1000
  ((lambda (x) (x x)) (lambda (x) (x x))))

(test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

#;(test-diverge "finishes"
  1000
  (lambda (x) (x x)))
