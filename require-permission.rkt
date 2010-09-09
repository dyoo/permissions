#lang racket/base

(require (for-syntax racket/base)
         (for-syntax "record.rkt"))

(define-syntax (require-permission stx)
  (syntax-case stx ()
    [(_ perms ...)
     (andmap (compose string? syntax-e) (syntax->list #'(perms ...)))
     (with-syntax ([permissions (datum->syntax stx 'permissions)]
                   [src (syntax-source stx)])
       (syntax/loc stx
         (begin
           #;(provide (for-syntax permissions))
           (begin-for-syntax
             (printf "introduced by require-permission\n")
             (record-permission (quote src) (list (#%datum perms) ...))
             #;(define permissions (list (#%datum perms) ...))))))]))




(provide require-permission)