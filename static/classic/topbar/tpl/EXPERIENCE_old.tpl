<style>
input::-webkit-outer-spin-button, /* Removes arrows */
input::-webkit-inner-spin-button, /* Removes arrows */
input::-webkit-clear-button { /* Removes blue cross */
  -webkit-appearance: none;
  margin: 0;
}

.editform{
  box-shadow: rgba(0, 0, 0, 0.137255) 0px 2px 2px 0px, rgba(0, 0, 0, 0.2) 0px 3px 1px -2px, rgba(0, 0, 0, 0.117647) 0px 1px 5px 0px;
  border-radius: 5px 5px 5px 5px;
}

.editform-header{
  padding: 10px;border-radius: 5px 5px 0 0;margin-top:-10px;margin-left:-10px;margin-right:-10px;background: #F1F4F5;
}

.newform-header{
  padding: 10px;border-radius: 5px 5px 0 0;background: #F1F4F5;
}

.editform-footer{
  padding: 0px;border-radius: 0 0 5px 5px;margin-bottom:-10px;margin-left:-10px;margin-right:-10px;background: #F1F4F5;
}
</style>

<script>

  
  refresh();
  
  function refresh()
  {
    $('.navbar-text').html('Please Wait');
    $.post('/cv/getinfo',{'get':'EXPERIENCE'},function(data)
    {
      $('.navbar-text').html('');
      var obj = $.parseJSON(data);
      if(obj.resp == 0 )
      {
        $('.expform').show();
        $('.prevexp').hide();
        $('.tab-pane').css('opacity','1');
        $('.tab-pane').asScrollable('update');
        $('.cancelnewadd').hide();
      }
      else
      {
        $('.cancelnewadd').show();
        var expstr = '<span class="allowSort">';
        var id = 0;
        $.each(obj.msg, function(k,v)
        {
          expstr += '<a style="border-radius:10px;box-shadow:0 1px 1px rgba(0,0,0,0.15),-1px 0 0 rgba(0,0,0,0.03),1px 0 0 rgba(0,0,0,0.03),0 1px 0 rgba(0,0,0,0.12);    background: rgba(245, 245, 245, 0.2);" class="list-group-item margin-15" href="javascript:void(0)" id="'+v.id+id+'"  onMouseOver="toolOptionShow('+v.id+id+')" onMouseOut="toolOptionHide('+v.id+id+')">'+
                '<div class="media">'+
                  '<div class="media-left" style="padding-right:0px;">'+
                    '<div class="avatar drag-handle margin-right-15" style="width:15px;">'+
                      '<img src="https://lh3.googleusercontent.com/-R2RhurLgYNY/Vy2hoYXFqqI/AAAAAAAAB1U/mWrX0vaZRToOHzgxYJqTQRQ9TkwBz-mCACL0B/w15-h32-no/rsz_drag_icon.png" width="20px" alt="...">'+
                    '</div>'+
                  '</div>'+
                  '<div class="media-left" style="padding-right:10px;">'+
                    '<div class="avatar avatar-sm" style="width:35px;">'+
                      '<img src="https://lh4.googleusercontent.com/-OxH7OiDDPfo/AAAAAAAAAAI/AAAAAAAAAAA/AMW9IgcmL7y4ihwR1nqUhCncAI0_gQ8ilQ/s64-c-mo/photo.jpg" alt="...">'+
                    '</div>'+
                  '</div>'+
                  '<div class="media-body" data-1="'+v.id+'" data-2="'+v.section_title1+'" data-3="'+v.section_title2+'" data-4="'+v.section_name+'" data-5="'+v.start_date+'" data-6="'+v.end_date+'" data-7="'+v.more_info1+'" data-8="'+v.section_title3+'" data-rowcount="'+k+'">'+
                    '<h4 class="media-heading">'+v.section_title2+'</h4>'+
                    '<small>'+v.section_title1+'</small>'+
                  '</div>'+
                  '<div class="media-right" style="display:none;">';
          if(v.is_active == 1)
          {
            expstr += '<i class="icon wb-eye visibility-exp"'+ 'data-id="'+v.id+'"'+ 'data-show="'+v.is_active+'"' + 'style="font-size:10px;color: #76838f;"></i>';
          }else{
            expstr += '<i class="icon wb-eye-close visibility-exp"'+ 'data-id="'+v.id+'"'+ 'data-show="'+v.is_active+'"' + 'style="font-size:10px;color: #76838f;"></i>';
          }
          expstr += '<i class="icon wb-close delete-exp"'+ 'data-id="'+v.id+'"' + 'style="font-size:10px;color: #DE5C5C;"></i>'+
                  '</div><span class="control-open pull-right fa fa-angle-down"></span>'+
                '</div>'+
              '</a><span class="edit-'+v.id+'"></span>';
              id++;
        });
        expstr += '</span>';
        expstr += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block addnewExpBtn margin-top-30 margin-bottom-70"><i class="icon wb-plus"></i>&nbsp;Add Experience</button>';
        $('.prevexp').html(expstr);
        $('.prevexp').show();
        $('.expform').hide();
        $('.tab-pane').css('opacity','1');
        $( ".allowSort" ).sortable({
          axis: "y",
          cursor: "move",
          opacity: 0.65,
          cancel: ".editform",
          handle: '.drag-handle',
          update: function(event, ui) {
            var productOrder = $(this).sortable('toArray').toString();
            var param = {};
            param.section_type = 'ORDER';
            param.data = productOrder;
            $('.navbar-text').html('Saving');
            $.post('/cv/fillinfo',{'param':param},function(data)
            {
              $('.navbar-text').html('All changes saved');
              refresh();
              buildresume();
            });
          },
          forcePlaceholderSize:true
        });
        $select = $('');
        $('.addnewExpBtn').on('click', function()
        {
          $select.slideDown();
          $('.addnewExpBtn').hide();
          $('.editform').slideUp();
          $('.expform').slideDown('fast', function()
          {
            $('.tab-pane').asScrollable('update');
          });
        });
        $('div.media-body').on('click', function(e)
        {
          
          $select.slideDown();
          if($('.editform').is(':visible'))
          {
            
            $('.editform').slideUp('fast', function()
            {
              $('.addnewExpBtn').slideDown();
              $('.tab-pane').asScrollable('update');
              
            });
          }
          else
          {
            
            $select = $(this).closest('.list-group-item').hide();
            
            //$(this).closest('.list-group-item')[0].remove();
            
            // lines removed :<i class="icon wb-close pull-right canceledit" style="cursor:pointer;color:#DE5F5F;margin-right: 8px;"></i>  and <div class="form-group form-material row "><button type="button" class="btn btn-sm btn-outline btn-primary width-250 font-weight-500 center-block update margin-bottom-20">SAVE</button> </div>
            $('.edit-'+$(this).data('1')).html('<form class="editform margin-20 padding-10" style="display:none;"> <div class="editform-header"> <span class="new-heading pull-right margin-top-20">EDIT EXPERIENCE</span><div class="avatar avatar-sm" style="width:35px;"><img src="https://lh4.googleusercontent.com/-OxH7OiDDPfo/AAAAAAAAAAI/AAAAAAAAAAA/AMW9IgcmL7y4ihwR1nqUhCncAI0_gQ8ilQ/s64-c-mo/photo.jpg" alt="..."></div> </div><span class="eid" style="display:none;"></span> <span id="rowcount" style="display:none;"></span> <div class="form-group form-material floating" style="    margin-top: 30px;"> <input type="text" class="form-control ecome"/> <label class="floating-label">Company Name</label> </div><div class="form-group form-material floating"> <input type="text" class="form-control eloon"/> <label class="floating-label">Location</label> </div><div class="form-group form-material floating"> <input type="text" class="form-control ejole"/> <label class="floating-label">Job Title</label> </div><div class="row"> <div class="col-sm-5"> <div class="form-group form-material floating"> <select class="form-control estmn"> </select> <label class="floating-label">Start Date</label> </div></div><div class="col-sm-3"> <div class="form-group form-material floating"> <select class="form-control estyr"> <option value="">Year</option> </select> </div></div></div><div class="row"> <div class="col-sm-5"> <div class="form-group form-material floating"> <select class="form-control eenmn"> </select> <label class="floating-label">End Date</label> </div></div><div class="col-sm-3"> <div class="form-group form-material floating"> <select class="form-control eenyr"> </select> </div></div><div class="col-sm-4"> <div class="form-group form-material floating"> <input type="checkbox" class="eprnt"/> Present </div></div></div><div class="form-group form-material floating"> <textarea class="form-control edeon" rows="3" ></textarea> <label class="floating-label">Description</label> </div><div class="text-center editform-footer"><i class="fa fa-angle-up"></i></div> </form>');
            
            $(".styr,.enyr,.estyr,.eenyr").html(optyear);
            
            $(".stmn,.enmn,.estmn,.eenmn").html('<option value="&nbsp;">Month</option><option value="Jan">January</option><option value="Feb">February</option><option value="Mar">March</option><option value="Apr">April</option><option value="May">May</option><option value="Jun">June</option><option value="Jul">July</option><option value="Aug">August</option><option value="Sept">September</option><option value="Oct">October</option><option value="Nov">November</option><option value="Dec">December</option>');
            
            $(".ejole").val($(this).data('2'));
            $(".ecome").val($(this).data('3'));
            $(".eloon").val($(this).data('8'));
            var res = $(this).data('5').split(' ');
            $(".estmn").val($.trim(res[0]));
            $(".estyr").val($.trim(res[1]));
            res = $(this).data('6').split(' ');
            if(res[0] == 'Present')
            {
              $(".eenmn").prop('disabled', true);
              $(".eenyr").prop('disabled', true);
              $(".eprnt").prop('checked', true);
            }
            else
            {
              $(".eenmn").val($.trim(res[0]));
              $(".eenyr").val($.trim(res[1]));
            }
            $(".edeon").html($(this).data('7').replace(/<br\s*[\/]?>/gi, "\n"));
            $(".eid").html($(this).data('1'));
            $("#rowcount").html($(this).data('rowcount'));
            // $('.addnewExpBtn').hide();
            $('.expform').hide();
            $('.addnewExpBtn').slideDown();
            $('.edit-'+$(this).data('1')+' .editform').slideDown('slow', function() {
              $('.tab-pane').asScrollable('update');
            });
            
            $('.eprnt').on("change", function()  {
              if($(".eprnt").prop('checked') == true)
                {
                  $(".eenmn").val('');
                  $(".eenyr").val('');
                  $(".eenmn").prop('disabled', true);
                  $(".eenyr").prop('disabled', true);
                }
                else
                {
                  $(".eenmn").prop('disabled', false);
                  $(".eenyr").prop('disabled', false);
                }
            });
            
            
            $('.update').on('click', function()
            {
              doneTyping();
              clearTimeout(typingTimer);
            });
            
            $('.editform-header,.editform-footer').on('click', function()
            {
              doneTyping();
              $('.editform').slideUp();
              refresh();
              $select.slideDown();
            });
            
            $('input,textarea,select').on('change', function () {
              $('.navbar-text').html('');
            });
            
            $('.ejole').on("keyup", function()  {
              $('[data-for="EXP-'+$('#rowcount').html()+'"] .F1').html($('.ejole').val());
            });
            
            $('.eloon').on("keyup", function()  {
              $('[data-for="EXP-'+$('#rowcount').html()+'"] .F2').html($('.eloon').val());
            });
            
            $('.ecome').on("keyup", function()  {
              $('[data-for="EXP-'+$('#rowcount').html()+'"] .F3').html($('.ecome').val().toUpperCase());
            });
            
            
            $('.edeon').on("keyup", function()  {
              $('[data-for="EXP-'+$('#rowcount').html()+'"] .F5').html($('.edeon').val().replace(/\n/g, "<br />"));
            });
          }
        });
        $("i.delete-exp").on('click', function(e)
        {
            var param = {};
            var updid = $(this).data('id');
            param.section_type = 'EXPERIENCEDEL';
            param.id = updid;
            flag = 0;
            $(this).html('<i class="fa fa-pulse fa-spinner"></i>');
            $.post('/cv/fillinfo',{'param':param},function(data)
            {
              $('.expform').trigger('reset');
              refresh();
              $(this).html('');
              flag = 1;
              buildresume();
            });
          });
        }
        // $("i.visibility-exp").on('click', function(e)
        // {
        //   var param = {};
        //   param.section_type = 'VISIBILITY';
        //   param.id = $(this).data('id');
        //   param.is_active = $(this).data('show');
        //   flag = 0;
        //   $(this).html('<i class="fa fa-pulse fa-spinner"></i>');
        //   $.post('/cv/fillinfo',{'param':param},function(data)
        //   {
        //     refresh();
        //     flag = 1;
        //     buildresume();
        //   });
        // });
      $('.editform').hide();
      $('.tab-pane').asScrollable('update');
      
      $('input,textarea').on('change', function () {
        $('.navbar-text').html('Saving...');
      });
    });
  }
  var flag = 1;
  
  //on change, start the countdown
  $('input,textarea').on('change', function () {
    $('.navbar-text').html('Saving...');
  });
  
  $('.expform .addbullet').on('click', function () {
    $(".deon").val($(".deon").val() + ' \n • ');
  });
  
  
  $('.refresh').on('click', function()
  {
    if(flag)
    {
      flag = 0;
      var param = {};
      param.section_type = 'EXPERIENCE';
      param.section_title1 = $(".jole").val();
      param.section_title2 = $(".come").val();
      param.section_title3 = $(".loon").val();
      param.start_date = $(".stmn").val()+' '+$(".styr").val();
      if($('.prnt').is(":checked"))
      {
        param.end_date = 'Present';
      }
      else
      {
        param.end_date = $(".enmn").val()+' '+$(".enyr").val();
      }
      
      param.more_info1 = $(".deon").val().replace(/\n/g, "<br />");
      $('.refresh').html('<i class="fa fa-pulse fa-spinner"></i>');
      $.post('/cv/fillinfo',{'param':param},function(data)
      {
        $('.expform').trigger('reset');
        refresh();
        $('.navbar-text').html('All changes saved.');
        $('.refresh').html('SAVE');
        flag = 1;
        buildresume();
      });
    }
  });
  
  //setup before functions
 /* var typingTimer;                //timer identifier
  var doneTypingInterval = 2000;  //time in ms, 2 second for example
  var $input = $('.editform input');
  
  //on change, start the countdown
  $input.on('change', function () {
    $('.update').html('SAVE');
    clearTimeout(typingTimer);
    typingTimer = setTimeout(doneTyping, doneTypingInterval);
  });
  
  //on keydown, clear the countdown 
  $input.on('keydown', function () {
    clearTimeout(typingTimer);
  });

*/
  $('.update').on('click', function()
  {
    doneTyping();
    clearTimeout(typingTimer);
  });
  
  function doneTyping()
  {
    
    $('.update').html('<i class="fa fa-pulse fa-spinner"></i> &nbsp; SAVING');
    flag = 0;
    var param = {};
    param.id = $(".eid").html();
    param.section_type = 'EXPERIENCEUPD';
    param.section_title1 = $(".ejole").val();
    param.section_title2 = $(".ecome").val();
    param.section_title3 = $(".eloon").val();
    param.start_date = $(".estmn").val()+' '+$(".estyr").val();
    if($('.eprnt').prop("checked") == true)
    {
      param.end_date = 'Present';
    }
    else
    {
      param.end_date = $(".eenmn").val()+' '+$(".eenyr").val();
    }
    param.more_info1 = $(".edeon").val().replace(/\n/g, "<br />");
    
    $.post('/cv/fillinfo',{'param':param},function(data)
    {
      $('.navbar-text').html('All changes saved.');
      flag = 1;
      $('.update').html('SAVE');
      buildresume();
    });
  }
  
  $('.prnt').on("change", function()  {
    if($('.prnt').is(":checked"))
      {
        $(".enmn").val('');
        $(".enyr").val('');
        $(".enmn").prop('disabled', true);
        $(".enyr").prop('disabled', true);
      }
      else
      {
        $(".enmn").prop('disabled', false);
        $(".enyr").prop('disabled', false);
      }
  });
  
  $('.cancelnewadd').on("click", function()  {
    $('.expform').slideUp('', function()
    {
      $('.addnewExpBtn').slideDown();
    });
    $('.tab-pane').asScrollable('update');
  });
  
  var optyear = '<option value="&nbsp;">Year</option>';
  for (i = 1995; i <= new Date().getFullYear(); i++) { 
      optyear += '<option value="'+i+'">'+i+'</option>';
  }
  
  $(".styr,.enyr,.estyr,.eenyr").html(optyear);
  
  $(".stmn,.enmn,.estmn,.eenmn").html('<option value="&nbsp;">Month</option><option value="Jan">January</option><option value="Feb">February</option><option value="Mar">March</option><option value="Apr">April</option><option value="May">May</option><option value="Jun">June</option><option value="Jul">July</option><option value="Aug">August</option><option value="Sept">September</option><option value="Oct">October</option><option value="Nov">November</option><option value="Dec">December</option>');
  
  function toolOptionShow(o) {
      $('#'+o+' .media-right').show();
  }
  
  function toolOptionHide(o) {
      $('#'+o+' .media-right').hide();
  }
  
  


</script>
<!-- nav-tabs -->
<ul class="site-sidebar-nav nav nav-tabs nav-justified nav-tabs-line" role="tablist">
  <li style="cursor:pointer;" role="Presentation">
    <a>
      &nbsp;&nbsp;&nbsp;&nbsp;
      
<img width="30px" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/sections.tpl" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAATCAYAAACUef2IAAAABGdBTUEAALGOfPtRkwAAACBjSFJNAACHDwAAjA8AAP1SAACBQAAAfXkAAOmLAAA85QAAGcxzPIV3AAAKOWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAEjHnZZ3VFTXFofPvXd6oc0wAlKG3rvAANJ7k15FYZgZYCgDDjM0sSGiAhFFRJoiSFDEgNFQJFZEsRAUVLAHJAgoMRhFVCxvRtaLrqy89/Ly++Osb+2z97n77L3PWhcAkqcvl5cGSwGQyhPwgzyc6RGRUXTsAIABHmCAKQBMVka6X7B7CBDJy82FniFyAl8EAfB6WLwCcNPQM4BOB/+fpFnpfIHomAARm7M5GSwRF4g4JUuQLrbPipgalyxmGCVmvihBEcuJOWGRDT77LLKjmNmpPLaIxTmns1PZYu4V8bZMIUfEiK+ICzO5nCwR3xKxRoowlSviN+LYVA4zAwAUSWwXcFiJIjYRMYkfEuQi4uUA4EgJX3HcVyzgZAvEl3JJS8/hcxMSBXQdli7d1NqaQffkZKVwBALDACYrmcln013SUtOZvBwAFu/8WTLi2tJFRbY0tba0NDQzMv2qUP91829K3NtFehn4uWcQrf+L7a/80hoAYMyJarPziy2uCoDOLQDI3fti0zgAgKSobx3Xv7oPTTwviQJBuo2xcVZWlhGXwzISF/QP/U+Hv6GvvmckPu6P8tBdOfFMYYqALq4bKy0lTcinZ6QzWRy64Z+H+B8H/nUeBkGceA6fwxNFhImmjMtLELWbx+YKuGk8Opf3n5r4D8P+pMW5FonS+BFQY4yA1HUqQH7tBygKESDR+8Vd/6NvvvgwIH554SqTi3P/7zf9Z8Gl4iWDm/A5ziUohM4S8jMX98TPEqABAUgCKpAHykAd6ABDYAasgC1wBG7AG/iDEBAJVgMWSASpgA+yQB7YBApBMdgJ9oBqUAcaQTNoBcdBJzgFzoNL4Bq4AW6D+2AUTIBnYBa8BgsQBGEhMkSB5CEVSBPSh8wgBmQPuUG+UBAUCcVCCRAPEkJ50GaoGCqDqqF6qBn6HjoJnYeuQIPQXWgMmoZ+h97BCEyCqbASrAUbwwzYCfaBQ+BVcAK8Bs6FC+AdcCXcAB+FO+Dz8DX4NjwKP4PnEIAQERqiihgiDMQF8UeikHiEj6xHipAKpAFpRbqRPuQmMorMIG9RGBQFRUcZomxRnqhQFAu1BrUeVYKqRh1GdaB6UTdRY6hZ1Ec0Ga2I1kfboL3QEegEdBa6EF2BbkK3oy+ib6Mn0K8xGAwNo42xwnhiIjFJmLWYEsw+TBvmHGYQM46Zw2Kx8lh9rB3WH8vECrCF2CrsUexZ7BB2AvsGR8Sp4Mxw7rgoHA+Xj6vAHcGdwQ3hJnELeCm8Jt4G749n43PwpfhGfDf+On4Cv0CQJmgT7AghhCTCJkIloZVwkfCA8JJIJKoRrYmBRC5xI7GSeIx4mThGfEuSIemRXEjRJCFpB+kQ6RzpLuklmUzWIjuSo8gC8g5yM/kC+RH5jQRFwkjCS4ItsUGiRqJDYkjiuSReUlPSSXK1ZK5kheQJyeuSM1J4KS0pFymm1HqpGqmTUiNSc9IUaVNpf+lU6RLpI9JXpKdksDJaMm4ybJkCmYMyF2TGKQhFneJCYVE2UxopFykTVAxVm+pFTaIWU7+jDlBnZWVkl8mGyWbL1sielh2lITQtmhcthVZKO04bpr1borTEaQlnyfYlrUuGlszLLZVzlOPIFcm1yd2WeydPl3eTT5bfJd8p/1ABpaCnEKiQpbBf4aLCzFLqUtulrKVFS48vvacIK+opBimuVTyo2K84p6Ss5KGUrlSldEFpRpmm7KicpFyufEZ5WoWiYq/CVSlXOavylC5Ld6Kn0CvpvfRZVUVVT1Whar3qgOqCmrZaqFq+WpvaQ3WCOkM9Xr1cvUd9VkNFw08jT6NF454mXpOhmai5V7NPc15LWytca6tWp9aUtpy2l3audov2Ax2yjoPOGp0GnVu6GF2GbrLuPt0berCehV6iXo3edX1Y31Kfq79Pf9AAbWBtwDNoMBgxJBk6GWYathiOGdGMfI3yjTqNnhtrGEcZ7zLuM/5oYmGSYtJoct9UxtTbNN+02/R3Mz0zllmN2S1zsrm7+QbzLvMXy/SXcZbtX3bHgmLhZ7HVosfig6WVJd+y1XLaSsMq1qrWaoRBZQQwShiXrdHWztYbrE9Zv7WxtBHYHLf5zdbQNtn2iO3Ucu3lnOWNy8ft1OyYdvV2o/Z0+1j7A/ajDqoOTIcGh8eO6o5sxybHSSddpySno07PnU2c+c7tzvMuNi7rXM65Iq4erkWuA24ybqFu1W6P3NXcE9xb3Gc9LDzWepzzRHv6eO7yHPFS8mJ5NXvNelt5r/Pu9SH5BPtU+zz21fPl+3b7wX7efrv9HqzQXMFb0ekP/L38d/s/DNAOWBPwYyAmMCCwJvBJkGlQXlBfMCU4JvhI8OsQ55DSkPuhOqHC0J4wybDosOaw+XDX8LLw0QjjiHUR1yIVIrmRXVHYqLCopqi5lW4r96yciLaILoweXqW9KnvVldUKq1NWn46RjGHGnIhFx4bHHol9z/RnNjDn4rziauNmWS6svaxnbEd2OXuaY8cp40zG28WXxU8l2CXsTphOdEisSJzhunCruS+SPJPqkuaT/ZMPJX9KCU9pS8Wlxqae5Mnwknm9acpp2WmD6frphemja2zW7Fkzy/fhN2VAGasyugRU0c9Uv1BHuEU4lmmfWZP5Jiss60S2dDYvuz9HL2d7zmSue+63a1FrWWt78lTzNuWNrXNaV78eWh+3vmeD+oaCDRMbPTYe3kTYlLzpp3yT/LL8V5vDN3cXKBVsLBjf4rGlpVCikF84stV2a9021DbutoHt5turtn8sYhddLTYprih+X8IqufqN6TeV33zaEb9joNSydP9OzE7ezuFdDrsOl0mX5ZaN7/bb3VFOLy8qf7UnZs+VimUVdXsJe4V7Ryt9K7uqNKp2Vr2vTqy+XeNc01arWLu9dn4fe9/Qfsf9rXVKdcV17w5wD9yp96jvaNBqqDiIOZh58EljWGPft4xvm5sUmoqbPhziHRo9HHS4t9mqufmI4pHSFrhF2DJ9NProje9cv+tqNWytb6O1FR8Dx4THnn4f+/3wcZ/jPScYJ1p/0Pyhtp3SXtQBdeR0zHYmdo52RXYNnvQ+2dNt293+o9GPh06pnqo5LXu69AzhTMGZT2dzz86dSz83cz7h/HhPTM/9CxEXbvUG9g5c9Ll4+ZL7pQt9Tn1nL9tdPnXF5srJq4yrndcsr3X0W/S3/2TxU/uA5UDHdavrXTesb3QPLh88M+QwdP6m681Lt7xuXbu94vbgcOjwnZHokdE77DtTd1PuvriXeW/h/sYH6AdFD6UeVjxSfNTws+7PbaOWo6fHXMf6Hwc/vj/OGn/2S8Yv7ycKnpCfVEyqTDZPmU2dmnafvvF05dOJZ+nPFmYKf5X+tfa5zvMffnP8rX82YnbiBf/Fp99LXsq/PPRq2aueuYC5R69TXy/MF72Rf3P4LeNt37vwd5MLWe+x7ys/6H7o/ujz8cGn1E+f/gUDmPP8usTo0wAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAF5JREFUOE9j/A8EDDQATFCa6gDu4ri4OLAApWDRokVgmmYupn1QYAP44pWRkRHKwg5GU8VwSRUwJnKM//v3j2AKAAF0NaOpYriWFSAAkkaPcWQtIDkYH1kdjVIFAwMAq/1C9dlEHO8AAAAASUVORK5CYII=">&nbsp;&nbsp;
    </a>
  </li>
  <li role="Presentation">
    <a>
      <i class="icon wb-chevron-left" title="Previous Section" style="cursor:pointer;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/ABOUT_YOU.tpl"></i>
      <span style="font-weight:500;color:#66AAEA;border-bottom: 2px solid #62a8ea;">EXPERIENCE</span>
    </a>
  </li>
  <li style="cursor:pointer;font-weight:400;" role="Presentation">
    <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl">EDUCATION
    </a>
  </li>
  <li style="cursor:pointer;" role="Presentation" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl">
    <a >
      <span style="font-weight:400;background: -webkit-linear-gradient(left,#76838F, #fff);-webkit-background-clip: text;-webkit-text-fill-color: transparent;">SK</span>&nbsp;
      <i class="icon wb-chevron-right" title="Next Section" style="color:#66AAEA" aria-hidden="true"></i>
    </a>
  </li>
</ul>

<div class="site-sidebar-tab-content tab-content">
  
  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">
    
    <div class="">

      <div class="">
        <span class="slidePanel-desc">Your professional work details</span>
        <br><br>
        <div class="list-group prevexp">
        </div>
        
        <form class='expform' style="margin-right: -10px; margin-left: -10px;">
          <div class="newform-header" style="padding: 15px;">
            <span class="new-heading pull-right" style=" margin-top: -10px; line-height: 25px; text-align: right;">
              <i class="icon wb-eye visibility-exp" data-id="" data-show="1" style="margin-right: 7px;font-size:10px;color: #76838f;"></i>
              <i class="icon wb-close " data-id="" style="font-size:10px;color: #DE5C5C;"></i><br>ADD EXPERIENCE
            </span>
            <div class="avatar avatar-sm" style="width:35px;">
              <img src="https://lh4.googleusercontent.com/-OxH7OiDDPfo/AAAAAAAAAAI/AAAAAAAAAAA/AMW9IgcmL7y4ihwR1nqUhCncAI0_gQ8ilQ/s64-c-mo/photo.jpg" alt="...">
            </div>
          </div>
          <!--<span class="new-heading">ADD EXPERIENCE</span><i class="icon wb-close pull-right cancelnewadd" style="cursor:pointer;color:#DE5F5F;margin-right: 8px;"></i>-->
          <div class="form-group form-material floating">
            <input type="text" class="form-control empty come" />
            <label class="floating-label">Company Name</label>
          </div>
          
          <div class="form-group form-material floating">
            <input type="text" class="form-control empty loon" />
            <label class="floating-label">Location</label>
          </div>

          <div class="form-group form-material floating">
            <input type="text" class="form-control empty jole" />
            <label class="floating-label">Job Title</label>
          </div>
          
          <div class="row">
            <div class="col-sm-5">
              <div class="form-group form-material floating">
                <select class="form-control stmn">
                </select>
                <label class="floating-label">Start Date</label>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group form-material floating">
                <select class="form-control styr">
                  <option value="">Year</option>
                </select>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-5">
              <div class="form-group form-material floating">
                <select class="form-control enmn">
                </select>
                <label class="floating-label">End Date</label>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group form-material floating">
                <select class="form-control enyr">
                  <option value="">Year</option>
                </select>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group form-material floating">
                <input type="checkbox" class="prnt" /> Present
              </div>
            </div>
          </div>
          
          <div class="form-group form-material floating">
            <button type="button" class="btn btn-sm btn-icon btn-link pull-right addbullet" title="clcik to add bullet" style="margin-top: -20px;"><i class="fa fa-list-ul" aria-hidden="true"></i></button>
            <textarea class="form-control deon " rows="3" ></textarea>
            <label class="floating-label">Description</label>
          </div>
          
          <div class="row ">
              <button type="button" class="btn btn-sm btn-outline btn-primary refresh width-250 font-weight-500 center-block margin-bottom-50">SAVE</button>
          </div>
          
        </form>
        
      </div>
    </div>
    
  </div>
  
</div>