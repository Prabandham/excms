// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import "./pushy.min"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(document).ready(function() {
    var editor = ace.edit("layout_content");
    editor.setTheme("ace/theme/monokai");
    editor.session.setMode("ace/mode/html_elixir");

    $("#show_editor").on("click", function(e) {
        e.preventDefault();
        $($(".ace_editor")[0]).addClass("full-screen-edit")
    });

    editor.commands.addCommand({
        name: 'Close Editor',
        bindKey: {win: 'Ctrl-X',  mac: 'Command-X'},
        exec: function(editor) {
            $($(".ace_editor")[0]).removeClass("full-screen-edit")
        },
        readOnly: true // false if this command should not apply in readOnly mode
    });
})
