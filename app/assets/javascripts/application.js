// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require masonry/jquery.masonry
//= require bootstrap-sprockets
//= require_tree .

//Loading icon ALL pages


$(window).load(function() {                             
        $('#rooms').masonry({
            itemSelector: '.box',
            isAnimated: true,
        });


});


$(document).ready(function() {

    //Menu left minimize and extend
    $('#menu_small').hide();

    $('.menu_hide_btn').click(function() {
        $('#menu_big').hide(300);
        $('#menu_small').show(300);
        $('#container2').attr('id', 'container3');
        $('.p_user_friend').addClass('p_friend_height');
        $('.int_game_div').addClass('int_game_height');
        $('#rooms').masonry({
            itemSelector: '.box',
            isAnimated: true,
        });
    });

    $('.menu_show_btn').click(function() {
        $('#menu_big').show(300);
        $('#menu_small').hide(300);
        $('#container3').attr('id', 'container2');
        $('.p_user_friend').removeClass('p_friend_height');
        $('.int_game_div').removeClass('int_game_height');

        setTimeout(function() {
        	$('#rooms').masonry({
	            itemSelector: '.box',
	            isAnimated: true,
        	});
       	}, 100);
    });



    //Small login dropdown menu
    $('#small_login_drop').hide();

    $('#nav_login_btn').click(function() {
        $('#small_login_drop').toggle(50);
    });
    $(document).mouseup(function (e){

    var container = $("#small_login_drop");
    var container2 = $("#nav_login_btn");

    if (!container.is(e.target) && !container2.is(e.target) && container.has(e.target).length === 0 && container2.has(e.target).length === 0){
        container.hide(50);
    }
});



    

    //User menu dropdown
    $('#user_dropdown').hide();

    $('#toggleuser').click(function() {
        $('#user_dropdown').slideToggle(200);
    });

    $(document).mouseup(function (e){

    var container = $("#user_dropdown");
    var container2 = $("#toggleuser");

    if (!container.is(e.target) && !container2.is(e.target) && container.has(e.target).length === 0 && container2.has(e.target).length === 0){
        container.hide(50);
    }
});

    //Navigation Dropdowns
    $('#notidropdown').hide();

    $('#nav_last_item').click(function() {
        $('#notidropdown').toggle(150);
    });

    $(document).mouseup(function (e){

    var container = $("#notidropdown");
    var container2 = $("#nav_last_item");

    if (!container.is(e.target) && !container2.is(e.target) && container.has(e.target).length === 0 && container2.has(e.target).length === 0){
        container.hide(150);
    }
});

    $('#chatdropdown').hide();

    $('#togglechat').click(function() {
        $('#chatdropdown').toggle(150);
    });

    $(document).mouseup(function (e){

    var container = $("#chatdropdown");
    var container2 = $("#togglechat");

    if (!container.is(e.target) && !container2.is(e.target) && container.has(e.target).length === 0 && container2.has(e.target).length === 0){
        container.hide(150);
    }
});

    $('#inbox_dropdown').hide();

    $('#toggleinbox').click(function() {
        $('#inbox_dropdown').toggle(150);
    });

    $(document).mouseup(function (e){

    var container = $("#inbox_dropdown");
    var container2 = $("#toggleinbox");

    if (!container.is(e.target) && !container2.is(e.target) && container.has(e.target).length === 0 && container2.has(e.target).length === 0){
        container.hide(150);
    }
});

// scroll funtion only scroll on mouseover
$('.chat_message_area, .dropdown_fill_area, .users_pop_area, .friendlist_area').bind('mousewheel DOMMouseScroll', function(e) {
    var scrollTo = null;

    if (e.type == 'mousewheel') {
        scrollTo = (e.originalEvent.wheelDelta * -1);
    }
    else if (e.type == 'DOMMouseScroll') {
        scrollTo = 40 * e.originalEvent.detail;
    }

    if (scrollTo) {
        e.preventDefault();
        $(this).scrollTop(scrollTo + $(this).scrollTop());
    }
});


//Chatroom Follow & Favorite buttons on click
    $(".tool_after_follow").hide();
    $(".tool_before_follow").show();

    $(".tool_after_fav").hide();
    $(".tool_before_fav").show();

    $('.fav_room_btn').click(function() {
        if($(this).attr("id") == "fav_room_btn_click") {
                $(this).attr("id", "none");
                $(".tool_after_fav").hide();
                $(".tool_before_fav").show();
                $(".tool_before_fav").attr("id", "square_btn_position");
        }
        else {
            $(this).attr("id", "fav_room_btn_click")
            $(".tool_after_fav").show();
            $(".tool_before_fav").hide();
            
        }
        
    });

    $('.follow_room_btn').click(function() {
        if($(this).attr("id") == "follow_room_btn_click") {
                $(this).attr("id", "none");
                $(".tool_after_follow").hide();
                $(".tool_before_follow").show();
                $(".tool_before_follow").attr("id", "square_btn_position");
        }
        else {
            $(this).attr("id", "follow_room_btn_click")
            $(".tool_after_follow").show();
            $(".tool_before_follow").hide();
        }
        
    });



    // INVITE TO CHAT BTN POPUP
    $(document).ready(function () {
    $('.messagepop').hide()
    });

    
    $('.invite_room_btn').on('click', function () {
        if($(this).hasClass("selected")) {
            
        }
        else {
            $('.messagepop').show(150);
            $('.invite_room_btn').addClass("selected");
        }
    });

    $('#close').on('click', function () {
        $('.messagepop').hide(150);
        $(".invite_room_btn").removeClass("selected");
        return false;
    });

    $(document).mouseup(function (e) {
        var popup = $(".messagepop");
        if (!$('.invite_room_btn').is(e.target) && !popup.is(e.target) && popup.has(e.target).length == 0) {
            popup.hide(150);
            $(".invite_room_btn").removeClass("selected");
        }
        else {

        }
    });


    // INVITE FRIEND SELECT USER
    $('.inv_friend_div').on('click', function() {
        $(this).toggleClass("friend_select");
    });

    $('.inv_deselect_all').on('click', function() {
        $(".inv_friend_div").removeClass("friend_select");
    });

    $('.inv_select_all').on('click', function() {
        $(".inv_friend_div").addClass("friend_select");
    });


    
    //THUMBS UP SCRIPT
    $('.thumbs_down').hide();
    $('.thumbs_up').on('click', function() {
        $(this).hide();
        $(this).closest("p").find('.thumbs_down').show();
        $(this).closest("p").find('.thumb_icon').animate({ fontSize: "1.2em" }, 300 );

    });
    $('.thumbs_down').on('click', function() {
        $(this).hide();
        $(this).closest("p").find('.thumbs_up').show();
        $(this).closest("p").find('.thumb_icon').css({ fontSize: "" });

    });

    $('.thumbs_up').on('click', function() {
        $(this).hide();
        $(this).closest("p").find(".thumbs_down").show();
        $(this).closest("p").find(".thumb_icon").animate({ fontSize: "1.2em" }, 300 );

    });
    $('.comment_functions_p').find('.thumbs_down').on('click', function() {
        $(this).hide();
        $(this).closest("p").find(".thumbs_up").show();
        $(this).closest("p").find(".thumb_icon").css({ fontSize: "" });

    });


    //Comments REPLY btn dropdown
    $('.reply_comm_section').hide();
    $('.reply_btn').on('click', function() {
        $(this).closest('.comm_with_reply').find(".reply_comm_section").slideToggle(200);
    });


    //Comments view dropdown 
    $('.post_comment_area').hide();
    $('.user_comment_input').hide();
    $(".comm_toggle").on('click', function() {
        $(this).closest('.broadcastwindow').find(".post_comment_area").slideToggle(200);
        $(this).closest('.broadcastwindow').find(".user_comment_input").slideToggle(200);
    });


    //Userlist users with dropdown message
    $('.user_list_msg_area').hide();
    $('.hide_msg_user').hide();
    $('.add_friend_user_list').hide();

    $('.view_tog').on('click', function() {
        $(this).toggle();
        $(this).closest('div').find('.hide_msg_user').toggle();
        $(this).closest('div').find('.add_friend_user_list').slideToggle(100);
        $(this).closest('.user_list_col').find('.user_list_msg_area').slideToggle(200);
    });

    $('.hide_msg_user').on('click', function() {
        $(this).toggle();
        $(this).closest('div').find('.view_tog').toggle();
        $(this).closest('div').find('.add_friend_user_list').slideToggle(100);
        $(this).closest('.user_list_col').find('.user_list_msg_area').slideToggle(200);
    });



    //Profile page chatrooms tabs
    $('.tabs .tabs_d a').on('click', function(e)  {
        var currentAttrValue = $(this).attr('href');
 
        $('.tabs ' + currentAttrValue).fadeIn(400).siblings().hide();
 
        $(this).parent('li').addClass('active').siblings().removeClass('active');
 
        e.preventDefault();
    });

    $('[data-toggle="tooltip"]').tooltip();


    //Chat message click and write function
    //$('#inbox_dropdown').find('.dropdown_fill_area').hide(); 

    $('.inbox_message').on('click', function() {
        var msgbefore = $(this).closest('#inbox_dropdown').find('.dropdown_fill_area')
        msgbefore.toggle( "slide" );
    });

});


//= require turbolinks
