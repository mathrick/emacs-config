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
[below](#stealing).

How do I use it?
================

Bootstrap a fresh Emacs install
--------------------------------------

First of all, checkout this repo. Below I'll assume the checkout will
live under `~/elisp/`. And so does the `grail.el` (for now), so if you
place it elsewhere, you will have to adjust `grail-elisp-root` in it.

Next, make a .emacs file. It can be either a symlink (on Unix) to `grail.el`:

    $ ln -s ~/elisp/grail.el ~/.emacs

**OR** a file with the following contents (on Windows):

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

<a name="stealing"/>
So you mentioned stealing it for myself. How do I do that?
----------------------------------------------------------

Right now, it's not absolutely 100% ready, and needs some minor fixes
that are important for wider consumption. Also, the hacky overrides I
had to apply to Pallet and Casket need to be pushed upstream and
integrated properly.

However, the main parts that you need are as follows:

1. `grail-*.el`
   Those are Grail files, and the backbone of the whole thing.
2. `Cask`
   This is where packages needed by the code are recorded. You can
   safely remove all but `melpa`, `cask` and `pallet`. After
   bootstrap, Pallet will take care of recording all activity, so just
   use the usual `list-package` and `package-install`, `package-delete`

   Note that for non-ELPA packages, you will probably need to use
   Grail profiles and installers
3. `local/elisp/pallet-overrides.el`
4. `bootstrap.el`

You **DO NOT** need any other files or directories (though copying this
README is advised). Nothing in `local/`, nothing in `dist`, none of
the `*.el` files. Everything not mentioned above follows the normal
Grail rules, and you can use as much or as little of it as you
need. Those rules are explained on [Grail's Emacswiki
page](http://www.emacswiki.org/emacs/Grail).

Licence
=======

Grail is the work of Michael Mattie, and is distributed under its own
licence. The rest of the code not otherwise marked in this repository
is distributed under the terms of Creative Commons Public Domain
licence (aka CC0). You can do whatever you want with it, though fixes
and feedback are appreciated.