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
import "./clipboard.min"
import "./jquery-resizable"
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

$(document).ready(function() {
    $(".nav-link").on("click", function() {
        console.log($(this));
    });

    $(".panel-left").resizable({
        handleSelector: ".splitter",
        resizeHeight: false,
        onDrag: function(e, el, newWidth, newHeight, opt) {
            var bodyWidth = $("body").width();
            var mixWidth = bodyWidth - 680;
            if(newWidth >= mixWidth) {
                return false;
            }
        }
    });

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
            mode: "ace/mode/html_elixir",
            enableBasicAutocompletion: true
        });

        editor.getSession().on('change', function() {
            var val = editor.getSession().getValue();
            $("#layout_content").val(val);
        });
    }

    if($("#page_editor").length) {

        var bodyHeight = $('body').height()
        var css = "height: " + bodyHeight + "px !important;"
        $(".ace_editor").css(css);


        var page_editor_content = $("#page_content").val();
        var page_editor = ace.edit("page_editor");

        page_editor.setValue(page_editor_content);
        page_editor.clearSelection(); // This will remove the highlight over the text

        page_editor.setOptions({
            maxLines: 35,
            autoScrollEditorIntoView: true,
            theme: "ace/theme/monokai",
            showPrintMargin: false,
            mode: "ace/mode/html_elixir",
            enableBasicAutocompletion: true
        });

        page_editor.container.webkitRequestFullscreen()

        page_editor.getSession().on('change', function() {
            var val = page_editor.getSession().getValue();
            var site_id = $("#page_site_id").val();
            var layout_id = $("#page_layout_id").val();
            var title = $("#page_title").val();
            page_channel.push("show_preview", {data: val, site_id: site_id, layout_id: layout_id, title: title})
            $("#page_content").val(val);
        });

        $("#full-screen-edit").on('click', function() {
            $("#iframe-container").toggleClass('d-none');
            $('#splitter').toggleClass('d-none');
            if($("#page_editor").width() > 600) {
                $("#page_editor").width(600);
            } else {
                $("#page_editor").width($('body').width() - 30);
            }
        });
    }

    if($("#help_editor").length) {

        var page_editor_content = $("#help_content").val();
        var page_editor = ace.edit("help_editor");

        page_editor.setOptions({
            maxLines: 25,
            autoScrollEditorIntoView: true,
            theme: "ace/theme/monokai",
            showPrintMargin: false,
            mode: "ace/mode/html_elixir"
        });
    }

    if($("#new_page").length) {
        $("#page_site_id").val($("#page_site_id option:eq(1)").val());
        $("#page_layout_id").val($("#page_layout_id option:eq(1)").val());
    }

    if($("#new_asset").length) {
        $("#asset_site_id").val($("#asset_site_id option:eq(1)").val());
    }

    if($("#new_layout").length) {
        $("#layout_site_id").val($("#layout_site_id option:eq(1)").val());
    }

    // On file select set the name automatically
    $("input:file").change(function (){
         var fileName = $(this)[0].files[0]['name'];
         $("#asset_name").val(fileName);
    });

    $("#toggle-page-inputs").on('click', function(e) {
        e.preventDefault();
        $("#common-page-inputs").toggleClass('d-none');
    });

    $("#toggle-layout-inputs").on('click', function(e) {
        e.preventDefault();
        $("#common-layout-inputs").toggleClass('d-none');
    });

    // Clipboard to copy asset path.
    var clipboard = new Clipboard(".copy-btn");
    clipboard.on('success', function(e) {
        var element = $(e.trigger);
        $(element).tooltip('show');
        e.clearSelection();
    });

    clipboard.on('error', function(e) {
        console.error('Action:', e.action);
        console.error('Trigger:', e.trigger);
    });
})
