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

    Data.Award.sort(function(a, b) {
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
    $.each(Data.Award, function(k, v) {
      if (v != null && v.section_type == "AWARD") {
        temp += '<a style="border-radius:10px;box-shadow:0 1px 1px rgba(0,0,0,0.15),-1px 0 0 rgba(0,0,0,0.03),1px 0 0 rgba(0,0,0,0.03),0 1px 0 rgba(0,0,0,0.12);    background: rgba(245, 245, 245, 0.2);" class="list-group-item margin-15" href="javascript:void(0)" id="' + k + '"  onMouseOver="toolOptionShow(' + k + ')" onMouseOut="toolOptionHide(' + k + ')">' +
          '<div class="media">' +
          '<div class="media-left" style="padding-right:0px;">' +
          '<div class="avatar drag-handle margin-right-15" style="width:15px;">' +
          '<img src="https://lh3.googleusercontent.com/-R2RhurLgYNY/Vy2hoYXFqqI/AAAAAAAAB1U/mWrX0vaZRToOHzgxYJqTQRQ9TkwBz-mCACL0B/w15-h32-no/rsz_drag_icon.png" width="20px" alt="...">' +
          '</div>' +
          '</div>' +
          '<div class="media-left" style="padding-right:10px;">' +
          '<div class="avatar avatar-sm" style="width:35px;">' +
          '<img src="/static/classic/topbar/assets/images/chars/'+ v.section_title2.charAt(0).toUpperCase() +'.png" alt="...">' +
          '</div>' +
          '</div>' +
          '<div class="media-body" data-1="' + k + '"  data-rowcount="' + k + '">' +
          '<h4 class="media-heading">' + v.section_title2 + '</h4>' +
          '<p class="small">' + v.section_title1 + '</p>' +
          '</div>' +
          '<div class="media-right" data-for="'+k+'">';
          if (v.is_active == 1) {
            temp += '<i class="icon wb-eye visibility"' + 'data-key="' + k + '"' + 'data-status="' + v.is_active + '"' + 'style="display:none;font-size:10px;color: #76838f;"></i>';
          }
          else {
            temp += '<i class="icon wb-eye-close visibility"' + 'data-key="' + k + '"' + 'data-status="' + v.is_active + '"' + 'style="display:none;font-size:10px;color: #76838f;"></i>';
          }
        temp += '<i class="icon wb-close delete"' + 'data-key="' + k + '"' + 'style="display:none;font-size:10px;color: #DE5C5C;"></i>' +
          '</div>' +
          '</div>' +
          '</a><span class="edit-' + k + '"></span>';
        id++;
      }
    });
    temp += '</span>';

    temp += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block addnewBtn margin-top-20 margin-bottom-50"><i class="icon wb-plus"></i>&nbsp;Add Award</button>';


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
        $.each(sectionOrder, function(k, v) {
          if (v != "") {
            Data.Award[v].order_prefs = orderpref;
            orderpref++;
          }
        });
        localStorage.setItem("data", JSON.stringify(Data));
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

        $select = $(this).closest('.list-group-item').hide();;

        
        $('.edit-' + $(this).data('1')).html('<form class="editform margin-20 padding-10" style="display:none;"> <div class="editform-header"> <span class="new-heading pull-right esetting" style=" margin-top: -10px; line-height: 25px; text-align: right;"><br>EDIT AWARD</span><div class="avatar avatar-sm" style="width:35px;"><img class="eimg" src="" alt="..."></div> </div><span class="eid" style="display:none;">' + $(this).data('1') + '</span><div class="form-group form-material floating" style="    margin-top: 30px;"> <input type="text" class="form-control esec2"/> <label class="floating-label">Award Title</label> </div><div class="form-group form-material floating"> <input type="text" class="form-control esec1"/> <label class="floating-label">Company Name</label> </div><div class="row"> <div class="col-sm-5"> <div class="form-group form-material floating"> <select class="form-control estmn"> </select> <label class="floating-label">Start Date</label> </div></div><div class="col-sm-3"> <div class="form-group form-material floating"> <select class="form-control estyr"> <option value="">Year</option> </select> </div></div></div><div class="form-group form-material floating"> <textarea class="form-control edeon empty" rows="3" ></textarea> <label class="floating-label">Description</label> </div><div class="row margin-10"><div class="col-xs-6 col-sm-6"><button type="button" class="btn btn-block btn-default btn-sm editform-cancelnewadd" title="No changes will be saved" >Cancel</button></div><div class="col-xs-6 col-sm-6"><button type="button" class="btn btn-block btn-primary  btn-sm font-weight-400 editform-save" >SAVE</button></div></div><div class="text-center editform-footer"><i class="fa fa-angle-up"></i></div> </form>');

        $(".styr,.estyr").html(optyear);

        $(".stmn,.estmn").html('<option value="&nbsp;">Month</option><option value="Jan">January</option><option value="Feb">February</option><option value="Mar">March</option><option value="Apr">April</option><option value="May">May</option><option value="Jun">June</option><option value="Jul">July</option><option value="Aug">August</option><option value="Sept">September</option><option value="Oct">October</option><option value="Nov">November</option><option value="Dec">December</option>');

        $(".eimg").attr('src',"/static/classic/topbar/assets/images/chars/"+Data.Award[$(this).data('1')].section_title2.charAt(0).toUpperCase()+".png");
        $(".esec1").val(Data.Award[$(this).data('1')].section_title1);
        $(".esec2").val(Data.Award[$(this).data('1')].section_title2);
        $(".esec3").val(Data.Award[$(this).data('1')].section_title3);
        var res = Data.Award[$(this).data('1')].start_date.split(' ');


        $(".estmn").val($.trim(res[0]));
        $(".estyr").val($.trim(res[1]));
        
        $(".edeon").val(Data.Award[$(this).data('1')].more_info1);
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

        $('.editform-header,.editform-footer, .editform-save').on('click', function(e) {
          $select.slideDown();
          updateRecord($('.eid').html());
          $('.editform').slideUp();
        });
        
        $('.esec1').on("input", function() {
          $('[data-for="AWD-' + $('.eid').html() + '"] .E1').html($('.esec1').val().toUpperCase());
        });

        $('.esec2, .esec3, .estyr, .estmn').on("input", function() {
          $('[data-for="AWD-' + $('.eid').html() + '"] .E2').html($('.esec2').val()+ " &nbsp;|&nbsp; "+ $('.esec3').val() +" &nbsp;|&nbsp; "+$('.estmn').val()+" "+$('.estyr').val());
        });
        
        $('.editform .note-editor').on("input", function() {
          $('[data-for="AWD-' + $('.eid').html() + '"] .E3').html($(".edeon").code());
        });
        
        $('.editform-cancelnewadd').on("click", function() {
          refresh();
          buildresume();
        });

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
    end_date: null,
    is_active: 1,
    more_info1: null,
    more_info2: null,
    more_info3: null,
    more_info4: null,
    more_info5: null,
    order_prefs: 999,
    section_label: null,
    section_name: null,
    section_title1: null,
    section_title2: null,
    section_title3: null,
    section_title4: null,
    section_title5: null,
    section_type: "AWARD",
    start_date: null
  };

  function updateRecord(key) {
    init();
    console.log("updateRecord()");
    if (Data.Award[key] != null && Data.Award[key].section_type == "AWARD") {
      Data.Award[key].section_title1 = $(".esec1").val();
      Data.Award[key].section_title2 = $(".esec2").val();
      Data.Award[key].section_title3 = $(".esec3").val();
      Data.Award[key].start_date = $(".estmn").val() + ' ' + $(".estyr").val();
      if ($('.eprnt').is(":checked")) {
        Data.Award[key].end_date = 'Present';
      }
      else {
        Data.Award[key].end_date = $(".eenmn").val() + ' ' + $(".eenyr").val();
      }
      if($(".edeon").code().replace(/<\/?[^>]+(>|$)/g, "") == ""){
        Data.Award[key].more_info1 = "";
      }else{
        Data.Award[key].more_info1 = $(".edeon").code();
      }
      localStorage.setItem("data", JSON.stringify(Data));
      refresh();
      return false;
    }
  }

  function deleteRecord(key) {
    console.log("deleteRecord()");
    delete Data.Award[key];
    localStorage.setItem("data", JSON.stringify(Data));
    buildresume();
    refresh();
  }

  function addRecord() {
    if($(".sec1").val()!="" && $(".sec2").val()!="" && $(".sec2").val()!=""){
      init();
      console.log("addRecord()");
      param.section_title1 = $(".sec1").val();
      param.section_title2 = $(".sec2").val();
      param.section_title3 = $(".sec3").val();
      param.start_date = $(".stmn").val() + ' ' + $(".styr").val();
      param.more_info1 = $(".deon").code();

      Data.Award.push(param);
      localStorage.setItem("data", JSON.stringify(Data));
      buildresume();
      refresh();
    }
  }

  function changeVisibility(key, status) {
    console.log("changeVisibility()");
    if (status == 1) {
      Data.Award[key].is_active = 0;
    }
    else {
      Data.Award[key].is_active = 1;
    }
    localStorage.setItem("data", JSON.stringify(Data));
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


  var optyear = '<option value="&nbsp;">Year</option>';
  for (i = 1995; i <= new Date().getFullYear(); i++) {
    optyear += '<option value="' + i + '">' + i + '</option>';
  }
  $(".styr,.estyr").html(optyear);

  $(".stmn,.estmn").html('<option value="&nbsp;">Month</option><option value="Jan">January</option><option value="Feb">February</option><option value="Mar">March</option><option value="Apr">April</option><option value="May">May</option><option value="Jun">June</option><option value="Jul">July</option><option value="Aug">August</option><option value="Sept">September</option><option value="Oct">October</option><option value="Nov">November</option><option value="Dec">December</option>');

  function toolOptionShow(o) {
    $('#' + o + ' .visibility,'+'#' + o + ' .delete').show();
    //$('#' + o + ' .control-open').hide();
    
  }

  function toolOptionHide(o) {
    $('#' + o + ' .visibility,'+'#' + o + ' .delete').hide();
    //$('#' + o + ' .control-open').show();
  }
  
</script>

<ul class="site-sidebar-nav nav nav-tabs nav-justified nav-tabs-line" role="tablist">
  <li style="cursor:pointer;" role="Presentation">
    <a>
      &nbsp;&nbsp;&nbsp;&nbsp;
      
<img data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/sections.tpl" src="data:image/png;base64,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">&nbsp;&nbsp;
    </a>
  </li>
  <li role="Presentation">
    <a>
      <i class="icon wb-chevron-left" title="Previous Section" style="cursor:pointer;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/ABOUT_YOU.tpl"></i>
      <span style="font-weight:500;color:#66AAEA;border-bottom: 2px solid #62a8ea;">AWARD</span>
    </a>
  </li>
  <li style="cursor:pointer;font-weight:400;" role="Presentation">
    <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl">EDUCATION
    </a>
  </li>
  <li style="cursor:pointer;" role="Presentation" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl">
    <a>
      <span style="font-weight:400;background: -webkit-linear-gradient(left,#76838F, #fff);-webkit-background-clip: text;-webkit-text-fill-color: transparent;">SK</span>&nbsp;
      <i class="icon wb-chevron-right" title="Next Section" style="color:#66AAEA" aria-hidden="true"></i>
    </a>
  </li>
</ul>

<div class="site-sidebar-tab-content tab-content">

  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">

    <div class="">

      <div class="">
        <span class="slidePanel-desc">Showcase your awards you have received</span>
        <br>
        <br>
        <div class="list-group data-container">
        </div>

        <form class='newForm margin-bottom-50 padding-10' style="margin-right: -10px; margin-left: -10px;">
          <div class="newForm-header" style="margin: -10px;margin-bottom:15px;">
            <span class="new-heading pull-right" style=" margin-top: -10px; line-height: 25px; text-align: right;">
              <i class="fa fa-close" style="font-color:red;cursor:pointer;"></i><br>ADD AWARD
            </span>
            <div class="avatar avatar-sm" style="width:35px;">
              <img src="/static/classic/topbar/assets/images/chars/new.png" alt="...">
            </div>
          </div>
          <!--<span class="new-heading">ADD AWARD</span><i class="icon wb-close pull-right cancelnewadd" style="cursor:pointer;color:#DE5F5F;margin-right: 8px;"></i>-->
          <div class="form-group form-material floating">
            <input type="text" class="form-control empty sec2" />
            <label class="floating-label">Award Title</label>
          </div>

          <div class="form-group form-material floating">
            <input type="text" class="form-control empty sec1" />
            <label class="floating-label">Company / Institution Name</label>
          </div>

          <div class="row">
            <div class="col-sm-5">
              <div class="form-group form-material floating">
                <select class="form-control stmn">
                </select>
                <label class="floating-label">Date</label>
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
            <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
          </div>
        </div>
        
      </div>
      
    </div>

  </div>

</div>
