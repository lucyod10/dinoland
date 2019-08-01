$(document).ready(() => {



  $(window).resize(function () {
    const wrapper = $(".character_feature");
    const accessories = $(".character_accessory");

    console.log("resized");
    let w = $(".character_feature").width() * (1/3);
    let h = $(".character_feature").height() * (1/3);
    accessories.each(function () {
      $(this).width(w);
      $(this).width(h);
    });

  }).trigger("resize");




});
