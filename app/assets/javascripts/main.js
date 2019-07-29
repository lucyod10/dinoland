$(document).ready(() => {

// TODO: check for page loaded, so that js doesnt run on every page.

// NEW DINO ///////////////////////////////////////////////////

// create a hash in the controller for dino_images as the value to their id

// in form html, convert hash to json for access in js.

// find select menu, and attach on 'change'
// for each change, find the value of 'this', which will be the species id
// Use the dino hash to find the associted image.

//set the image to the div.
// trigger('change') to make it load without an actual change.

  $("select#character_species_id").on("change", function () {
    const species_id = $(this).val();
    const image = speciesImages[ species_id ];
    console.log(image);
    $("#character_edit").attr("src", image);
  }).trigger("change");

// ACCESSORY SELECT

  let checkedAccessories = [];
// When you click on an input, check all the inputs, and remake the array.
  $("input[type=checkbox]").on("click", function () {
    // clear the current list.
    checkedAccessories = [];
    // find all checkboxes:
    let accessoryCheckboxes = $("input[type=checkbox]");
    accessoryCheckboxes.each(function () {
      if ($(this).is(':checked')) {
        checkedAccessories.push($(this).attr('data'));
      }
    })
    //console.log("list " + checkedAccessories);
    accessorySelectedPanel();
  });

  function accessorySelectedPanel () {
    // TODO: instead of remaking this list, check against array, remove those that arent there, and add those that are.
    // otherwise it resets the X and Y positions.
    //$("#accessories_selected").empty();
      for (let i=0; i < checkedAccessories.length; i++) {
        // if this accessory is already in list, do not re-render.
        // TODO: Don't re-render every image, find a way to loop through currently rendered images, and remove the ones that shouldnt be there, and add the new ones.
        let allAccessoriesRendered = $(".accessories_selected");
        for (let j=0; j < allAccessoriesRendered.length; j++) {
          // console.log(checkedAccessories[i] + " " + allAccessoriesRendered[j].getAttribute("data"));
          if (checkedAccessories[i] == allAccessoriesRendered[j].getAttribute("data")) {
          // else, check for images rendered, and remove them if not in list.
          }
        }

        //console.log("panel: " + checkedAccessories[i]);
        let icon = $('<img class="accessories_selected">');
        icon.attr("src", accessoryImages[checkedAccessories[i]]);
        icon.attr("data", checkedAccessories[i]);

        icon.appendTo("#accessories_selected");
        icon.draggable({
          // TODO: make a box to contain draggable elements
            containment: ".create_character_grid",
            scroll: false
          });
      }
  }

  function draggableAccessory (i) {
    // else, check for images rendered, and remove them if not in list.
    //console.log("panel: " + checkedAccessories[i]);
    let icon = $('<img class="accessories_selected">');
    icon.attr("src", accessoryImages[checkedAccessories[i]]);
    icon.attr("data", checkedAccessories[i]);

    icon.appendTo("#accessories_selected");
    icon.draggable({
      // TODO: make a box to contain draggable elements
        containment: ".create_character_grid",
        scroll: false
      });
  }

// DRAGGING //////////////////////////////////////////////////
// TODO: Make dragging limits to image.
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
