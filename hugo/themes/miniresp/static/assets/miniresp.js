$(document).on("scroll",function(){
    if($(document).scrollTop() > 100){
        $("header").removeClass("header-large").addClass("header-small");
    } else{
        $("header").removeClass("header-small").addClass("header-large");
    }
});

