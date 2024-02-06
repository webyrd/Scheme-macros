Chez Scheme Version 9.6.4
Copyright 1984-2023 Cisco Systems, Inc.

> (load "epi-0034.scm")

Exception in test-diverge: Divergent test "finishes" failed!
Expression (lambda (x) (x x))
 converged to value #<procedure at epi-0034.scm:3339>
(with 1000 ticks out of 1000 fuel remaining), instead of diverging

Type (debug) to enter the debugger.
> (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero)))
  C-c C-c
break> r
> (test-diverge "nevero"
  1000
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))
passed
> (test-diverge "nevero"
  100000
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> (test-diverge "nevero"
  10000000
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> (test-diverge "nevero"
  100000000
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> (test-diverge "nevero"
  1000000000
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> (load "epi-0034.scm")
> *diverge-ticks-box*
#&1000
> (unbox *diverge-ticks-box*)
1000
> (set-box! *diverge-ticks-box* 2000)
> (unbox *diverge-ticks-box*)
2000
> 

Process scheme finished
Chez Scheme Version 9.6.4
Copyright 1984-2023 Cisco Systems, Inc.

> (load "epi-0034.scm")
> passed
> (test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> > (test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> > (test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> > (test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> > (test-diverge "nevero"
  1000000000
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

  C-c C-c
break> r
> (test-diverge "nevero"
                (let ()
                  (define-relation (nevero)
                      (nevero))
                  (run 1 (q) (nevero))))

passed
> > (test-diverge "nevero"
                (let ()
                  (define-relation (nevero)
                      (nevero))
                  (run 1 (q) (nevero))))

passed
 > (careful-test-mode)
> (test-diverge "nevero"
                (let ()
                  (define-relation (nevero)
                      (nevero))
                  (run 1 (q) (nevero))))

passed
>   C-c C-c
  C-c C-c
> 

Process scheme finished
Chez Scheme Version 9.6.4
Copyright 1984-2023 Cisco Systems, Inc.

> (load "epi-0034.scm")
> (test-diverge "nevero"
                (let ()
                  (define-relation (nevero)
                      (nevero))
                  (run 1 (q) (nevero))))

passed
> > (test-diverge "nevero"
                (let ()
                  (define-relation (nevero)
                      (nevero))
                  (run 1 (q) (nevero))))

passed
> > (test-diverge "nevero"
                (let ()
                  (define-relation (nevero)
                      (nevero))
                  (run 1 (q) (nevero))))

passed
> 

Process scheme finished
Chez Scheme Version 9.6.4
Copyright 1984-2023 Cisco Systems, Inc.

> (load "epi-0034.scm")
> passed
> (test-diverge "finishes"
  1000
  (lambda (x) (x x)))

Exception in test-diverge: Divergent test "finishes" failed!
Expression (lambda (x) (x x))
 converged to value #<procedure>
(with 1000 out of 1000 ticks of fuel remaining)
instead of diverging

Type (debug) to enter the debugger.
> (test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero))))

passed
> > 1000000000
> > 1
> > 1000000000
> (test-diverge "nevero"
                (let ()
                  (define-relation (nevero)
                      (nevero))
                  (run 1 (q) (nevero))))

passed
> (expand '(test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero)))))
(test-diverge-helper
  "nevero"
  (get-test-starting-fuel)
  (lambda ()
    (letrec* ([#{nevero onxuwcx3t1lcrdknnozftlbc3-0} (lambda ()
                                                       (lambda (#{st onxuwcx3t1lcrdknnozftlbc3-1})
                                                         (lambda ()
                                                           (let ([#{scope onxuwcx3t1lcrdknnozftlbc3-2} (subst-scope
                                                                                                         (state-S
                                                                                                           #{st onxuwcx3t1lcrdknnozftlbc3-1}))])
                                                             ((#{nevero onxuwcx3t1lcrdknnozftlbc3-0})
                                                               #{st onxuwcx3t1lcrdknnozftlbc3-1})))))])
      (take
        1
        (lambda ()
          (let ([#{st onxuwcx3t1lcrdknnozftlbc3-3} empty-state])
            (lambda ()
              (let ([#{scope onxuwcx3t1lcrdknnozftlbc3-4} (subst-scope
                                                            (state-S
                                                              #{st onxuwcx3t1lcrdknnozftlbc3-3}))])
                (let ([#{q onxuwcx3t1lcrdknnozftlbc3-5} (var #{scope onxuwcx3t1lcrdknnozftlbc3-4})])
                  (bind
                    ((#{nevero onxuwcx3t1lcrdknnozftlbc3-0})
                      #{st onxuwcx3t1lcrdknnozftlbc3-3})
                    (lambda (#{st onxuwcx3t1lcrdknnozftlbc3-6})
                      (let ([#{st onxuwcx3t1lcrdknnozftlbc3-7} (state-with-scope
                                                                 #{st onxuwcx3t1lcrdknnozftlbc3-6}
                                                                 nonlocal-scope)])
                        (let ([#{z onxuwcx3t1lcrdknnozftlbc3-8} ((reify
                                                                   #{q onxuwcx3t1lcrdknnozftlbc3-5})
                                                                  #{st onxuwcx3t1lcrdknnozftlbc3-7})])
                          (#2%cons
                            #{z onxuwcx3t1lcrdknnozftlbc3-8}
                            (lambda () (lambda () #f)))))))))))))))
  '(let ()
     (define-relation (nevero) (nevero))
     (run 1 (q) (nevero))))
> (print-gensym #f)
> (expand '(test-diverge "nevero"
  (let ()
    (define-relation (nevero)
      (nevero))
    (run 1 (q) (nevero)))))
(test-diverge-helper
  "nevero"
  (get-test-starting-fuel)
  (lambda ()
    (letrec* ([nevero (lambda ()
                        (lambda (st)
                          (lambda ()
                            (let ([scope (subst-scope (state-S st))])
                              ((nevero) st)))))])
      (take
        1
        (lambda ()
          (let ([st empty-state])
            (lambda ()
              (let ([scope (subst-scope (state-S st))])
                (let ([q (var scope)])
                  (bind
                    ((nevero) st)
                    (lambda (st)
                      (let ([st (state-with-scope st nonlocal-scope)])
                        (let ([z ((reify q) st)])
                          (#2%cons
                            z
                            (lambda () (lambda () #f)))))))))))))))
  '(let ()
     (define-relation (nevero) (nevero))
     (run 1 (q) (nevero))))
> (expand '(test-diverge "simple" 42))
(test-diverge-helper
  "simple"
  (get-test-starting-fuel)
  (lambda () 42)
  42)
> (expand '(test-diverge "simple" (* 3 4)))
(test-diverge-helper
  "simple"
  (get-test-starting-fuel)
  (lambda () (#2%* 3 4))
  '(* 3 4))
> (define-syntax test-diverge
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
> (expand '(test-diverge "simple" (* 3 4)))
(let ([eng (#2%make-engine (lambda () (#2%* 3 4)))])
  (eng (get-test-starting-fuel)
       (lambda (t v)
         (#2%error
           'test-diverge
           (#2%format
             "Divergent test ~s failed!\nExpression ~s\n converged to value ~s\n(with ~s out of ~s ticks of fuel remaining)\ninstead of diverging\n"
             "simple" '(* 3 4) v t (get-test-starting-fuel))))
       (lambda (e) 'passed)))
> 