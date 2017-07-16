<style>
input::-webkit-outer-spin-button, /* Removes arrows */
input::-webkit-inner-spin-button, /* Removes arrows */
input::-webkit-clear-button { /* Removes blue cross */
  -webkit-appearance: none;
  margin: 0;
}
.site-sidebar-nav.nav-tabs > li > a {
    padding: 0;
}
</style>
<script>

  var Data;

  function init(){
    Data = localStorage.getItem("data");
    Data = $.parseJSON(Data);
  }

  init();
  
  
  if(Data.Profile.jobTitle != null && Data.Profile.jobTitle != "")    {      $('.jole').removeClass('empty');    }
  $('.jole').val(Data.Profile.jobTitle);
    
  var regex = /<br\s*[\/]?>/gi;
  
  if(Data.Profile.summary != null && Data.Profile.summary != "")    {      $('.sury').removeClass('empty');    }
  $('.sury').val(decodeURIComponent(Data.Profile.summary).replace(regex, "\n"));
  
  //if(Data.Profile.objective != null && Data.Profile.objective != "")    {      $('.objc').removeClass('empty');    }
  //$('.objc').val(decodeURIComponent(Data.Profile.objective).replace(regex, "\n"));

  if($('.sury').prop('scrollHeight') > 250)
  {
    $('.sury').height('250px');
  }
  else{
    $('.sury').height($('.sury').prop('scrollHeight')+"px");
  }
  
  $('.tab-pane').asScrollable('update');

  var flag=1;
  
  $('.jole').on('input', function() {
      Data.Profile.jobTitle = $(".jole").val().toUpperCase();
      $("#job_title").html(Data.Profile.jobTitle);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
  });
  
  $('.sury').on("input", function()  {
    updateSummary();
  });


  function updateSummary(){
    init();
    Data.Profile.summary = $('.sury').val().replace(/\n/g, "<br>");
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  }

  var flag = 0;
  $('#suggestions').click(function()
  {
    $('#sampleFormModal').modal('toggle');
    if(flag == 0){
      flag = 1;
      $('#filtersummary').trigger('click');
    }
  });
  
  function textAreaAdjust(o) {
      o.style.height = "1px";
      if(o.scrollHeight > 250)
      {
        o.style.height = 250+"px";
      }else{
        o.style.height = (5+o.scrollHeight)+"px";
      }
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
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/ABOUT_YOU.tpl"><span>ABOUT YOU</span>
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
  <div class="tab-pane fade active in" id="sidebar-editing">
    <div>
        <div>
          <span class="slidePanel-desc">Enter job title which suits you best & briefly write about yourself under summary</span>
          <form class="margin-bottom-50 margin-top-45">
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control jole empty" />
              <label class="floating-label">JOB TITLE</label>
            </div>
            
            <div class="form-group form-material floating">
              <textarea class="form-control sury empty" onkeyup="textAreaAdjust(this)" rows="1" ></textarea>
              <label class="floating-label">SUMMARY</label>
            </div>

            <span id="suggestions">See Example</span>

            <div class="row">
              <div class="col-sm-7 col-xs-7">
              </div>
              <div class="col-sm-5 col-xs-5">
                <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EXPERIENCE.tpl">NEXT&nbsp; <i class="fa fa-caret-right"></i> </button>
              </div>
            </div>
            
          </form>
        </div>
      </div>
  </div>
</div>
<script>

</script>