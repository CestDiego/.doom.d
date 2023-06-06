;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Diego Berrocal"
      user-mail-address "3291619+CestDiego@users.noreply.github.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(use-package! good-scroll
  :config
  (good-scroll-mode 1))

(setq ns-use-native-fullscreen t)


;; (setq frame-title-format
;;       '(""
;;         (:eval
;;          (if (s-contains-p org-roam-directory (or buffer-file-name ""))
;;              (replace-regexp-in-string
;;               ".*/[0-9]*-?" "☰ "
;;               (subst-char-in-string ?_ ?  buffer-file-name))
;;            "%b"))
;;         (:eval
;;          (let ((project-name (projectile-project-name)))
;;            (unless (string= "-" project-name)
;;              (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

;; (use-package! golden-ratio
;;   :after-call pre-command-hook
;;   :config
;;   (golden-ratio-mode +1)
;;   ;; Using this hook for resizing windows is less precise than
;;   ;; `doom-switch-window-hook'.
;;   (remove-hook 'window-configuration-change-hook #'golden-ratio)
;;   (add-hook 'doom-switch-window-hook #'golden-ratio))

;; (use-package org
;;   :mode ("\\.org\\'" . org-mode)
;;   :config (define-key org-mode-map (kbd "C-c C-r") verb-command-map))


;; (use-package graphql-mode
;;   :mode ("\\.graphql\\'" . graphql-mode))

;; (use-package! jest-test-mode
;;   :ensure t
;;   :commands jest-test-mode
;;   :hook (typescript-mode js-mode typescript-tsx-mode))


(defvar org-page-use-melpa-version t
  "If non-nil org-page will install package from MELPA, otherwise
  it will use the extension bundled in the layer")

(defvar org-page-built-directory (expand-file-name "org-page-built"
                                                   doom-cache-dir))
;;   "Default directory to output the built files when exporting")

(defvar theme-faces-for-generation
  '(font-lock-comment-delimiter-face
    font-lock-comment-face
    rainbow-delimiters-depth-1-face
    highlight-numbers-number
    font-lock-constant-face
    font-lock-string-face
    font-lock-keyword-face
    font-lock-variable-name-face
    rainbow-delimiters-depth-2-face
    font-lock-function-name-face
    rainbow-delimiters-depth-3-face
    font-lock-type-face
    font-lock-preprocessor-face
    font-lock-negation-char-face
    rainbow-delimiters-depth-4-face
    clojure-keyword-face
    clojure-interop-method-face
    css-selector css-property
    rainbow-delimiters-depth-5-face
    haskell-operator-face
    haskell-constructor-face
    haskell-definition-face
    haskell-keyword-face
    font-lock-doc-face
    c-annotation-face julia-macro-face
    org-default underline
    tuareg-font-lock-operator-face
    tuareg-font-lock-governing-face
    tuareg-font-lock-module-face
    tuareg-font-lock-constructor-face
    rainbow-delimiters-unmatched-face
    font-lock-builtin-face
    ;; org
    org-level-1
    org-level-2
    org-level-3
    org-level-4
    org-special-keyword
    org-meta-line
    org-document-info
    org-document-info-keyword
    org-document-title
    org-tag
    org-table
    org-level-5 org-level-6 org-level-7 org-level-8
    org-list-dt bold italic underline org-verbatim org-code org-footnote
    org-done  org-date org-todo org-link
    org-checkbox org-block-begin-line
    org-block-end-line)
  "faces that are gonna be used by `kek-html-htmlize-generate-css' function")

(defun kek-html-htmlize-generate-css ()
  (interactive)
  (require 'htmlize)
  (and (get-buffer "*html*") (kill-buffer "*html*"))
  (with-temp-buffer
    (let ((fl theme-faces-for-generation)
          (htmlize-css-name-prefix "org-")
          (htmlize-output-type 'css)
          f i)
      (while (setq f (pop fl)
                   i (and f (face-attribute f :inherit)))
        (when (and (symbolp f) (or (not i) (not (listp i))))
          (insert (org-add-props (copy-sequence "1") nil 'face f))))
      (htmlize-region (point-min) (point-max))))
  (org-pop-to-buffer-same-window "*html*")
  (goto-char (point-min))
  (if (re-search-forward "<style" nil t)
      (delete-region (point-min) (match-beginning 0)))
  (if (re-search-forward "</style>" nil t)
      (delete-region (1+ (match-end 0)) (point-max)))
  (beginning-of-line 1)
  (if (looking-at " +") (replace-match ""))
  (goto-char (point-min)))

(use-package! org-page
  :commands (op/do-publication-and-preview-site
             op/do-publication
             op/new-post
             op/new-repository)
  :config
  (setq op/theme-root-directory "~/.doom.d/themes/"
        op/theme 'just_right
        op/site-domain "https://diegoberrocal.com"
        op/repository-directory "~/Documents/Projects/cestdiego.github.io")
  ;; (spacemacs/set-leader-keys
  ;;  "opo" '(lambda () (interactive)
  ;;           (magit-status op/repository-directory))
  ;;  "opp" '(lambda() (interactive)
  ;;           (let ((org-html-htmlize-output-type 'css))
  ;;             (op/do-publication t nil t nil))
  ;;           (find-file op/repository-directory))
  ;;  "opp" '(lambda() (interactive)
  ;;           (let ((org-html-htmlize-output-type 'css))
  ;;             (op/do-publication t t org-page-built-directory))))
  (setq org-html-doctype "html5")
  (setq org-html-html5-fancy t)
  (defface strike-through
    '((t :strike-through t))
    "basic strike-through face."
    :group 'basic-faces)
  (unless (file-exists-p org-page-built-directory)
    (make-directory org-page-built-directory))
  :config
  (push '("+" ,(if (featurep 'xemacs) 'org-table strike-through)) org-emphasis-alist))
