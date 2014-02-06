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
live under `~/elisp/`. If you put your checkout somewhere else, adjust
the paths correspondingly.

### Unix installation
1. Make a `~/.emacs` file. It should be a symlink (on Unix) to `grail.el`:

        $ ln -s ~/elisp/grail/grail.el ~/.emacs
2. Bootstrap the package-management packages:

        $ emacs -l ~/elisp/bootstrap.el

### Windows installation
1. Set up your HOME, as the default location is rather silly. Right
   click on *Computer* → *Properties* → *Advanced system settings* (Win7/Vista)
   or *Advanced* tab (XP) → *Environment variables*

   Click on `New...` user variable. Call it `HOME`, and give it the
   value of `%USERPROFILE%`. This will make it point to your user
   folder, which you can access for example by navigating to Desktop
   in the file explorer, then clicking the arrow in the address bar
   and selecting your user folder from the dropdown list.

   Below `~/` refers to the home directory you've just set up.

2. On Windows Emacs is unable to communicate with HTTPS hosts, so you
   will need to download an extra file. Go to
   https://raw.github.com/milkypostman/package-filter/master/package-filter.el
   and save it under `~/elisp/`.

3. Make a `~/.emacs` file:
    1. Launch Emacs, `C-x C-f ~/.emacs RET`
    2. Insert the following contents
     (load-file "~/elisp/grail/grail.el")
    3. `C-x C-s`, close Emacs

4. Launch the bootstrap:
    1. `C-x C-f ~/elisp/bootstrap.el RET`
    2. `M-x eval-buffer RET`
   
### Unix & Windows

That's it! Now you just wait. This will make sure ELPA & MELPA are
initialised, and will fetch Pallet & Cask to do the rest of dependency
management. When those are ready, it will do the actual fetching of the
packages your Cask manifest specifies (and will probably take a few
minutes). 

When it's no longer compiling anything (it should show you
the splash screen), you can close Emacs and start it normally.

It installed Pallet, but compilation said "Cannot open load file cask"
---------------------------------------------------------------------

Yeah, it does that. Doesn't seem to matter though. Same happens when
other packages are installed and compiled; it basically doesn't seem
to be able to find the just-installed packages properly. It still
works in the end.

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
   safely remove all but `package-filter`, `cask` and `pallet`. After
   bootstrap, Pallet will take care of recording all activity, so just
   use the usual `M-x list-package` and `M-x package-install`, `M-x
   package-delete`

   Note that for non-ELPA packages, you will probably need to use
   Grail profiles and installers

3. `local/elisp/pallet-overrides.el`

4. `bootstrap.el`

You **DO NOT** need any other files or directories (though copying this
README is advised). Nothing in `local/`, nothing in `dist/`, none of
the `*.el` files. Everything not mentioned above follows the normal
Grail rules, and you can use as much or as little of it as you
need. Those rules are explained on [Grail's Emacswiki
page](http://www.emacswiki.org/emacs/Grail).

Known issues
------------

1. Headless init (ie. `emacs --daemon`) breaks. I don't know if it's
   my fault or Grail's, and it will be a royal pain to debug
 
2. Grail needs a few more fixes and cleanups, and pushing upstream
 
3. Pallet and Cask assume `~/.emacs.d`, and need messy overrides.
   They should allow explicit overrides

Licence
=======

Grail is the work of Michael Mattie, and is distributed under its own
licence. The rest of the code not otherwise marked in this repository
is distributed under the terms of Creative Commons Public Domain
licence (aka CC0). You can do whatever you want with it, though fixes
and feedback are appreciated.