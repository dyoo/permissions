#lang racket/base

(require racket/contract)

(provide/contract [query-module-permissions
                   (module-path? . -> . (listof string?))])

;; query-module-permissions: module-path -> (listof string)
;; Given a module, see what permissions it is declaring.
(define (query-module-permissions a-module-path)
  (dynamic-require a-module-path #f #;'permissions))


(query-module-permissions "t/open-image-url.rkt")