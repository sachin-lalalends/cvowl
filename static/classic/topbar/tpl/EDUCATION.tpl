<style>

  input::-webkit-outer-spin-button,
  /* Removes arrows */
  
  input::-webkit-inner-spin-button,
  /* Removes arrows */
  
  input::-webkit-clear-button {
    /* Removes blue cross */
    -webkit-appearance: none;
    margin: 0;
  }
  
  .editform {
    box-shadow: rgba(0, 0, 0, 0.137255) 0px 2px 2px 0px, rgba(0, 0, 0, 0.2) 0px 3px 1px -2px, rgba(0, 0, 0, 0.117647) 0px 1px 5px 0px;
    border-radius: 5px 5px 5px 5px;
  }
  
  .newForm {
    box-shadow: rgba(0, 0, 0, 0.137255) 0px 2px 2px 0px, rgba(0, 0, 0, 0.2) 0px 3px 1px -2px, rgba(0, 0, 0, 0.117647) 0px 1px 5px 0px;
    border-radius: 5px 5px 5px 5px;
  }
  
  .editform-header {
    padding: 10px;
    border-radius: 5px 5px 0 0;
    margin-top: -10px;
    margin-left: -10px;
    margin-right: -10px;
    background: #F1F4F5;
  }
  
  .newForm-header {
    padding: 10px;
    border-radius: 5px 5px 0 0;
    background: #F1F4F5;
  }
  
  .editform-footer {
    padding: 0px;
    border-radius: 0 0 5px 5px;
    margin-bottom: -10px;
    margin-left: -10px;
    margin-right: -10px;
    background: #F1F4F5;
  }
  
  .newForm-footer {
    padding: 0px;
    border-radius: 0 0 5px 5px;
    margin-bottom: -10px;
    margin-left: -10px;
    margin-right: -10px;
    background: #F1F4F5;
  }
</style>


<script>
  var Data;

  function init() {
    console.log("init()");
    Data = localStorage.getItem("data");
    Data = $.parseJSON(Data);

    Data.Education.sort(function(a, b) {
      if (a == null || b == null) return 0;
      return parseFloat(a.order_prefs) - parseFloat(b.order_prefs);
    });
  }



  refresh();

  function refresh() {
    init();
    console.log("refresh()");
    $('edoen,.deon').summernote({
      height: 100
    });
    $('.newForm .note-style, .newForm .note-fontname,.newForm .note-font,.newForm .note-color, .newForm .note-table,.newForm .note-height,.newForm .note-insert, .newForm .note-view,.newForm .note-help, .newForm  .note-statusbar').remove();
    $('.newForm .note-para').addClass("pull-right");
    $('.newForm .note-para').find('button:nth-child(2)').hide();
    $('.newForm .note-toolbar, .newForm .note-editor').css("border", "0px");
    $('.newForm .note-toolbar').css("background-color", "white");
    $('.newForm .note-editor').css("border-bottom", "1px #AAAAAA solid");
    $('button[data-original-title="Paragraph"]').remove();


    var temp = '<span class="allowSort">';
    var id = 0;
    $.each(Data.Education, function(k, datav) {
      if (datav != null && datav.section_type == "EDUCATION") {
        temp += '<a style="border-radius:10px;box-shadow:0 1px 1px rgba(0,0,0,0.15),-1px 0 0 rgba(0,0,0,0.03),1px 0 0 rgba(0,0,0,0.03),0 1px 0 rgba(0,0,0,0.12);    background: rgba(245, 245, 245, 0.2);" class="list-group-item margin-15" href="javascript:void(0)" id="' + k + '"  onMouseOver="toolOptionShow(' + k + ')" onMouseOut="toolOptionHide(' + k + ')">' +
          '<div class="media">' +
          '<div class="media-left" style="padding-right:0px;">' +
          '<div class="avatar drag-handle margin-right-15" style="width:15px;">' +
          '<img src="https://lh3.googleusercontent.com/-R2RhurLgYNY/Vy2hoYXFqqI/AAAAAAAAB1U/mWrX0vaZRToOHzgxYJqTQRQ9TkwBz-mCACL0B/w15-h32-no/rsz_drag_icon.png" width="20px" alt="...">' +
          '</div>' +
          '</div>' +
          '<div class="media-left" style="padding-right:10px;">' +
          '<div class="avatar avatar-sm" style="width:35px;">' +
          '<img src="/static/classic/topbar/assets/images/chars/'+ datav.section_title1.charAt(0).toUpperCase() +'.png" alt="...">' +
          '</div>' +
          '</div>' +
          '<div class="media-body" data-1="' + k + '"  data-rowcount="' + k + '">' +
          '<h4 class="media-heading">' + datav.section_title1 + '</h4>' +
          '<p class="small">' + datav.section_title2 + '</p>' +
          '</div>' +
          '<div class="media-right" data-for="'+k+'">';
          if (datav.is_active == 1) {
            temp += '<i class="icon wb-eye visibility"' + 'data-key="' + k + '"' + 'data-status="' + datav.is_active + '"' + 'style="display:none;font-size:10px;color: #76838f;"></i>';
          }
          else {
            temp += '<i class="icon wb-eye-close visibility"' + 'data-key="' + k + '"' + 'data-status="' + datav.is_active + '"' + 'style="display:none;font-size:10px;color: #76838f;"></i>';
          }
        temp += '<i class="icon wb-close delete"' + 'data-key="' + k + '"' + 'style="display:none;font-size:10px;color: #DE5C5C;"></i>' +
          '</div>' +
          '</div>' +
          '</a><span class="edit-' + k + '"></span>';
        id++;
      }
    });
    temp += '</span>';

    temp += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block addnewBtn margin-top-20 margin-bottom-50"><i class="icon wb-plus"></i>&nbsp;Add Education</button>';


    $('.data-container').html(temp);
    $('.data-container').show();
    $('.newForm').hide();
    $('.tab-pane').css('opacity', '1');

    $(".allowSort").sortable({
      axis: "y",
      cursor: "move",
      opacity: 0.65,
      cancel: ".editform",
      handle: '.drag-handle',
      update: function(event, ui) {
        var sectionOrder = $(this).sortable('toArray');
        var orderpref = 0;
        $.each(sectionOrder, function(k, datav) {
          if (datav != "") {
            Data.Education[datav].order_prefs = orderpref;
            orderpref++;
          }
        });
        localStorage.setItem("data", JSON.stringify(Data));
        localStorage.setItem("modified_dt", Date.now());
        buildresume();
        refresh();
      },
      forcePlaceholderSize: true
    });

    $select = $('');
    

    $('.addnewBtn').on('click', function() {
      $select.slideDown();
      $('.addnewBtn').hide();
      $('.editform').slideUp();
      $('.newForm').slideDown('fast', function() {
        $('.tab-pane').asScrollable('update');
      });
    });

    $('div.media-body').on('click', function(e) {

      
      $select.slideDown();
      if ($('.editform').is(':visible')) {
        $('.editform').slideUp('fast', function() {
          $('.addnewBtn').slideDown();
          $('.tab-pane').asScrollable('update');
        });
      }
      else {

        $select = $(this).closest('.list-group-item').hide();

        
        $('.edit-' + $(this).data('1')).html('<form class="editform margin-20 padding-10" style="display:none;"> <div class="editform-header"> <span class="new-heading pull-right esetting" style=" margin-top: -10px; line-height: 25px; text-align: right;"><br>EDIT EDUCATION</span><div class="avatar avatar-sm" style="width:35px;"><img class="eimg" src="" alt="..."></div> </div><span class="eid" style="display:none;">' + $(this).data('1') + '</span><div class="form-group form-material floating" style="    margin-top: 30px;"> <input type="text" class="form-control esec1"/> <label class="floating-label">Course Name</label> </div><div class="form-group form-material floating"> <input type="text" class="form-control esec3"/> <label class="floating-label">Percentage / CGPA / Grade</label> </div><div class="form-group form-material floating"> <input type="text" class="form-control esec2"/> <label class="floating-label">Institute Name</label> </div><div class="row"> <div class="col-sm-5"> <div class="form-group form-material floating"> <select class="form-control estmn"> </select> <label class="floating-label">Start Date</label> </div></div><div class="col-sm-3"> <div class="form-group form-material floating"> <select class="form-control estyr"> <option value="">Year</option> </select> </div></div></div><div class="row"> <div class="col-sm-5"> <div class="form-group form-material floating"> <select class="form-control eenmn"> </select> <label class="floating-label">End Date</label> </div></div><div class="col-sm-3"> <div class="form-group form-material floating"> <select class="form-control eenyr"> </select> </div></div><div class="col-sm-4"> <div class="form-group form-material floating"> <input type="checkbox" class="eprnt"/> Present </div></div></div><div class="form-group form-material floating"> <textarea class="form-control edeon empty" rows="3" ></textarea> <label class="floating-label">Description</label> </div><div class="row margin-10"><div class="col-xs-6 col-sm-6"><button type="button" class="btn btn-block btn-default btn-sm editform-cancelnewadd" title="No changes will be saved" >Cancel</button></div><div class="col-xs-6 col-sm-6"><button type="button" class="btn btn-block btn-primary  btn-sm font-weight-400 editform-save" >SAVE</button></div></div><div class="text-center editform-footer"><i class="fa fa-angle-up"></i></div> </form>');

        $(".styr,.enyr,.estyr,.eenyr").html(optyear);

        $(".stmn,.enmn,.estmn,.eenmn").html('<option value="&nbsp;">Month</option><option value="Jan">January</option><option value="Feb">February</option><option value="Mar">March</option><option value="Apr">April</option><option value="May">May</option><option value="Jun">June</option><option value="Jul">July</option><option value="Aug">August</option><option value="Sept">September</option><option value="Oct">October</option><option value="Nov">November</option><option value="Dec">December</option>');

        $(".eimg").attr('src',"/static/classic/topbar/assets/images/chars/"+Data.Education[$(this).data('1')].section_title1.charAt(0).toUpperCase()+".png");
        $(".esec2").val(Data.Education[$(this).data('1')].section_title2);
        $(".esec1").val(Data.Education[$(this).data('1')].section_title1);
        $(".esec3").val(Data.Education[$(this).data('1')].section_title3);
        var res = Data.Education[$(this).data('1')].start_date.split(' ');


        $(".estmn").val($.trim(res[0]));
        $(".estyr").val($.trim(res[1]));
        res = Data.Education[$(this).data('1')].end_date.split(' ');

        if (res[0] == 'Present') {
          $(".eenmn").prop('disabled', true);
          $(".eenyr").prop('disabled', true);
          $(".eprnt").prop('checked', true);
        }
        else {
          $(".eenmn").val($.trim(res[0]));
          $(".eenyr").val($.trim(res[1]));
        }

        $(".edeon").val(Data.Education[$(this).data('1')].more_info1);
        $(".edeon").summernote();
        $('.editform .note-style, .editform .note-fontname,.editform .note-font,.editform .note-color, .editform .note-table,.editform .note-height,.editform .note-insert, .editform .note-view,.editform .note-help, .editform  .note-statusbar').remove();
        $('.editform .note-para').addClass("pull-right");
        $('.editform .note-para').find('button:nth-child(2)').hide();
        $('.editform .note-toolbar, .editform .note-editor').css("border", "0px");
        $('.editform .note-toolbar').css("background-color", "white");
        $('.editform .note-editor').css("border-bottom", "1px #AAAAAA solid");
        

        $('button[data-original-title="Paragraph"]').remove();

        $('.newForm').hide();

        $('.addnewBtn').slideDown();


        $('.edit-' + $(this).data('1') + ' .editform').slideDown('slow', function() {
          $('.tab-pane').asScrollable('update');
        });

        $('.eprnt').on("change", function() {
          if ($(".eprnt").prop('checked') == true) {
            $(".eenmn").val('');
            $(".eenyr").val('');
            $(".eenmn").prop('disabled', true);
            $(".eenyr").prop('disabled', true);
            
          }
          else {
            $(".eenmn").prop('disabled', false);
            $(".eenyr").prop('disabled', false);
            
          }
        });

        $('.editform-header,.editform-footer, .editform-save').on('click', function(e) {
          $select.slideDown();
          updateRecord($('.eid').html());
          $('.editform').slideUp();
          buildresume();
        });
        
        $('.esec1').on("input", function() {
          $('.EDU-' + $('.eid').html() + '.E1').html($('.esec1').val().toUpperCase());
        });

        $('.esec2, .esec3, .estyr, .estmn, .eenmn, .eenyr, .eprnt').on("input", function() {
          if($(".eprnt").prop('checked') == true){
            $enddate = ' - Present';
          }else{
            $enddate = ' - '+$.trim($('.eenmn').val())+' '+$.trim($('.eenyr').val());
            if($.trim($enddate) == '-' || $.trim($enddate) == ''){
              $enddate = '';
            }
            
          }
          var subtitle = $.trim($('.esec2').val());
          if ($.trim($('.esec3').val()) != "" && subtitle != "") {
            subtitle += ' &nbsp;|&nbsp; '+$.trim($('.esec3').val());
          }else{
            subtitle += $.trim($('.esec3').val());
          }
          $startdate = '';
          if($.trim($('.estmn').val())){
            $startdate += $.trim($('.estmn').val());
          }
          if($.trim($('.estyr').val())){
            $startdate += ' '+$.trim($('.estyr').val());
          }
          if (subtitle)  {
            subtitle += ' &nbsp;|&nbsp; '+ $startdate +$enddate;
          }else{
            subtitle += $startdate +$enddate;
          }

          $('.EDU-' + $('.eid').html() + '.E2').html(subtitle);
        });
        
        $('.editform .note-editor').on("input", function() {
          $('.EDU-' + $('.eid').html() + '.E3').html($(".edeon").code());
        });
        
        $('.editform-cancelnewadd').on("click", function() {
          refresh();
          buildresume();
        });
        
        var editables = document.getElementsByClassName('note-editable');
        for (var i = 0; i < editables.length; i++) {
            editables[i].addEventListener('paste', function(e) {
            var clipboardData, pastedData;
            
            		// Stop data actually being pasted into div
            		e.stopPropagation();
                e.preventDefault();
            
            		// Get pasted data via clipboard API
                clipboardData = e.clipboardData || window.clipboardData;
                pastedData = clipboardData.getData('Text');
                
                // Do whatever with pasteddata
                document.execCommand('insertText', false, pastedData);
                $('.EDU-' + $('.eid').html() + '.E3').html($(".edeon").code());
            }, false);
        }

      }

    });


    $("i.delete").on('click', function(e) {
      var r = confirm("Are you sure you want to delete this Record?");
      if (r == true) {
        deleteRecord($(this).data('key'));
        return false;
      }
      else{
        e.preventDefault();
        return false;
      }
    });

    $("i.visibility").on('click', function(e) {
      changeVisibility($(this).data('key'), $(this).data('status'));
      return false;
    });
    
    $('div.media-right').on('click', function(e) {
        $('[data-1="'+$(this).data("for")+'"]').trigger('click');
    });

    $('.cancelnewadd').on("click", function() {
      refresh();
      buildresume();
    });
    
  }

  var param = {
    end_date: "",
    is_active: 1,
    more_info1: null,
    order_prefs: 999,
    section_title1: null,
    section_title2: null,
    section_title3: null,
    section_type: "EDUCATION",
    start_date: ""
  };

  function updateRecord(key) {
    init();
    console.log("updateRecord()");
    if (Data.Education[key] != null && Data.Education[key].section_type == "EDUCATION") {
      Data.Education[key].section_title2 = $(".esec2").val();
      Data.Education[key].section_title1 = $(".esec1").val();
      Data.Education[key].section_title3 = $(".esec3").val();

      Data.Education[key].start_date = $.trim($('.estmn').val())+' '+$.trim($('.estyr').val());


      if($(".eprnt").prop('checked') == true){
        Data.Education[key].end_date = 'Present';
      }else{
        Data.Education[key].end_date = $.trim($('.eenmn').val())+' '+$.trim($('.eenyr').val());
        if($.trim(Data.Education[key].end_date) == '-' || $.trim(Data.Education[key].end_date) == ''){
          Data.Education[key].end_date = '';
        }
      }
      if($(".edeon").code().replace(/<\/?[^>]+(>|$)/g, "") == ""){
        Data.Education[key].more_info1 = "";
      }else{
        Data.Education[key].more_info1 = $(".edeon").code();
      }
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
      refresh();
      return false;
    }
  }

  function deleteRecord(key) {
    console.log("deleteRecord()");
    delete Data.Education[key];
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
    refresh();
  }

  function addRecord() {
    if($(".sec1").val()!="" && $(".sec2").val()!=""){
      init();
      console.log("addRecord()");
      param.section_title1 = $(".sec1").val();
      param.section_title2 = $(".sec2").val();
      param.section_title3 = $(".sec3").val();
      param.start_date = $(".stmn").val() + ' ' + $(".styr").val();
      if ($('.prnt').is(":checked")) {
        param.end_date = 'Present';
      }
      else {
        param.end_date = $(".enmn").val() + ' ' + $(".enyr").val();
      }

      param.more_info1 = $(".deon").code();

      Data.Education.push(param);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
      refresh();
    }
  }

  function changeVisibility(key, status) {
    console.log("changeVisibility()");
    if (status == 1) {
      Data.Education[key].is_active = 0;
    }
    else {
      Data.Education[key].is_active = 1;
    }
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
    refresh();
  }


  $(".newForm-header, .newForm-footer, .newForm-save").on('click', function(e) {
    
    if(e.target.className == "fa fa-close"){
      refresh();
    }else{
      addRecord();
    }
    $('.newForm').trigger('reset');
  });

  var flag = 1;

  $('.prnt').on("change", function() {
    if ($('.prnt').is(":checked")) {
      $(".enmn").val('');
      $(".enyr").val('');
      $(".enmn").prop('disabled', true);
      $(".enyr").prop('disabled', true);
    }
    else {
      $(".enmn").prop('disabled', false);
      $(".enyr").prop('disabled', false);
    }
  });


  var optyear = '<option value="&nbsp;">Year</option>';
  for (i = 1995; i <= new Date().getFullYear(); i++) {
    optyear += '<option value="' + i + '">' + i + '</option>';
  }
  $(".styr,.enyr,.estyr,.eenyr").html(optyear);

  $(".stmn,.enmn,.estmn,.eenmn").html('<option value="&nbsp;">Month</option><option value="Jan">January</option><option value="Feb">February</option><option value="Mar">March</option><option value="Apr">April</option><option value="May">May</option><option value="Jun">June</option><option value="Jul">July</option><option value="Aug">August</option><option value="Sept">September</option><option value="Oct">October</option><option value="Nov">November</option><option value="Dec">December</option>');

  function toolOptionShow(o) {
    $('#' + o + ' .visibility,'+'#' + o + ' .delete').show();
    //$('#' + o + ' .control-open').hide();
    
  }

  function toolOptionHide(o) {
    $('#' + o + ' .visibility,'+'#' + o + ' .delete').hide();
    //$('#' + o + ' .control-open').show();
  }

  
      $('.scrollable-horizontal').scrollLeft($("a.active_menu").parent().offset().left - $('.scrollable-horizontal').offset().left);

      $(document).ready(function() {
      
          var items = $(".mobile_menu_content .scrollable-horizontal li");
          var scrollContainer = $(".mobile_menu_content .scrollable-horizontal");
      
      
          function fetchItem(container, items, isNext) {
              var i,
                  scrollLeft = container.scrollLeft();
      
              if (isNext === undefined) {
                  isNext = true;
              }
      
              if (isNext && container[0].scrollWidth - container.scrollLeft() <= container.outerWidth()) {
                  return $(items[0]);
              }
              for (i = 0; i < items.length; i++) {
      
                  if (isNext && $(items[i]).position().left > 0) {
                      return $(items[i]);
                  } else if (!isNext && $(items[i]).position().left >= 0) {
                      return i == 0 ? $(items[items.length - 1]) : $(items[i-1]);
                  }
              }
              return null;
          }
          function moveToItem(event) {
              var isNext = event.data.direction == "next";
              var item = isNext ? fetchItem(scrollContainer, items, true) : fetchItem(scrollContainer, items, false);
      
              if (item) {
                  scrollContainer.animate({"scrollLeft": item.position().left + scrollContainer.scrollLeft()}, 400);
              }
          }
      
          $("#prev_btn").click({direction: "prev"}, moveToItem);
          $("#next_btn").click({direction: "next"}, moveToItem);
      });
</script>

<!-- nav-tabs -->
<div class="nav_tab_container">
  <div style="float:left;width:8%;line-height: 45px;text-align: right;font-size:16px;color: #474747;cursor:pointer;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/sections.tpl">
      <i class="icon wb-menu"></i>
  </div>
  <div id="prev_btn" style="float:left;width:10%;line-height: 45px;font-size: 16px;text-align: center;cursor:pointer;">
    <i class="icon wb-chevron-left"></i>
  </div>
  <div style="float:left;width:64%;line-height: 45px;">
    <div class="mobile_menu_content" data-plugin="scrollable" style="padding-bottom:0px;width:100%;overflow: hidden;">
    
    <ul class="site-sidebar-nav nav nav-tabs nav-justified nav-tabs-line scrollable scrollable-horizontal" role="tablist" >
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/ABOUT_YOU.tpl"><span>ABOUT YOU</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EXPERIENCE.tpl"><span>EXPERIENCE</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="Presentation">
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl"><span>EDUCATION</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="Presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/SKILLS.tpl"><span>SKILLS</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PROJECTS.tpl"><span>PROJECTS</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/ACHIEVEMENTS_new.tpl"><span>ACHIEVEMENTS</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/CERTIFICATIONS.tpl"><span>CERTIFICATIONS</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation" >
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/LANGUAGES.tpl"><span>LANGUAGES</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/HOBBIES.tpl"><span>HOBBIES</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PERSONAL_DETAILS.tpl"><span>PERSONAL</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="Presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/CONTACT_DETAILS.tpl"><span>CONTACT</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/WORKLINKS.tpl">
          <span>WEBLINKS</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="Presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/VOLUNTEERING.tpl"><span>VOLUNTEERING</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="Presentation" >
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/RECOMMENDATIONS.tpl"><span>RECOMMENDATIONS</span>
        </a>
      </li>
    </ul>
      
  </div>
  </div>
  <div id="next_btn" style="float:left;width:8%;line-height: 45px;font-size: 16px;text-align: center;cursor:pointer;">
    <i class="icon wb-chevron-right"></i>
  </div>
  <div class="slidePanel-close" style="float:left;width:8%;line-height: 45px;font-size: 16px;text-align: center;cursor:pointer;">
    <i class="icon wb-close"></i>
  </div>
</div>

<script>
  $(document).ready(function(){
   $(".mobile_menu_content").attachDragger();
  });
</script>

<div class="site-sidebar-tab-content tab-content">

  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">

    <div class="">

      <div class="">
        <span class="slidePanel-desc">Your education details</span>
        <br>
        <br>
        <div class="list-group data-container">
        </div>

        <form class='newForm margin-bottom-50 padding-10' style="margin-right: -10px; margin-left: -10px;">
          <div class="newForm-header" style="margin: -10px;margin-bottom:15px;">
            <span class="new-heading pull-right" style=" margin-top: -10px; line-height: 25px; text-align: right;">
              <i class="fa fa-close" style="font-color:red;cursor:pointer;"></i><br>ADD EDUCATION
            </span>
            <div class="avatar avatar-sm" style="width:35px;">
              <img src="/static/classic/topbar/assets/images/chars/new.png" alt="...">
            </div>
          </div>
          <!--<span class="new-heading">ADD EDUCATION</span><i class="icon wb-close pull-right cancelnewadd" style="cursor:pointer;color:#DE5F5F;margin-right: 8px;"></i>-->
          <div class="form-group form-material floating">
            <input type="text" class="form-control empty sec1" />
            <label class="floating-label">Course Name</label>
          </div>

          <div class="form-group form-material floating">
            <input type="text" class="form-control empty sec3" />
            <label class="floating-label">Percentage / CGPA / Grade</label>
          </div>
          
          <div class="form-group form-material floating">
            <input type="text" class="form-control empty sec2" />
            <label class="floating-label">Institute Name</label>
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
            <textarea class="form-control deon empty" rows="3"></textarea>
            <label class="floating-label">Description</label>
          </div>
          
          <div class="row margin-10">
            <div class="col-xs-6 col-sm-6">
              <button type="button" class="btn btn-block btn-default btn-sm cancelnewadd" title="No changes will be saved" >Cancel</button>
            </div>
            <div class="col-xs-6 col-sm-6">
              <button type="button" class="btn btn-block btn-primary newForm-save  btn-sm font-weight-400" >ADD</button>
            </div>
          </div>

          <div class="text-center newForm-footer"><i class="fa fa-angle-up"></i></div>
        </form>

        <div class="row margin-bottom-50">
          <div class="col-sm-7 col-xs-7">
          </div>
          <div class="col-sm-5 col-xs-5 ">
            <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/SKILLS.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
          </div>
        </div>
        
      </div>
      
    </div>

  </div>

</div>
