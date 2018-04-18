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
    if($("#editor").length) {

        var editor_content = $("#layout_content").val();
        var editor = ace.edit("editor");

        editor.setValue(editor_content);
        editor.clearSelection(); // This will remove the highlight over the text

        editor.setOptions({
            maxLines: 25,
            autoScrollEditorIntoView: true,
            theme: "ace/theme/monokai",
            showPrintMargin: false,
            mode: "ace/mode/html_elixir"
        });

        editor.getSession().on('change', function() {
            var val = editor.getSession().getValue();
            $("#layout_content").val(val);
        });
    }
})
