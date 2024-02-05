(load "mk-vicare.scm")
(load "mk.scm")

;; From Episode 0006, cleaned up in Epi 0028
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
