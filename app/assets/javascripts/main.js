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
});
