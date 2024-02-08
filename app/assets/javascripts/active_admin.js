//= require arctic_admin/base
//= require activeadmin_addons/all

//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input
//= require activeadmin/quill.imageUploader.min
//= require jquery
//= require jquery.minicolors

jQuery( function($) {
    $(".colorpicker").minicolors()
});

$(document).ready(function(){
    $('.blog-div').hide();
    if (($('#bx_block_stories_story_story_type').val() != undefined) && ($('#bx_block_stories_story_story_type').val() == "blog")) {
        $('.blog-div').show();
    }
    $('#bx_block_stories_story_story_type').change(function (){
        if ($(this).val() == "blog"){
            $('.blog-div').show();
        }
        else{
            $('.blog-div').hide();
        }
    })
})

$(document).ready(function(){
    $('#bx_block_discountsoffers_offer_coupon_type').change(function (){
        if ($(this).val() == "referral"){
            $('.referral1-div').hide(); 
            $('.referral2-div').hide();
            $('.referral3-div').hide();
            $('.specfic_user-div').hide();
        }
        else if ($(this).val() == "specfic_user"){
            $('.referral1-div').show();
            $('.referral2-div').hide();
            $('.referral3-div').show();
            $('.specfic_user-div').show();
        }
        else if ($(this).val() == "share_order_code"){
            $('.referral1-div').show();
            $('.referral2-div').show();
            $('.referral3-div').show();
            $('.specfic_user-div').hide();
        }
        else if ($(this).val() == "normal"){
            $('.referral1-div').show();
            $('.referral2-div').show();
            $('.referral3-div').show();
            $('.specfic_user-div').hide();
        }
        else{
            $('.referral-div').show();
        }
    })

    $('#bx_block_discountsoffers_offer_discount_type').change(function (){
        if ($(this).val() == "percentage"){
            $('.cap-div').show(); 
        }
        else{
            $('.cap-div').hide();
        }
    })

     $('#custom_email_email_type').change(function (){
        if ($(this).val() == "activation_email"){
            debugger
            $('.type-div').hide(); 
          }
        else if ($(this).val() == "order_placed_info"){
            $('.type-div').hide();
        }
        else{
            $('.type-div').show();
        }
    })

    $('#bx_block_discountsoffers_offer_combine_with_other_offer').change(function (){
        if ($(this).val() == 'inactive'){
            $('.discount-div').hide(); 
        }
        else{
            $('.discount-div').show();
        }
    })
})

