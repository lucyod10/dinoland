$(document).ready(() => {
  resizeAcc();

  // wait for accessory and character image loads, then resize image (needed so that it can access the width and height of the image, otherwise sets the width to 0)
  document.querySelectorAll(".character_accessory, .character_feature").forEach((item) => {
    item.onload = resizeAcc;
  });

  // If page is the edit dino page, when all accessories are loaded, make them draggable.
  if (document.getElementsByClassName("editContainer").length > 0) {
    document.querySelectorAll(".character_accessory").forEach((icon) => {
      console.log(icon)
      icon = $(icon);
      // change the X and Y values being sent to the database every time a user stops dragging.
      icon.on("click", function () {
        let left = icon.css("left");
        let top = icon.css("top");
        let accessoryId = icon.attr("id");
        accessoryId = accessoryId.replace(/(\D+)/, "");
        console.log(accessoryId)

        left = left.substr(0, left.length-2);
        top = top.substr(0, top.length-2);


        // Calculate the X and Y as a percentage, for responsiveness.
        const featureWidth = $(".character_feature").width();
        const featureHeight = $(".character_feature").height();

        left = left / featureWidth * 100;
        top = top / featureHeight * 100;
        console.log(left, top);

        $("#positions_" + accessoryId + "_x").val(top);
        $("#positions_" + accessoryId + "_y").val(left);
      });
      icon.draggable({
        // TODO: make a box to contain draggable elements
        // TODO: make draggable work on mobile
          containment: ".create_character_grid",
          scroll: false
      });
    });
  }

// NEW DINO ///////////////////////////////////////////////////////////////

// Each time the species dropdown value is changed, find the ID of the newly selected species,
// then find the associated image from a hash defined in the HTML - speciesImages
// then change the image of the feature image on the page to match.
  $("select#character_species_id").on("change", function () {
    const species_id = $(this).val();
    // find the image URL of each species from variable set in HTML.
    // Check if it is a cloudinary URL or a local path.
    let image = "/assets/" + speciesImages[ species_id ];
    if (image.indexOf("cloudinary") > -1) {
      image = speciesImages[ species_id ];
    }

    $("#character_edit").attr("class", "character_feature");
    $("#character_edit").attr("src", image);
  }).trigger("change");

// ACCESSORY SELECT //////////////////////////////////////////////////////////

  // When you click on an input, check all the inputs, and remake the array.
  $("input[type=checkbox]").on("click", function (e) {
    // Find accessories currently rendered to compare to the checked list.
    let allAccessoriesRendered = $(".accessories_selected");

    // find the image URL of the accessory clicked from variable set in HTML.
    // Check if it is a cloudinary URL or a local path.
    const accessoryId = this.getAttribute("value");
    let imageURL = "/assets/" + accessoryImages[accessoryId];
    if (imageURL.indexOf("cloudinary") > -1) {
      imageURL = accessoryImages[accessoryId];
    }

    if ($(this).is(':checked')) {
      // Loop through currently rendered accessories,
      // checking against the clicked on accessory.
      for (let j=0; j < allAccessoriesRendered.length; j++) {
        if (allAccessoriesRendered[j].getAttribute("value") == accessoryId) {
          // If the checked icon is already rendered, skip.
        }
        else {
          // If the checked icon is not already rendered, see if they can afford it, and render it if they can
          let tempCoins = Number($("#userTempCoins").text());
          let cost = Number(this.getAttribute("data"));

          if (tempCoins > cost) {
            // update users temp coin value.
            tempCoins -= cost;
            // update UI
            $("#userTempCoins").text(tempCoins);
            // update hidden field for the form in backend
            $("#userCoins").val(tempCoins);
            // add the accessory to the page for user to edit.
            addAccessory(imageURL, accessoryId);
          }
          else {
            // do not allow the check action, as the user cannot afford it.
            e.preventDefault();
          }
          // break out of loop once they render it, so you don't add multiples.
          // refresh which icons are red to indicate that the user can't afford
          renderNotEnoughCoins();
          return;
        }
      }
    }
    else {
      // If the clicked on accessory is not checked.
      // add the users coins back to their inventory, and remove accessory.
      const uniqueId = "#accessoryRendered" + accessoryId;
      removeAccessory(uniqueId);
      // add the money back into their account
      let tempCoins = Number($("#userTempCoins").text());
      let cost = Number(this.getAttribute("data"));
      tempCoins += cost;
      // update UI
      $("#userTempCoins").text(tempCoins)
      // update hidden field for the backend
      $("#userCoins").val(tempCoins);
    }
    // refresh which icons are red to indicate that the user can't afford
    renderNotEnoughCoins();
  });

  // Call addAccessory whenever an editable accessory should be added to the feature_image.
  function addAccessory (imageURL, accessoryId) {
    let icon = $('<img class="character_accessory">');
    icon.attr("src", imageURL);
    icon.attr("value", accessoryId);
    const uniqueId = "accessoryRendered" + accessoryId;
    icon.attr("id", uniqueId);

    icon.appendTo("#accessories_selected");
    // change the X and Y values being sent to the database every time a user stops dragging.
    icon.on("click", function () {
      let left = icon.css("left");
      let top = icon.css("top");

      left = left.substr(0, left.length-2);
      top = top.substr(0, top.length-2);


      // Calculate the X and Y as a percentage, for responsiveness.
      const featureWidth = $(".character_feature").width();
      const featureHeight = $(".character_feature").height();

      left = left / featureWidth * 100;
      top = top / featureHeight * 100;

      $("#positions_" + accessoryId + "_x").val(top);
      $("#positions_" + accessoryId + "_y").val(left);
    });
    icon.draggable({
      // TODO: make a box to contain draggable elements
      // TODO: make draggable work on mobile
        containment: ".create_character_grid",
        scroll: false
    });
    // resize icon if the screen is smaller than 600px. Timeout to allow image to load, otherwise width set to 0 until window is manually resized.
    setTimeout(resizeAcc, 500);
  }

  // after every click, filter through all the icons to check if you have enough money for them, turning them red if you dont.
  function renderNotEnoughCoins() {
    let allAccessoryIcons = $("input[type=checkbox]");
    let tempCoins = Number($("#userTempCoins").text());
    allAccessoryIcons.each(function () {
      let cost = Number(this.getAttribute("data"));
      if (tempCoins > cost) {
        // remove red colour
        $(this).closest("label").find("div").removeClass("error");
      }
      else {
        if ($(this).is(':checked')) {
          // do nothing
        }
        else {
          // turn icon red
          $(this).closest("label").find("div").addClass("error");
        }
      }
    });
  }

  function removeAccessory (uniqueId) {
    $(uniqueId).remove();
  }

  function changeCoins (cost) {
    let currentCoins = $("#userTempCoins").val();
    let newCoins = currentCoins - cost;
    // set new value to front facin UI (userTempCoins), as well as the hidden tag (userCoins) for the backend.
    $("#userTempCoins").val(newCoins);
    $("#userCoins").val(newCoins);
  }

// RESIZING ///////////////////////////////////////////////////////////////////
  // When the window is resized, scale all the accessories proportional to the feature image size.
  // responsive.
  $(window).resize(resizeAcc).trigger("resize");

  function resizeAcc() {
      let wrapper = $(".character_feature");
      let accessories = $(".character_accessory");
      accessories.each(function () {
        let accessoryOriginalW = this.naturalWidth;
        let accessoryOriginalH = this.naturalHeight;
        // Using 600 for now as that is the width and height of all species.
        // TODO: change this ("600") to a repsonsive number for the species being displayed.
        // let wrapperW = $(".character_feature").naturalWidth;
        // let wrapperH = $(".character_feature").naturalHeight;

        // caculate the original percentage that the accessory took of the feature image,
        // then multiply it by the new feature width to get the new accessory width.
        let w = $(".character_feature").width() * (accessoryOriginalW / 600);
        let h = $(".character_feature").height() * (accessoryOriginalH / 600);

        $(this).width(w);
        $(this).height(h);
      });
    }
}); //end
