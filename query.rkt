#lang racket/base

(require racket/contract)

(provide/contract [query-module-permissions
                   (module-path? . -> . (listof string?))])

;; query-module-permissions: module-path -> (listof string)
;; Given a module, see what permissions it is declaring.
(define (query-module-permissions a-module-path)
  (parameterize ([current-namespace (make-base-empty-namespace)])
    (dynamic-require a-module-path (void)) ;; get the compile-time code running.
    (dynamic-require-for-syntax "record.rkt" 'records)))


(query-module-permissions "t/open-image-url.rkt")