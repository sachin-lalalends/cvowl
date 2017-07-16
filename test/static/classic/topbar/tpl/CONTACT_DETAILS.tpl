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
  
  refresh();
  
  function refresh() {
    init();
    console.log("refresh()");
    
    if(Data.Profile.phone != null && Data.Profile.phone != "")
    $('.sec1').val(Data.Profile.phone);
    else
    $('.sec1').addClass("empty");
    
    var regex = /<br\s*[\/]?>/gi;
    if(Data.Profile.location.address != null && Data.Profile.location.address != "")
    $('.sec2').val(decodeURIComponent(Data.Profile.location.address).replace(regex, "\n"));
    else
    $('.sec2').addClass("empty");
    
    if(Data.Profile.location.state != null && Data.Profile.location.state != "")
    $('.sec3').val(Data.Profile.location.state);
    else
    $('.sec3').addClass("empty");
    
    if(Data.Profile.location.postalCode != null && Data.Profile.location.postalCode != "")
    $('.sec4').val(Data.Profile.location.postalCode);
    else
    $('.sec4').addClass("empty");
    
    if(Data.Profile.location.country != null && Data.Profile.location.country != "")
    $('.sec5').val(Data.Profile.location.country);
    else
    $('.sec5').addClass("empty");
    
    if(Data.Profile.facebookHandle != null && Data.Profile.facebookHandle != "")
    $('.sec6').val('facebook.com/'+Data.Profile.facebookHandle);
    else
    $('.sec6').val('facebook.com/');
      
    
    if(Data.Profile.linkedinHandle != null && Data.Profile.linkedinHandle != "")
    $('.sec7').val('linkedin.com/'+Data.Profile.linkedinHandle);
    else
    $('.sec7').val('linkedin.com/');
    
    if(Data.Profile.location.city != null && Data.Profile.location.city != "")
    $('.sec8').val(Data.Profile.location.city);
    
  }
  
  $('.sec1').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.phone = $('.sec1').val();
    $("#phone").html(Data.Profile.phone);
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec2').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.address = $('.sec2').val().replace(/\n/g, "<br>");
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec3').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.state = $('.sec3').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec4').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.postalCode = $('.sec4').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec5').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.country = $('.sec5').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec6').on('input', function(e) {
    init();
    console.log("updateRecord()");
    var str = $('.sec6').val();
    if(str == "facebook.com"){
      str = '';
    }
    if(!str.indexOf('facebook.com/') == 0){
      $('.sec6').val('facebook.com/'+str);
    }else{
      str = str.slice(13);
    }
    Data.Profile.facebookHandle = str;
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec7').on('input', function(e) {
    init();
    console.log("updateRecord()");
    var str = $('.sec7').val();
    if(str == "linkedin.com"){
      str = '';
    }
    if(!str.indexOf('linkedin.com/') == 0){
      $('.sec7').val('linkedin.com/'+str);
    }else{
      str = str.slice(13);
    }
    Data.Profile.linkedinHandle = str;
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
  });
  
  $('.sec8').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.city = $('.sec8').val();
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
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PERSONAL_DETAILS.tpl"><span>PERSONAL</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="Presentation">
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/CONTACT_DETAILS.tpl"><span>CONTACT</span>
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
          <span class="slidePanel-desc">Enter details on how to reach you and contact you</span>
          <br>
          <br>
          <div class="form-group form-material floating">
            <input class="form-control empty sec6" name="facebook_url" type="text">
          </div>

          <div class="form-group form-material floating" style="margin-top: 20px;">
            <input class="form-control empty sec7" name="linkedin_url" type="text">
          </div>
          
          <div class="form-group form-material floating">
            <input type="text" class="form-control sec1" />
            <label class="floating-label">Mobile Number</label>
          </div>
          
          <div class="form-group form-material floating">
            <textarea class="form-control sec2" rows="2" ></textarea>
            <label class="floating-label">Address</label>
          </div>
          
          <div class="row" style="display:none;">
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control sec8"/>
                <label class="floating-label">City</label>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control sec3" />
                <label class="floating-label">State</label>
              </div>
            </div>
          </div>
          
          <div class="row" style="display:none;">
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control sec4"/>
                <label class="floating-label">ZIP Code</label>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group form-material floating">
                <input type="text" class="form-control sec5"/>
                <label class="floating-label">Country</label>
              </div>
            </div>
          </div>
          
          <div class="row margin-bottom-50 margin-top-50">
            <div class="col-sm-7 col-xs-7">
            </div>
            <div class="col-sm-5 col-xs-5">
              <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/WORKLINKS.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
  $(".moer").on('keypress blur', function(e) {
    var k = e.keyCode || e.which;
    var id = $(this)[0].id;
    var str = $(this)[0].value;
    var length = str.length;
    if (e.type == 'keypress') {
      if (k != 8 && k != 9) {
        k = String.fromCharCode(k);
        var regex = /[0-9-,+, ]/;
        if (!regex.test(k)) {
          return false;
        }
        if (length >= 15) {
          return false;
        }
      }
      return true;
    }
    else if (e.type == 'blur') {
      var regex = /[0-9-,+, ]/;
      if (!regex.test(str)) {

        $('#' + id).val('');
      }
      else {
        if (length >= 15) {
          $('#' + id).val('');
          return false;
        }
      }
    }
  });
  $("#fime,#lame,.naty").on('keypress blur', function(e) {
    var k = e.keyCode || e.which;
    var id = $(this)[0].id;
    var str = $(this)[0].value;
    var length = str.length;
    if (e.type == 'keypress') {
      if (k != 8 && k != 9) {
        k = String.fromCharCode(k);
        var regex = /[A-Za-z]/;
        if (!regex.test(k)) {
          return false;
        }
      }
      return true;
    }
    else if (e.type == 'blur') {
      var regex = /^[A-Za-z]+$/;
      if (!regex.test(str)) {
        $("#" + id).val('');
      }
      return true;
    }
  });
</script>
