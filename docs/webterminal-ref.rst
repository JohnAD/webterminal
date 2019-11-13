webterminal Reference
==============================================================================

The following are the references for webterminal.






Procs, Methods, Iterators
=========================


.. _establish_terminal_on_input_function.p:
establish_terminal_on_input_function
---------------------------------------------------------

    .. code:: nim

        proc establish_terminal_on_input_function*(on_terminal_input: proc): void

    source line: `126 <../src/webterminal.nim#L126>`__

    One of the two required calls to make webterminal work. Call this  procedure
    with the name of a procedure that handles what should occur
    when the end user has entered text and submitted it.


.. _establish_terminal_on_start_function.p:
establish_terminal_on_start_function
---------------------------------------------------------

    .. code:: nim

        proc establish_terminal_on_start_function*(on_terminal_start: proc): void

    source line: `120 <../src/webterminal.nim#L120>`__

    One of the two required calls to make webterminal work. Call this procedure
    with the name of a procedure to establish what is called
    when the terminal session begins.


.. _send.p:
send
---------------------------------------------------------

    .. code:: nim

        proc send*(msg: string): void =

    source line: `135 <../src/webterminal.nim#L135>`__

    Use this procedure to send ``msg`` text to the web terminal.
    
    Embed "\\n" carriage return characters to move the terminal cursor to the next line.







Table Of Contents
=================

1. `Introduction to webterminal <https://github.com/JohnAD/webterminal>`__
2. Appendices

    A. `webterminal Reference <webterminal-ref.rst>`__
