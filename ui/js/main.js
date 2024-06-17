$(function(){
    let money = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
    });

    window.addEventListener("message", function(e){
        if (e.data.action == "open") {
            $("body").fadeIn(100);
            $("#job").text(e.data.job);
            $("#wallet").text(money.format(e.data.cash));
            $("#bank").text(money.format(e.data.bank));
            $("#name").text(e.data.name);
            $("#player-pp").attr("src", e.data.avatar);
        } 
        
        if (e.data.action == "close") {
            $("body").fadeOut(100);
        }
    });

    function updateClock() {
        var currentTime = new Date();
        var currentHours = currentTime.getHours();
        var currentMinutes = currentTime.getMinutes();
        var currentSeconds = currentTime.getSeconds();
        var currentDay = currentTime.getDate();
        var currentMonth = currentTime.getMonth() + 1;
        var currentYear = currentTime.getFullYear();

        currentMinutes = (currentMinutes < 10 ? "0" : "") + currentMinutes;
        currentSeconds = (currentSeconds < 10 ? "0" : "") + currentSeconds;

        var timeOfDay = (currentHours < 12) ? "AM" : "PM";
        
        currentHours = (currentHours > 12) ? currentHours - 12 : currentHours;
        currentHours = (currentHours == 0) ? 12 : currentHours;

        var currentTimeString = currentHours + ":" + currentMinutes + " " + timeOfDay;
        var currentDateString = currentDay + "/" + currentMonth + "/" + currentYear;

        $(".clock").html(currentTimeString);
        $(".date").html(currentDateString);
    }

    setInterval(() => {
        updateClock();
    }, 1000);

    $('.box-s').mousemove(function(e){
        var offset = $(this).offset();
        var relX = e.pageX - offset.left;
        var relY = e.pageY - offset.top;
        var offsetMinX = $(this).width();
        var offsetMinY = $(this).height();
        var currentX = relX+=offsetMinX * -0.5;
        var currentY = relY+=offsetMinY * -0.5;
        var newX = currentX/700000;
        var newY = currentY/1000000;
        $(this).css('transform',"matrix3d(1.025,0,0,"+-newX+",0,1.025,0,"+-newY+",0,0,1,0,0,0,0,1)");
    });
    
    $('.box-m').mousemove(function(e){
        var offset = $(this).offset();
        var relX = e.pageX - offset.left;
        var relY = e.pageY - offset.top;
        var offsetMinX = $(this).width();
        var offsetMinY = $(this).height();
        var currentX = relX+=offsetMinX * -0.5;
        var currentY = relY+=offsetMinY * -0.5;
        var newX = currentX/5000000;
        var newY = currentY/1000000;
        $(this).css('transform',"matrix3d(1.025,0,0,"+-newX+",0,1.025,0,"+-newY+",0,0,1,0,0,0,0,1)");
    });
    
    $('.box-l').mousemove(function(e){
        var offset = $(this).offset();
        var relX = e.pageX - offset.left;
        var relY = e.pageY - offset.top;
        var offsetMinX = $(this).width();
        var offsetMinY = $(this).height();
        var currentX = relX+=offsetMinX * -0.5;
        var currentY = relY+=offsetMinY * -0.5;
        var newX = currentX/50000000;
        var newY = currentY/5000000;
        $(this).css('transform',"matrix3d(1.025,0,0,"+-newX+",0,1.025,0,"+-newY+",0,0,1,0,0,0,0,1)");
    });
    
    $(".container .box").mouseout(function(){         
      $(this).css('transform',"matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)");
    });
})

function btnClick(e){
    $.post(`https://${GetParentResourceName()}/action`, JSON.stringify(e));
}

$(window).on("keydown", function ({ originalEvent: { key } }) {
	if (key == "Escape") {
        $.post(`https://${GetParentResourceName()}/action`);
	}
})