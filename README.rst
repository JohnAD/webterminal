Introduction to webterminal
==============================================================================
ver 0.0.2

.. image:: https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png
   :height: 34
   :width: 131
   :alt: nimble
   :target: https://nimble.directory/pkg/webterminal

.. image:: https://repo.support/img/rst-banner.png
   :height: 34
   :width: 131
   :alt: repo.support
   :target: https://repo.support/gh/JohnAD/webterminal

Very simple browser Javascript TTY web terminal

This library consists of three parts:

1. A HTML page to hold the elements needed to show the terminal and reference the javascript.

2. A prewritten, but small, javascript file called `tiny_pre_tty.js`.

3. A nimble library to access the web page terminal from nim.

The result, using the included "simple example", looks like this:

.. image:: https://github.com/JohnAD/webterminal/raw/master/screenshot.png
   :height: 506
   :width: 640
   :alt: simple example

The user sees the output in the large text box (an HTML PRE element). The user can also send a string with the INPUT form element below the box.

How to Use
----------

1. Copy the `tiny_pre_tty.js` to the destination directory. It can be downloaded or forked from GitHub.

2. Make the HTML file. Either start with one of the examples, or include the following elements in the web page:

    .. code:: html

        <!doctype html>
        <html>
          <head>
            <script src="tiny_pre_tty.js"></script>
            <script src="app.js"></script>
          </head>
          <body onload="initTerminal(24)">
            <p>
              <pre id="terminal" width="80" style="border: 1px solid black">
                initializing...
              </pre>
            </p>
            <div class="center">
              <p>
                <input type="text" value="" id="input_dialog" size="80" />
                <button type="button" onclick="sendInput()" id="input_button">Send</button>
              </p>
            </div>
          </body>
        </html>

    Specifically, include:

    a. ``<script>`` references to both ``tiny_pre_tty.js`` and whatever you name your app.

    b. after loading the body, invoke ``initTerminal(line-count)`` where ``line-count`` is an integer representing how many lines you want in the terminal box.

    c. an ``<input>`` element with an ``id`` of ``input_dialog``.

    d. a ``<pre>`` element with an ``id`` of ``terminal``.

    e. optionally, a ``<button>`` element with an ``id`` of ``input_button``. Have the button generate a call to ``sendInput()``.

    You can, of course, style the web page with CSS and other items. This example simply shows the bare minimum. Input displayed on the screen is wrapped with a ``<span class="in">``.

3. Create a nim script.

    After installing the library:

    .. code:: bash

        nimble install webterminal

    Import the library into your nim source code.

    Use `send(string)` to send text to the web terminal box. (When targeting Javascript, the `echo` command sends text to the console log.)

    Write two procedures (any name) that handle, the web terminal starting:

    .. code:: nim

        establish_terminal_on_start_function(proc)

    and when input is sent from the user:

    .. code:: nim

        establish_terminal_on_input_function(proc)

    The procedure for capturing input is passed a single `string` parameter.

    An example script:

    .. code:: nim

        import webterminal

        # a simple example that simply repeats anything the user types

        proc on_terminal_start() =
          send("3\n2\n1\n")
          send("The repeating app has started.")

        establish_terminal_on_start_function(on_terminal_start)

        proc on_terminal_input(msg: string) =
          send("You just said \"" & msg & "\".")

        establish_terminal_on_input_function(on_terminal_input)


Live Example
-------------

Visit: https://nimgame.online/game/game-of-knights

The source for this example can be found in the ``knights_example``
subdirectory. This example also requires the ``turn_based_game`` and ``negamax`` nimble libraries.




Table Of Contents
=================

1. `Introduction to webterminal <https://github.com/JohnAD/webterminal>`__
2. Appendices

    A. `webterminal Reference <https://github.com/JohnAD/webterminal/blob/master/docs/webterminal-ref.rst>`__
