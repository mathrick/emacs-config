What is it?
===========

This is my Emacs config. It's been heavily instrumented using
[Grail](https://github.com/codermattie/Grail),
[Cask](https://github.com/rejeep/cask.el) and
[Pallet](https://github.com/rdallasgray/pallet) 
to make it possible to bootstrap easily without committing external
packages to the repo, in a single command. It also makes it possible
to structure the code cleanly and share it between machines and OSs
sanely.

Why would I care?
-----------------

You don't have to! I mostly keep it here for myself. You might want to
look at my config, or perhaps copy it, but there's another thing you
might be interested in: the code structure and bootstrapping
infrastructure. If that's the case and you'd like to steal it, read
below.

How do I use it?
================

Bootstrap a fresh Emacs install
--------------------------------------

First of all, checkout this repo. Below I'll assume the checkout will
live under `~/elisp/`. And so does the `grail.el` (for now), so if you
place it elsewhere, you will have to adjust `grail-elisp-root` in it.

Next, make a .emacs file. It can be either a symlink (on Unix) to `grail.el`:

    $ ln -s ~/elisp/grail.el ~/.emacs

*or* a file with the following contents (on Windows):

    (load-file "~/elisp/grail.el")

This sets up Grail and tells Emacs where to find all the rest.

Then, bootstrap the package-management packages:

    $ emacs -l ~/elisp/bootstrap.el

That's it! Now you just wait. This will make sure ELPA & MELPA are
initialised, and will fetch Pallet & Cask to do the rest of dependency
management. When those are reay, it will do the actual fetching of the
packages your Cask manifest specifies (and will probably take a few
minutes). 

When it's no longer compiling anything (it should show you
the splash screen), you can close Emacs and start it normally.

It installed Pallet, but compilation said "Cannot open load file cask"
---------------------------------------------------------------------

Yeah, it does that. Doesn't seem to matter though. Same happens when
you do `cask-install`; it basically doesn't seem to be able to find
the just-installed packages properly. It still works in the end.