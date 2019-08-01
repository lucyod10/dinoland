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
    const image = "/assets/" + speciesImages[ species_id ];
    $("#character_edit").attr("class", "character_feature");
    $("#character_edit").attr("src", image);
  }).trigger("change");

// ACCESSORY SELECT //////////////////////////////////////////////////////////

  // Array containing all the currently checked accessories. Updated on click of a checkbox.
  let checkedAccessories = [];
  let renderAccessory = false;

  // When you click on an input, check all the inputs, and remake the array.
  $("input[type=checkbox]").on("click", function (e) {
    renderNotEnoughCoins();

    // Find accessories currently rendered to compare to the checked list.
    let allAccessoriesRendered = $(".accessories_selected");

    const accessoryId = this.getAttribute("value");
    
    let imageURL = "/assets/" + accessoryImages[accessoryId];

    if (accessoryImages[accessoryId].indexOf("cloudinary") > -1) {
      imageURL = accessoryImages[accessoryId];
    }


    if ($(this).is(':checked')) {
      // Loop through currently rendered accessories, checking against the checked accessories.
      for (let j=0; j < allAccessoriesRendered.length; j++) {
        if (allAccessoriesRendered[j].getAttribute("value") == accessoryId) {
          // If the checked icon is already rendered, skip.
        }
        else {
          // check if they have enough money to add
          let tempCoins = Number($("#userTempCoins").text());
          let cost = Number(this.getAttribute("data"));

          if (tempCoins > cost) {
            console.log("buy!")
            tempCoins -= cost;
            // update UI
            $("#userTempCoins").text(tempCoins)
            // update hidden field
            $("#userCoins").val(tempCoins);
            addAccessory(imageURL, accessoryId);
          }
          else {
            // TODO: make the unchecking nicer for when the user gets enough coins.
            // TODO: make a separate function which loops through the accessories every time the tempCoin value changes and re-renders backgrounds, as well as changing click events.
            console.error("not enough coins, sorry");
            // uncheck it.
            e.preventDefault();
          }
          // break out of loop so you don't add multiples.
          renderNotEnoughCoins();
          return;
        }
      }
    }
    else {
      const uniqueId = "#accessoryRendered" + accessoryId;
      removeAccessory(uniqueId);

      // add the money back into their account
      let tempCoins = Number($("#userTempCoins").text());
      let cost = Number(this.getAttribute("data"));
      tempCoins += cost;
      // update UI
      $("#userTempCoins").text(tempCoins)
      // update hidden field
      $("#userCoins").val(tempCoins);
    }
    renderNotEnoughCoins();
  });

  function addAccessory (imageURL, accessoryId) {
    let icon = $('<img class="character_accessory">');
    icon.attr("src", imageURL);
    icon.attr("value", accessoryId);
    const uniqueId = "accessoryRendered" + accessoryId;
    icon.attr("id", uniqueId);

    icon.appendTo("#accessories_selected");
    // change the X and Y values filtering to the database every time a user stops dragging.
    icon.on("click", function () {
      let left = icon.css("left");
      let top = icon.css("top");

      left = parseInt(left, 10);
      top = parseInt(top, 10);
      console.log("left: " + left);
      console.log("top: " + top);

      const featureWidth = $(".character_feature").width();
      const featureHeight = $(".character_feature").height();
      console.log("featureWidth: " + featureWidth);
      console.log("featureHeight: " + featureHeight);

      let left2 = left / featureWidth * 100;
      let top2 = top / featureHeight * 100;
      console.log("left2: " + left2);
      console.log("top2: " + top2);

      $("#positions_" + accessoryId + "_x").val(top2);
      $("#positions_" + accessoryId + "_y").val(left2);



    });
    icon.draggable({
      // TODO: make a box to contain draggable elements
        containment: ".create_character_grid",
        scroll: false,
        stop: function () {
        var l = ( 100 * parseFloat($(this).position().left / parseFloat($(this).parent().width())) ) + "%" ;
        var t = ( 100 * parseFloat($(this).position().top / parseFloat($(this).parent().height())) ) + "%" ;
        $(this).css("left", l);
        $(this).css("top", t);
        }
    });

    // resize icon if the screen is smaller than 600px
    //resizeAcc();
  }

  // after every click, filter through all the icons to check if you have enough money for them, turning them red if you dont.
  function renderNotEnoughCoins() {
    console.log("running");
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
    console.log(uniqueId);
    $(uniqueId).remove();
  }

  function changeCoins (cost) {
    let currentCoins = $("#userTempCoins").val();
    let newCoins = currentCoins - cost;
    $("#userTempCoins").val(newCoins);
    $("#userCoins").val(newCoins);
  }


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


// RESIZING ///////////////////////////////////////////////////////////////////


  $(window).resize(resizeAcc).trigger("resize");

  function resizeAcc() {
      let wrapper = $(".character_feature");
      let accessories = $(".character_accessory");
      accessories.each(function () {
        let accessoryOriginalW = this.naturalWidth;
        let accessoryOriginalH = this.naturalHeight;

        let wrapperW = $(".character_feature").naturalWidth;
        let wrapperH = $(".character_feature").naturalHeight;
        let w = $(".character_feature").width() * (accessoryOriginalW / 600);
        let h = $(".character_feature").height() * (accessoryOriginalH / 600);

        $(this).width(w);
        $(this).height(h);
      });
    }


}); //end
