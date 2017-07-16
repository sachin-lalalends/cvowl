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
  }

  refresh();

  $('.tab-pane').css('opacity', '1');
  function refresh() {
    init();
    console.log("refresh()");
    
    if(Data.Worklinks[0].websiteURL != null){
      $('.sec1').val(Data.Worklinks[0].websiteURL);
    }
    
    if(Data.Worklinks[1].portfolioURL != null){
      $('.sec2').val(Data.Worklinks[1].portfolioURL);
    }
    
    if(Data.Worklinks[2].blogURL != null){
      $('.sec3').val(Data.Worklinks[2].blogURL);
    }
    
    if(Data.Worklinks[3].slideshareURL != null){
      $('.sec4').val(Data.Worklinks[3].slideshareURL);
    }
    
    
    $('.sec1').on('keyup', function(e) {
      init();
      console.log("updateRecord()");
      Data.Worklinks[0].websiteURL = $('.sec1').val();
      $('LINK.E1').html(Data.Worklinks[0].websiteURL);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
    });
    
    $('.sec2').on('keyup', function(e) {
      init();
      console.log("updateRecord()");
      Data.Worklinks[1].portfolioURL = $('.sec2').val();
      $('LINK.E2').html(Data.Worklinks[1].portfolioURL);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
    });
    
    $('.sec3').on('keyup', function(e) {
      init();
      console.log("updateRecord()");
      Data.Worklinks[2].blogURL = $('.sec3').val();
      $('LINK.E3').html(Data.Worklinks[2].blogURL);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
    });
    
    $('.sec4').on('keyup', function(e) {
      init();
      console.log("updateRecord()");
      Data.Worklinks[3].slideshareURL = $('.sec4').val();
      $('LINK.E4').html(Data.Worklinks[3].slideshareURL);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
    });

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
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/WORKLINKS.tpl">
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
        <span class="slidePanel-desc">List links to your website, portfolio, blog & slideshare presentation</span>
        <br>
        <br>
        <div class=" data-container">
        </div>
        <form class="newForm">
          <div class="form-group form-material row">
            <div class="col-xs-12">
              <input type="text" class="form-control empty sec1" placeholder="Website URL">
            </div>
          </div>
          <div class="form-group form-material row">
            <div class="col-xs-12">
              <input type="text" class="form-control empty sec2" placeholder="Portfolio URL">
            </div>
          </div>
          <div class="form-group form-material row">
            <div class="col-xs-12">
              <input type="text" class="form-control empty sec3" placeholder="Blog URL">
            </div>
          </div>
          <div class="form-group form-material row">
            <div class="col-xs-12">
              <input type="text" class="form-control empty sec4" placeholder="Slideshare URL">
            </div>
          </div>
          
        </form>
        <div class="row margin-bottom-50 margin-top-50">
          <div class="col-sm-7 col-xs-7">
          </div>
          <div class="col-sm-5 col-xs-5">
            <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/VOLUNTEERING.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
          </div>
        </div>
      </div>
    </div>

  </div>

</div>
