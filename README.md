# Shoes Decision Maker

# Requirements
Decision maker is a Shoes app, so you need Shoes installed on your system to
run it.

Installing Shoes is a breeze, as it comes available for most OSes; please check
[Shoes' official website](http://shoesrb.com/) for downloads and instructions.

# Usage
You can start your personal decision-making assistant by invoking it from the
command line:

    ./decision_maker

The script will invoke the first Shoes executable it finds on its path.

If you're using an OS like OS X, which doesn't like too much to add stuff to
your command line path list, you may need to add your Shoes' installation
folder to your `$PATH`. The simplest way to do that is to add an alias in
your `~/.bash_profile` or ``~/.zshrc`:

    alias shoes /Application/Shoes.app/Contents/MacOS/shoes
