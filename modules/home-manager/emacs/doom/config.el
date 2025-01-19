;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 16))
;; (setq doom-font (font-spec :family "Noto Sans" :size 16)
;;      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 18))
;; (setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)
;; (doom/set-frame-opacity 80)
(add-to-list 'default-frame-alist '(alpha-background . 80))
(custom-theme-set-faces! 'doom-tokyo-night
  '(default :background "#000000")
  '(org-modern-todo :height 1.2)
  '(org-modern-done :height 1.2)
  '(org-modern-symbol :height 1.2)
  '(org-document-title  :height 2.0 :underline nil)
  '(org-level-1 :inherit outline-1 :height 1.75)
  '(org-level-2 :inherit outline-2 :height 1.5)
  '(org-level-3 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-4 :height 1.2)
  '(org-level-5 :inherit outline-5 :height 1.2)
  '(org-level-6 :inherit outline-6 :height 1.2)
  '(org-level-7 :inherit outline-7 :height 1.2)
  '(org-level-8 :inherit outline-8 :height 1.2)
  )


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Drive/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! colorful-mode
  :ensure t)

;; org-modern
;; (setq org-modern-label-border -0.3)
;; (global-org-modern-mode)
(use-package! org-modern
  :hook '(org-mode . org-modern-mode)
  :config
  (setq org-auto-align-tags nil
        org-tags-column 0
        org-fold-catch-invisible-edits 'show-and-error
        org-special-ctrl-a/e t
        org-insert-heading-respect-content t

        ;; Org styling, hide markup etc.
        org-hide-emphasis-markers t
        ;; org-pretty-entities t
        org-ellipsis "…"

        ;; Agenda styling
        org-agenda-tags-column 0
        org-agenda-block-separator ?─
        org-agenda-time-grid
        '((daily today require-timed)
          (800 1000 1200 1400 1600 1800 2000)
          " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        org-agenda-current-time-string
        "⭠ now ─────────────────────────────────────────────────"
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0))

(use-package! org-superstar
  :config
  ;; This is usually the default, but keep in mind it must be nil
  (setq org-hide-leading-stars nil
        ;; This line is necessary.
        org-superstar-leading-bullet ?\s
        ;; If you use Org Indent you also need to add this, otherwise the
        ;; above has no effect while Indent is enabled.
        org-indent-mode-turns-on-hiding-stars nil))

;; (setq line-spacing 0.2
;;       org-adapt-indentation t
;;       org-hide-leading-stars t
;;       org-hide-emphasis-markers t
;;       org-pretty-entities t
;;       org-ellipsis "  ·"))
;; Resize Org headings
;; (dolist (face '((org-level-1 . 1.35)
;;                 (org-level-2 . 1.3)
;;                 (org-level-3 . 1.2)
;;                 (org-level-4 . 1.1)
;;                 (org-level-5 . 1.1)
;;                 (org-level-6 . 1.1)
;;                 (org-level-7 . 1.1)
;;                 (org-level-8 . 1.1)))
;;   (set-face-attribute (car face) nil :font "Noto Sans" :weight 'bold :height (cdr face)))

;; Make the document title a bit bigger
;; (set-face-attribute 'org-document-title nil :font "Noto Sans" :weight
;; 'bold :height 1.8)
(require 'org-indent)
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch :height 0.85)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch) :height 0.85)
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
;; (add-hook 'org-mode-hook 'variable-pitch-mode)
;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
;; (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
;; (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-table nil :inherit 'fixed-pitch)

(after! nix-mode
  (set-formatter! 'alejandra '("alejandra" "--quiet") :modes '(nix-mode)))
