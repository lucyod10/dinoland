$(document).ready(() => {


  $("#characterScrollerInner").draggable({
    // TODO: make a box to contain draggable elements
      // containment: ".create_character_grid",
      axis: "x",
      scroll: true
    });

    let characters = $(".characterImage");

    characters.on("dblclick", function () {
      characters = $(".characterImage");
      characters.removeClass("characterSelected");
      this.classList.add("characterSelected");
      let id = this.getAttribute("id");
      $('#selectedCharacterHidden').val(id);

    });

// DRAGGING ///////////////////////////////////////////////////////////////////

  $(function() {
    var isDragging = false;
    $("a")
    .mousedown(function() {
        isDragging = false;
    })
    .mousemove(function() {
        isDragging = true;
     })
    .mouseup(function() {
        var wasDragging = isDragging;
        isDragging = false;
    });
  });

});
