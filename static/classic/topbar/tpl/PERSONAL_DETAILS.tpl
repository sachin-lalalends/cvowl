<style>
  input::-webkit-outer-spin-button,  /* Removes arrows */
  input::-webkit-inner-spin-button,  /* Removes arrows */
  input::-webkit-clear-button {    /* Removes blue cross */
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
  
  var optyear = '<option selected value="&nbsp;">Year</option>';
  for (i = 1980; i <= new Date().getFullYear(); i++) {
    optyear += '<option value="' + i + '">' + i + '</option>';
  }
  $(".year").html(optyear);

  $(".month").html('<option selected value="&nbsp;">Month</option><option value="Jan">January</option><option value="Feb">February</option><option value="Mar">March</option><option value="Apr">April</option><option value="May">May</option><option value="Jun">June</option><option value="Jul">July</option><option value="Aug">August</option><option value="Sept">September</option><option value="Oct">October</option><option value="Nov">November</option><option value="Dec">December</option>');
  
  var optdate = '<option selected value="&nbsp;">Date</option>';
  for (i = 1; i <= 31; i++) {
    optdate += '<option value="' + i + '">' + i + '</option>';
  }
  
  $(".date").html(optdate);
  
  refresh();
  
  function refresh() {
    init();
    console.log("refresh()");
    
    if(Data.Profile.firstName != null && Data.Profile.firstName != "")
    $('.sec1').val(Data.Profile.firstName);
    else
    $('.sec1').addClass("empty");
    
    if(Data.Profile.lastName != null && Data.Profile.lastName != "")
    $('.sec2').val(Data.Profile.lastName);
    else
    $('.sec2').addClass("empty");
    
    if(Data.Profile.birthDay != null && Data.Profile.birthDay != "")
    {
      var res = Data.Profile.birthDay.split("-");
      $('.date').val(res[0]);
      $('.month').val(res[1]);
      $('.year').val(res[2]);
    }
    
    if(Data.Profile.gender != null)
    $('.sec4').val(Data.Profile.gender);
    else
    $('.sec4').addClass("empty");
    
    if(Data.Profile.maritalStatus != null)
    $('.sec5').val(Data.Profile.maritalStatus);
    else
    $('.sec5').addClass("empty");
    
    
    if(Data.Profile.nationality != null && Data.Profile.nationality != "")
    $('.sec6').val(Data.Profile.nationality);
    else
    $('.sec6').addClass("empty");
    
    if(Data.Profile.currentLocation != null && Data.Profile.currentLocation != "")
    $('.sec7').val(Data.Profile.currentLocation);
    else
    $('.sec7').addClass("empty");
    
    if(Data.Profile.email != null && Data.Profile.email != "")
    $('.sec8').val(Data.Profile.email);
    else
    $('.sec8').addClass("empty");
    
    $('.tab-pane').asScrollable('update');
    

  }
  
  $('.sec1').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.firstName = $('.sec1').val().toUpperCase();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec2').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.lastName = $('.sec2').val().toUpperCase();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec4').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.gender = $('.sec4').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec5').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.maritalStatus = $('.sec5').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec6').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.nationality = $('.sec6').val();
    $('[data-for="INFO"] .E4').html(Data.Profile.nationality);
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec7').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.currentLocation = $('.sec7').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec8').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.email = $('.sec8').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  
  
  $('.date, .month, .year').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.birthDay = $('.date').val()+"-"+$('.month').val()+"-"+$('.year').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
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
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PERSONAL_DETAILS.tpl"><span>PERSONAL</span>
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
        <form class="margin-bottom-50">
          
          <span class="slidePanel-desc">Enter your personal details</span>
          <br>
          <br>
          
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control sec1 " />
                <label class="floating-label">First Name</label>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control sec2 "/>
                <label class="floating-label">Last Name</label>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-12">
              <div class="form-group form-material floating">
                <input type="text" class="form-control  sec8" />
                <label class="floating-label">Email ID</label>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-4">
              <div class="form-group form-material floating">
                <select class="form-control date">
                </select>
                <label class="floating-label">Date Of Birth</label>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group form-material floating">
                <select class="form-control month">
                </select>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group form-material floating">
                <select class="form-control year">
                  
                </select>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <select class="form-control sec4 " >
                  <option selected>&nbsp;</option>
                  <option value="Male">Male</option>
                  <option value="Female">Female</option>
                  <option value="Other">Other</option>
                </select>
                <label class="floating-label">Gender</label>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <select class="form-control sec5 " >
                  <option selected>&nbsp;</option>
                  <option value="Single">Single</option>
                  <option value="Married">Married</option>
                  <option value="Divorced">Divorced</option>
                </select>
                <label class="floating-label">Maritial Status</label>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control  sec6" style="text-transform:uppercase" />
                <label class="floating-label">Nationality</label>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control  sec7" />
                <label class="floating-label">Current Location</label>
              </div>
            </div>
          </div>

          <div class="row margin-bottom-50 margin-top-50">
            <div class="col-sm-7 col-xs-7">
            </div>
            <div class="col-sm-5 col-xs-5">
              <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/CONTACT_DETAILS.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
