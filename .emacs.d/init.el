;; Add package.el
(add-to-list 'load-path "~/.emacs.d/")
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; General Settings
(setq backup-directory-alist (quote (("." . "~/.emacs_backup")))
      truncate-partial-width-windows t)

;; Ido mode
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

;; Platform-specific stuff
(if (eq system-type 'darwin)
    (progn
      ;; Work around a bug on OS X where system-name is FQDN
      (setq esk-system-name (car (split-string system-name "\\.")))
      (setq ispell-program-name "/opt/local/bin/aspell"))
  (progn
    (setq ispell-program-name "/usr/bin/aspell")
    (setq browse-url-browser-function (quote browse-url-generic))
    (setq browse-url-generic-program "chromium-browser")))

;; Add lein path
(setenv "PATH" (concat "~/bin:" (getenv "PATH")))

;; Org mode settings
(add-hook 'org-mode-hook 'turn-on-flyspell)
(setq org-directory "~/Dropbox/Work/Notes")
(setq org-agenda-files (list org-directory)
      org-id-locations-file org-directory)
(global-set-key (kbd "<f12>") 'org-agenda)
;;(setq org-upcoming-deadline '(:foreground "blue" :weight bold))
(setq org-agenda-start-on-weekday nil)
(setq org-deadline-warning-days 7)
(setq org-agenda-skip-deadline-if-done nil)
(setq org-agenda-skip-scheduled-if-done nil)
(setq org-archive-location (concat org-directory "/archive/%s_archive::"))
(add-hook 'message-mode-hook '(lambda () (setq fill-column 72)) 'append)

;; Disable C-c [ and C-c ] in org-mode
(add-hook 'org-mode-hook
          (lambda ()
            ;; Undefine C-c [ and C-c ] since this breaks my
            ;; org-agenda files when directories are include It
            ;; expands the files in the directories individually
            (org-defkey org-mode-map "\C-c["    'undefined)
            (org-defkey org-mode-map "\C-c]"    'undefined)) 'append)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "|" "DONE(d)")
              (sequence "WAITING(w)" "STALLED(S)" "|" "CANCELLED(c)" "PHONE"))))

(setq org-todo-keyword-faces 
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("STARTED" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("STALLED" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

