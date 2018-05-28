function on_terminal_input(msg) {
    send("You just said '" + msg + "'");
};

function on_terminal_start() {
  send("3\n2\n1\n");
  send("The repeating app has started.");
};
