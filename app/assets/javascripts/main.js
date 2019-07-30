$(document).ready(() => {

// TODO: check for page loaded, so that js doesnt run on every page.

// NEW DINO ///////////////////////////////////////////////////////////////

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

// ACCESSORY SELECT //////////////////////////////////////////////////////////

  // Array containing all the currently checked accessories. Updated on click of a checkbox.
  let checkedAccessories = [];
  let renderAccessory = false;

  // When you click on an input, check all the inputs, and remake the array.
  $("input[type=checkbox]").on("click", function () {
    // Find accessories currently rendered to compare to the checked list.
    let allAccessoriesRendered = $(".accessories_selected");

    const accessoryId = this.getAttribute("value");
    const imageURL = accessoryImages[accessoryId]

    if ($(this).is(':checked')) {
      // Loop through currently rendered accessories, checking against the checked accessories.
      for (let j=0; j < allAccessoriesRendered.length; j++) {
        if (allAccessoriesRendered[j].getAttribute("value") == accessoryId) {
          // If the checked icon is already rendered, skip.
        }
        else {
          addAccessory(imageURL, accessoryId);
          // break out of loop so you don't add multiples.
          return;
        }
      }
    }
    else {
      const uniqueId = "#accessoryRendered" + accessoryId;
      removeAccessory(uniqueId);
    }
  });

  function addAccessory (imageURL, accessoryId) {
    let icon = $('<img class="accessories_selected">');
    icon.attr("src", imageURL);
    icon.attr("value", accessoryId);
    const uniqueId = "accessoryRendered" + accessoryId;
    icon.attr("id", uniqueId);

    icon.appendTo("#accessories_selected");
    icon.on("click", function () {
      const left = icon.css("left");
      const top = icon.css("top");
      $("#positions_" + accessoryId + "_x").val(top);
      $("#positions_" + accessoryId + "_y").val(left);
    });
    icon.draggable({
      // TODO: make a box to contain draggable elements
        containment: ".create_character_grid",
        scroll: false
      });
  }

// TODO: fix: When you remove an accessory, they all jump left 80px.
  function removeAccessory (uniqueId) {
    console.log(uniqueId);
    $(uniqueId).remove();
  }



// DRAGGING ///////////////////////////////////////////////////////////////////
// Detect when an image is being dragged, when mouseup, find the associated hidden form and set the values.
function onMouseUp (id, axis) {
  console.log("mouseup");
  // positions_29_x
  $("#positions_" + id + "_" + axis).val("")
}

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
