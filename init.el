 (setq visible-bell 1)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

(el-get 'sync)

;; Shell stuff
(let ((path (shell-command-to-string ". ~/.bash_login; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; Clojure stuff
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
(setq explicit-bash-args '("--login" "--init-file" "~/.bash_profile" "-i"))
(show-paren-mode t)
(add-to-list 'load-path "~/.emacs.d/")
(require 'clojure-mode)

;; Org-mode
(setq load-path (cons "~/.emacs.d/org-7.8.05/lisp" load-path))
(setq load-path (cons "~/.emacs.d/org-7.8.05/contrib/lisp" load-path))

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list 
                        "~/Dropbox/org/ejorp.org"
                        "~/Dropbox/org/emacs.org"))

(require 'org-mac-message)
(setq org-startup-indented t)

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; Tabs
(setq-default tab-width 2) ; or any other preferred value
(setq-default indent-tabs-mode nil)
(setq js-indent-level 2)

;; Remember
(global-set-key (kbd "C-c r") 'remember)    ;; (1)
(add-hook 'remember-mode-hook 'org-remember-apply-template) ;; (2)
(setq org-remember-templates
      '((?n "* %U %?\n\n  %i\n  %a" "~/org/notes.org")))  ;; (3)
(setq remember-annotation-functions '(org-remember-annotation)) ;; (4)
(setq remember-handler-functions '(org-remember-handler)) ;; (5)
