Chez Scheme Version 9.6.4
Copyright 1984-2023 Cisco Systems, Inc.

> (load "mk-vicare.scm")
> (load "mk.scm")
> ==
#<procedure == at mk.scm:16374>
> conde

Exception: invalid syntax conde
Type (debug) to enter the debugger.
> fresh

Exception: invalid syntax fresh
Type (debug) to enter the debugger.
> run

Exception: invalid syntax run
Type (debug) to enter the debugger.
> run*

Exception: invalid syntax run*
Type (debug) to enter the debugger.
> ;; == fresh conde   ;; logical operators
  ;; run   run*       ;; interface operators

  C-c C-c
  C-c C-c
> (run 1 (q)
    (== q 5))
(5)
> (run 1 (q)
    (conde
      ((== q 5))
      ((== q 6))))
(5)
> (run 2 (q)
    (conde
      ((== q 5))
      ((== q 6))))
(5 6)
> (run 3 (q)
    (conde
      ((== q 5))
      ((== q 6))))
(5 6)
> (run 100 (q)
    (conde
      ((== q 5))
      ((== q 6))))
(5 6)
> (run* (q)
    (conde
      ((== q 5))
      ((== q 6))))
(5 6)
> (define appendo
    (lambda (l s ls)
      (conde
        ((== '() l) (== s ls))
        ((fresh (a d res)
           (== (cons a d) l)
           (== (cons a res) ls)
           (appendo d s res))))))
> (run* (q) (appendo '(a b c) '(d e) q))
((a b c d e))
> (run* (q)
    (appendo '(a b c) q '(a b c d e)))
((d e))
> (run* (x y)
    (appendo x y '(a b c d e)))
((() (a b c d e))
 ((a) (b c d e))
 ((a b) (c d e))
 ((a b c) (d e))
 ((a b c d) (e))
 ((a b c d e) ()))
> (expand '(run* (x y)
             (appendo x y '(a b c d e))))
(take
  #f
  (lambda ()
    (let ([#{st jacqhpqwfkgwnvmd26du4j3bs-0} empty-state])
      (lambda ()
        (let ([#{scope jacqhpqwfkgwnvmd26du4j3bs-1} (subst-scope
                                                      (state-S
                                                        #{st jacqhpqwfkgwnvmd26du4j3bs-0}))])
          (let ([#{x jacqhpqwfkgwnvmd26du4j3bs-2} (var #{scope jacqhpqwfkgwnvmd26du4j3bs-1})])
            (bind
              (let ([#{st jacqhpqwfkgwnvmd26du4j3bs-3} #{st jacqhpqwfkgwnvmd26du4j3bs-0}])
                (lambda ()
                  (let ([#{scope jacqhpqwfkgwnvmd26du4j3bs-4} (subst-scope
                                                                (state-S
                                                                  #{st jacqhpqwfkgwnvmd26du4j3bs-3}))])
                    (let ([#{x jacqhpqwfkgwnvmd26du4j3bs-5} (var #{scope jacqhpqwfkgwnvmd26du4j3bs-4})]
                          [#{y jacqhpqwfkgwnvmd26du4j3bs-6} (var #{scope jacqhpqwfkgwnvmd26du4j3bs-4})])
                      (bind
                        ((appendo
                           #{x jacqhpqwfkgwnvmd26du4j3bs-5}
                           #{y jacqhpqwfkgwnvmd26du4j3bs-6}
                           '(a b c d e))
                          #{st jacqhpqwfkgwnvmd26du4j3bs-3})
                        (== (#2%list
                              #{x jacqhpqwfkgwnvmd26du4j3bs-5}
                              #{y jacqhpqwfkgwnvmd26du4j3bs-6})
                            #{x jacqhpqwfkgwnvmd26du4j3bs-2}))))))
              (lambda (#{st jacqhpqwfkgwnvmd26du4j3bs-7})
                (let ([#{st jacqhpqwfkgwnvmd26du4j3bs-8} (state-with-scope
                                                           #{st jacqhpqwfkgwnvmd26du4j3bs-7}
                                                           nonlocal-scope)])
                  (let ([#{z jacqhpqwfkgwnvmd26du4j3bs-9} ((reify
                                                             #{x jacqhpqwfkgwnvmd26du4j3bs-2})
                                                            #{st jacqhpqwfkgwnvmd26du4j3bs-8})])
                    (#2%cons
                      #{z jacqhpqwfkgwnvmd26du4j3bs-9}
                      (lambda () (lambda () #f)))))))))))))
> (print-gensym #f)
> (expand '(run* (x y)
             (appendo x y '(a b c d e))))
(take
  #f
  (lambda ()
    (let ([st empty-state])
      (lambda ()
        (let ([scope (subst-scope (state-S st))])
          (let ([x (var scope)])
            (bind
              (let ([st st])
                (lambda ()
                  (let ([scope (subst-scope (state-S st))])
                    (let ([x (var scope)] [y (var scope)])
                      (bind
                        ((appendo x y '(a b c d e)) st)
                        (== (#2%list x y) x))))))
              (lambda (st)
                (let ([st (state-with-scope st nonlocal-scope)])
                  (let ([z ((reify x) st)])
                    (#2%cons z (lambda () (lambda () #f)))))))))))))
> (expand '(run 2 (x y)
             (appendo x y '(a b c d e))))
(take
  2
  (lambda ()
    (let ([st empty-state])
      (lambda ()
        (let ([scope (subst-scope (state-S st))])
          (let ([x (var scope)])
            (bind
              (let ([st st])
                (lambda ()
                  (let ([scope (subst-scope (state-S st))])
                    (let ([x (var scope)] [y (var scope)])
                      (bind
                        ((appendo x y '(a b c d e)) st)
                        (== (#2%list x y) x))))))
              (lambda (st)
                (let ([st (state-with-scope st nonlocal-scope)])
                  (let ([z ((reify x) st)])
                    (#2%cons z (lambda () (lambda () #f)))))))))))))
> (run 2 (x y)
    (appendo x y '(a b c d e)))
((() (a b c d e)) ((a) (b c d e)))
> (run 1 (x y)
    (appendo x y '(a b c d e)))
((() (a b c d e)))
> (run 6 (x y)
    (appendo x y '(a b c d e)))
((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e))
  ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))
> (run 100 (x y)
    (appendo x y '(a b c d e)))
((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e))
  ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))
> (run* (x y)
    (appendo x y '(a b c d e)))
((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e))
  ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))
> (test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d e)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ())))

Exception: variable test is not bound
Type (debug) to enter the debugger.
> (define test
    (lambda (name test-value expected-value)
      (if (equal? test-value expected-value)
          'passed
          (error 'test
                 (format "test ~s failed!  Got value ~s instead of expected value ~s\n"
                         name
                         test-value
                         expected-value)))))
> (test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d e)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ())))
passed
> (test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ())))

Exception in test: test "appendo-abcde" failed!  Got value ((() (a b c d)) ((a) (b c d)) ((a b) (c d)) ((a b c) (d)) ((a b c d) ())) instead of expected value ((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e)) ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))

Type (debug) to enter the debugger.
> (define test
    (lambda (name test-value expected-value)
      (if (equal? test-value expected-value)
          'passed
          (error 'test
                 (format "test ~s failed!  Got value ~s instead of expected value ~s\n"
                         name
                         test-value
                         expected-value)))))
> (define-syntax new-test
    (syntax-rules ()
      [(_ name test-expression expected-expression)
       (if (equal? test-expression expected-expression)
           'passed
           (error 'test
                  (format "test ~s failed!  Got value ~s instead of expected value ~s\n"
                          name
                          test-expression
                          expected-expression)))]))
> (test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ())))

Exception in test: test "appendo-abcde" failed!  Got value ((() (a b c d)) ((a) (b c d)) ((a b) (c d)) ((a b c) (d)) ((a b c d) ())) instead of expected value ((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e)) ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))

Type (debug) to enter the debugger.
> (new-test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ())))

Exception in test: test "appendo-abcde" failed!  Got value ((() (a b c d)) ((a) (b c d)) ((a b) (c d)) ((a b c) (d)) ((a b c d) ())) instead of expected value ((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e)) ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))

Type (debug) to enter the debugger.
> (expand '(new-test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ()))))
(if (#2%equal?
      (take
        #f
        (lambda ()
          (let ([st empty-state])
            (lambda ()
              (let ([scope (subst-scope (state-S st))])
                (let ([x (var scope)])
                  (bind
                    (let ([st st])
                      (lambda ()
                        (let ([scope (subst-scope (state-S st))])
                          (let ([x (var scope)] [y (var scope)])
                            (bind
                              ((appendo x y '(a b c d)) st)
                              (== (#2%list x y) x))))))
                    (lambda (st)
                      (let ([st (state-with-scope st nonlocal-scope)])
                        (let ([z ((reify x) st)])
                          (#2%cons z (lambda () (lambda () #f)))))))))))))
      '((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e))
         ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ())))
    'passed
    (#2%error
      'test
      (#2%format
        "test ~s failed!  Got value ~s instead of expected value ~s\n"
        "appendo-abcde"
        (take
          #f
          (lambda ()
            (let ([st empty-state])
              (lambda ()
                (let ([scope (subst-scope (state-S st))])
                  (let ([x (var scope)])
                    (bind
                      (let ([st st])
                        (lambda ()
                          (let ([scope (subst-scope (state-S st))])
                            (let ([x (var scope)] [y (var scope)])
                              (bind
                                ((appendo x y '(a b c d)) st)
                                (== (#2%list x y) x))))))
                      (lambda (st)
                        (let ([st (state-with-scope st nonlocal-scope)])
                          (let ([z ((reify x) st)])
                            (#2%cons
                              z
                              (lambda () (lambda () #f)))))))))))))
        '((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e))
           ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ())))))
> (define-syntax new-test
    (syntax-rules ()
      [(_ name test-expression expected-expression)
       (if (equal? test-expression expected-expression)
           'passed
           (error 'test
                  (format "test ~s failed!  Got value ~s instead of expected value ~s\n"
                          name
                          'test-expression
                          test-expression
                          expected-expression)))]))
> (run* (x y)
    (appendo x y '(a b c d)))
((() (a b c d))
  ((a) (b c d))
  ((a b) (c d))
  ((a b c) (d))
  ((a b c d) ()))
> '(run* (x y)
     (appendo x y '(a b c d)))
(run* (x y) (appendo x y '(a b c d)))
> (car '(run* (x y)
     (appendo x y '(a b c d))))
run*
> (define-syntax new-test
    (syntax-rules ()
      [(_ name test-expression expected-expression)
       (if (equal? test-expression expected-expression)
           'passed
           (error 'test
                  (format "test ~s failed!  Expression ~s has value ~s instead of expected value ~s\n"
                          name
                          'test-expression
                          test-expression
                          expected-expression)))]))
> (new-test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ())))

Exception in test: test "appendo-abcde" failed!  Expression (run* (x y) (appendo x y (quote (a b c d)))) has value ((() (a b c d)) ((a) (b c d)) ((a b) (c d)) ((a b c) (d)) ((a b c d) ())) instead of expected value ((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e)) ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))

Type (debug) to enter the debugger.
> (define-syntax new-test
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
> (new-test "appendo-abcde"
    (run* (x y)
      (appendo x y '(a b c d)))
    '((() (a b c d e))
      ((a) (b c d e))
      ((a b) (c d e))
      ((a b c) (d e))
      ((a b c d) (e))
      ((a b c d e) ())))

Exception in test: test "appendo-abcde" failed!
Expression (run* (x y) (appendo x y (quote (a b c d))))
has value ((() (a b c d)) ((a) (b c d)) ((a b) (c d)) ((a b c) (d)) ((a b c d) ()))
instead of expected value ((() (a b c d e)) ((a) (b c d e)) ((a b) (c d e)) ((a b c) (d e)) ((a b c d) (e)) ((a b c d e) ()))

Type (debug) to enter the debugger.
> (define x (+ 3 4))
> x
7
> (lambda (y) (* y y))
#<procedure>
> ((lambda (y) (* y y)) (+ 1 2))
9
> (define square (lambda (y) (* y y)))
> (square (+ 1 2))
9
> (lambda (y)
    137
    (* y y))
#<procedure>
> (define square
    (lambda (y)
      137
      (* y y)))
> (square (+ 1 2))
9
> (define square
    (lambda (y)
      (begin
        (printf "hello!\n\n")
        (* y y))))
> (square (+ 1 2))
hello!

9
> (define square
    (lambda (y)
      (printf "hello!\n\n")
      (* y y)))
> (square (+ 1 2))
hello!

9
> (define my-simple-relation
    (lambda (x y z)
      (== x (list y z))))
> (run* (q) (my-simple-relation 3 4 q))
()
> (run* (q) (my-simple-relation q 3 4))
((3 4))
> (run* (q) (== 3 (list 4 q)))
()
> (run* (q) (my-simple-relation q 3 4))
((3 4))
> (define my-simple-relation
    (lambda (x y z)
      (== x (list y z))
      (== z 5)))
> (run* (q) (my-simple-relation q 3 4))
()
> (run* (a b) (my-simple-relation a 3 b))
((_.0 5))
> (define my-simple-relation
    (lambda (x y z)
      (begin
        (== x (list y z)) ;; discarded
        (== z 5))))
> (define my-simple-relation
    (lambda (x y z)
      (fresh ()
        (== x (list y z))
        (== z 5))))
> (run* (a b) (my-simple-relation a 3 b))
(((3 5) 5))
> (define my-simple-relation
    (lambda (x y z)
      (fresh ()
        (== x (list y z))
        (== z 5))))
> (define my-simple-relation
    (lambda (x y z)
      (== x (list y z))
      (== z 5)))
> (define define-relation
    (syntax-rules ()
      [(_ r (x ...) g g* ...)
       (define r
         (lambda (x ....)
           (fresh ()
             g)))]))

Exception: missing ellipsis for x in syntax form (syntax (define r (lambda (...) (...))))
Type (debug) to enter the debugger.
> (define define-relation
    (syntax-rules ()
      [(_ r (x ...) g g* ...)
       (define r
         (lambda (x ....)
           (fresh ()
             g g* ...)))]))

Exception: missing ellipsis for x in syntax form (syntax (define r (lambda (...) (...))))
Type (debug) to enter the debugger.
> (define-syntax define-relation
    (syntax-rules ()
      [(_ r (x ...) g g* ...)
       (define r
         (lambda (x ....)
           (fresh ()
             g g* ...)))]))

Exception: missing ellipsis for x in syntax form (syntax (define r (lambda (...) (...))))
Type (debug) to enter the debugger.
> (define-syntax define-relation
    (syntax-rules ()
      [(_ r (x ...) g g* ...)
       (define r
         (lambda (x ...)
           (fresh ()
             g g* ...)))]))
> (define-relation my-simple-relation (x y z)
    (== x (list y z))
    (== z 5))
> (run* (a b) (my-simple-relation a 3 b))
(((3 5) 5))
> (expand '(define-relation my-simple-relation (x y z)
    (== x (list y z))
    (== z 5)))
(begin
  (set! my-simple-relation
    (lambda (x y z)
      (lambda (st)
        (lambda ()
          (let ([scope (subst-scope (state-S st))])
            (bind ((== x (#2%list y z)) st) (== z 5)))))))
  (#2%void))
> (define-syntax define-relation
    (syntax-rules ()
      [(_ r (x ...) g g* ...)
       (define r
         (lambda (x ...)
           (fresh ()
             g g* ...)))]))
> (define-relation my-simple-relation (x y z)
    (== x (list y z))
    (== z 5))
