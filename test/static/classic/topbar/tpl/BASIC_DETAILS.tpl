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
    
    if(Data.Profile.phone != null && Data.Profile.phone != "")
    $('.sec1').val(Data.Profile.phone);
    else
    $('.sec1').addClass("empty");
    
    if(Data.Profile.location.address != null && Data.Profile.location.address != "")
    $('.sec2').val(Data.Profile.location.address);
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
    if(Data.Profile.location.city != null && Data.Profile.location.city != "")
    $('.sec8').val(Data.Profile.location.city);

    if(Data.Profile.coverletterDate != null && Data.Profile.coverletterDate != "")
    {
      var res = Data.Profile.coverletterDate.split(" ");
      $('.date').val(res[0]);
      $('.month').val(res[1]);
      $('.year').val(res[2]);
    }
    
  }
  
  $('.sec1').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.phone = $('.sec1').val();
    $("#phone").html(Data.Profile.phone);
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildcoverletter();
  });
  
  $('.sec2').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.address = $('.sec2').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildcoverletter();
  });
  
  $('.sec3').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.state = $('.sec3').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildcoverletter();
  });
  
  $('.sec4').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.postalCode = $('.sec4').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildcoverletter();
  });
  
  $('.sec5').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.country = $('.sec5').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildcoverletter();
  });
  
  $('.sec8').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.location.city = $('.sec8').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildcoverletter();
  });

  $('.date, .month, .year').on('input', function(e) {
    init();
    console.log("updateRecord()");
    Data.Profile.coverletterDate = $('.date').val()+" "+$('.month').val()+" "+$('.year').val();
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildcoverletter();
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
  <div style="float:left;width:8%;line-height: 45px;text-align: right;font-size:16px;color: #474747;cursor:pointer;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/COVER_LETTER.tpl">
      <i class="icon wb-menu"></i>
  </div>
  <div id="prev_btn" style="float:left;width:10%;line-height: 45px;font-size: 16px;text-align: center;cursor:pointer;">
    <i class="icon wb-chevron-left"></i>
  </div>
  <div style="float:left;width:64%;line-height: 45px;">
    <div class="mobile_menu_content" data-plugin="scrollable" style="padding-bottom:0px;width:100%;overflow: hidden;">
    
    <ul class="site-sidebar-nav nav nav-tabs nav-justified nav-tabs-line scrollable scrollable-horizontal" role="tablist" >
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/BASIC_DETAILS.tpl"><span>BASIC DETAILS</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/RECRUITER_DETAILS.tpl"><span>RECRUITER DETAILS</span>
        </a>
      </li>
      <li style="cursor:pointer;font-weight:400;" role="Presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/LETTER_DESC.tpl"><span>DESCRIPTION</span>
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


<div class="site-sidebar-tab-content tab-content">
  <div class="tab-pane fade active in" id="sidebar-editing">
    <div>
      <div>
        <form class="margin-bottom-50">
          <span class="slidePanel-desc">Enter details on how to reach you and contact you</span>
          <br>
          <br>
          
          <div class="form-group form-material floating">
            <input type="text" class="form-control sec1" />
            <label class="floating-label">Mobile Number</label>
          </div>
          
          <div class="form-group form-material floating">
            <textarea class="form-control sec2" rows="2" ></textarea>
            <label class="floating-label">Address</label>
          </div>

          <div class="row">
            <div class="col-md-4">
              <div class="form-group form-material floating">
                <select class="form-control date">
                </select>
                <label class="floating-label">Date</label>
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
          
          <!-- <div class="row">
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
          
          <div class="row">
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
          </div> -->
          
          <div class="row margin-bottom-50 margin-top-50">
            <div class="col-sm-7 col-xs-7">
            </div>
            <div class="col-sm-5 col-xs-5">
              <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/RECRUITER_DETAILS.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
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
