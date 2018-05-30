# Copyright 2018 by John Dupuy
# MIT License; see the LICENSE file for details.
#
#  WEBTERMINAL
#
#  A set of simple set of procedures to enable a nim app to send/receive
#  text strings to a "terminal" on a web page consisting of a PRE and a FORM.
#
#  This library requires the corresponding Javascript and HTML.
#
proc establish_terminal_on_start_function*(on_terminal_start: proc): void
  {.importcpp: "establish_terminal_on_start_function(@)".}

proc establish_terminal_on_input_function*(on_terminal_input: proc): void 
  {.importcpp: "establish_terminal_on_input_function(@)".}

proc send(msg: cstring): void
  {.importcpp: "send(@)".}

proc send*(msg: string): void =
  send(msg.cstring)


