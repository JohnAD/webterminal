var tty = document.getElementById('terminal');
var input_dialog = document.getElementById('input_dialog')
var lines = []
var linetypes = []
var LINECNT = 24;
reset_arrays();
var terminal_on_start_function = null;
var terminal_on_input_function = null;

function establish_terminal_on_start_function(f) {
  terminal_on_start_function = f;
}

function establish_terminal_on_input_function(f) {
  terminal_on_input_function = f;
}

function reset_arrays() {
  lines = [];
  linetypes = [];
  for (i = 0; i < LINECNT; i++) {
    lines.push("");
    linetypes.push(false)
  };
};

function refresh() {
  var temp = ""

  for (i = 0; i < LINECNT; i++) {
    if (linetypes[i]==true) {
      temp += '<span class="in">';
    } else {
      temp += '<span class="out">';
    }
    temp += lines[i];
    temp += '</span>\n'
  };
  tty.innerHTML = temp;
};

function initTerminal(size) {
  LINECNT = size;
  tty = document.getElementById('terminal');
  input_dialog = document.getElementById('input_dialog')
  reset_arrays();
  refresh();
  // prevent the Enter key from submitting the page.
  input_dialog.addEventListener("keyup", function(event) {
    event.preventDefault();
    if (event.keyCode === 13) {
      document.getElementById("input_button").click();
    }
  });
  terminal_on_start_function();
};

function _send_part(msg, type) {
  lines.shift();
  lines.push(msg);
  linetypes.shift();
  linetypes.push(type);
};

function _send(msg, type) {
  var parts = msg.match(/.{1,80}/g) || [];
  for (i = 0; i < parts.length; i++) {
    _send_part(parts[i], type);
  };
};

function send(msg) {
  _send(msg, false)
  refresh();
};

function sendInput() {
  msg = input_dialog.value;
  _send(msg, true);
  refresh();
  terminal_on_input_function(msg);
  input_dialog.value = "";
};

function clearScreen() {
  reset_arrays();
  refresh();
};

