#lang racket/base

(require (for-syntax scheme/base))

(define-syntax (declare-permission stx)
  (syntax-case stx ()
    [(_ id some-string ...)
     (andmap string? (syntax->list (syntax-e #'(some-string ...))))
     (begin
       
       ;; What do I do here to annotate the binding at compile time?
       
       (syntax/loc stx
         (void)))]))

