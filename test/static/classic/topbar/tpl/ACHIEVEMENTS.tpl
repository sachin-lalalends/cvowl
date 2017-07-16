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
</style>


<script>
  var Data;

  function init() {
    console.log("init()");
    Data = localStorage.getItem("data");
    Data = $.parseJSON(Data);
    // Data.Achievement.sort(function(a, b) {
    //   if (a == null || b == null) return 0;
    //   return parseFloat(a.order_prefs) - parseFloat(b.order_prefs);
    // });
  }



  refresh();

  function refresh() {
    init();
    console.log("refresh()");
    try{
      $(".deon").val(Data.Achievement[0].more_info1);
    }
    catch(err){
      $(".deon").val();
    }
    $('.deon').summernote({
      height: 100
    });
    $('.newForm .note-style, .newForm .note-fontname,.newForm .note-font,.newForm .note-color, .newForm .note-table,.newForm .note-height,.newForm .note-insert, .newForm .note-view,.newForm .note-help, .newForm  .note-statusbar').remove();
    $('.newForm .note-para').addClass("pull-right");
    $('.newForm .note-para').find('button:nth-child(2)').hide();
    $('.newForm .note-toolbar, .newForm .note-editor').css("border", "0px");
    $('.newForm .note-toolbar').css("background-color", "white");
    $('.newForm .note-editor').css("border-bottom", "1px #AAAAAA solid");
    $('button[data-original-title="Paragraph"]').remove();


    $('.tab-pane').css('opacity', '1');

    
    $('.newForm .note-editor').on("input", function() {
      // console.log($(".deon").code());
      Data.Achievement[0].more_info1 = $(".deon").code();
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
      //$('.ACHV-' + $('.eid').html() + '.E3').html($(".edeon").code());
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
            $('.ACHV-' + $('.eid').html() + '.E3').html($(".edeon").code());
        }, false);
    }


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
    
  }

  var param = {
    is_active: 1,
    more_info1: null,
    order_prefs: 999,
    section_title1: null,
    section_title2: null,
    section_title3: null,
    section_type: "ACHIEVEMENT",
    start_date: ""
  };

  
  function changeVisibility(key, status) {
    console.log("changeVisibility()");
    if (status == 1) {
      Data.Achievement[key].is_active = 0;
    }
    else {
      Data.Achievement[key].is_active = 1;
    }
    localStorage.setItem("data", JSON.stringify(Data));
    buildresume();
    refresh();
  }


  

  var flag = 1;

  function toolOptionShow(o) {
    $('#' + o + ' .visibility,'+'#' + o + ' .delete').show();
    //$('#' + o + ' .control-open').hide();
    
  }

  function toolOptionHide(o) {
    $('#' + o + ' .visibility,'+'#' + o + ' .delete').hide();
    //$('#' + o + ' .control-open').show();
  }
  
      $('.scrollable-horizontal').scrollLeft($("a.active_menu").parent().offset().left - $("a.active_menu").parent().width() +20);

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
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl"><span>EDUCATION</span>
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
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/ACHIEVEMENTS_new.tpl"><span>ACHIEVEMENTS</span>
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

<div class="hide_scroller">
  
</div>

<div class="pull-right resume_section_btn">
  <a class="text-action slidePanel-close" href="javascript:void(0)" role="button">
    <i class="fa fa-caret-left" aria-hidden="true"></i>
  </a>
</div>
<div class="site-sidebar-tab-content tab-content">

  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">

    <div class="">

      <div class="">
        <span class="slidePanel-desc">Showcase your recognitions you have earned</span>
        
        <form class='newForm margin-bottom-50 padding-10' style="margin-right: -10px; margin-left: -10px;">
          <div class="form-group form-material floating">
            <textarea class="form-control deon empty" rows="5"></textarea>
            <label class="floating-label">Description</label>
          </div>
        </form>

        <div class="row margin-bottom-50">
          <div class="col-sm-7 col-xs-7">
          </div>
          <div class="col-sm-5 col-xs-5 ">
            <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/CERTIFICATIONS.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
          </div>
        </div>
        
      </div>
      
    </div>

  </div>

</div>
