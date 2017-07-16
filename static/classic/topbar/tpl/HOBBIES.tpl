 
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

  #request_hobby{
    font-size: 0.85em;
    padding-left: 0px;
    padding-right: 0px; 
    padding-bottom: 10px;
    color: #d50000;
  }

</style>


<script>

  $.post('/hobbies/all',{},function(res){
        
    var obj = $.parseJSON(res);
    if(obj.resp == 1){
      var str = "<option selected disabled>Please choose your Hobbies</option>";
      $.each(obj.msg, function(k,v){
        str += '<option value="'+v.hobbie+'">'+v.hobbie+'</option>';
      });
      $('.sec1').html(str);
    }
  });
  
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

    var temp = '<span class="allowSort">';
    var id = 0;
    $.each(Data.Hobbies, function(k, v) {
      if (v != null && v.section_type == "HOBBIES") {
        
        temp += '<div class="col-xs-4 col-sm-4">';
        temp += '<div class="example">';
        temp += '<a class="thumbnail" href="javascript:void(0)">';
        temp += '<span class="badge badge-danger up pull-right"><i class="fa fa-close delete" data-key="'+k+'"></i></span>';
        temp += '<img src="/static/classic/topbar/assets/hobbies/'+v.section_title1.toLowerCase().split(' ').join('_')+'.svg" alt="...">';
        temp += '</a>';
        temp += '</div>';
        temp += '</div>';
        
      }
    });
    temp += '</span>';

    //temp += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block addnewBtn margin-top-20 margin-bottom-50"><i class="icon wb-plus"></i>&nbsp;Add Skill</button>';


    $('.hobbie-container').html(temp);
    
    $('.data-container').show();
    //$('.newForm').hide();
    $('.tab-pane').asScrollable('update');



    $("i.delete").on('click', function(e) {
      deleteRecord($(this).data('key'));
    });

    $("i.visibility").on('click', function(e) {
      changeVisibility($(this).data('key'), $(this).data('status'));
    });

  }

  
  $('.tab-pane').css('opacity', '1');
  
  var param = {
    is_active: 1,
    order_prefs: 999,
    section_title1: null,
    section_type: "HOBBIES",
  };


  function deleteRecord(key) {
    init();
    console.log("deleteRecord()");
    var r = confirm("Are you sure you want to delete this ?");
      if (r == true) {
        delete Data.Hobbies[key];
        localStorage.setItem("data", JSON.stringify(Data));
        localStorage.setItem("modified_dt", Date.now());
        buildresume();
        refresh();
      }
  }

  function addRecord() {
    init();
    console.log("addRecord()");
    param.section_title1 = $(".sec1").val();
    if(Data.Hobbies.length < 3){
      Data.Hobbies.push(param);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
      refresh();
    }else{
      alert("Its not good to add more than 3 hobbies.");
    }
    
  }

  function changeVisibility(key, status) {
    console.log("changeVisibility()");
    if (status == 1) {
      Data.Hobbies[key].is_active = 0;
    }
    else {
      Data.Hobbies[key].is_active = 1;
    }
    localStorage.setItem("data", JSON.stringify(Data));
    localStorage.setItem("modified_dt", Date.now());
    buildresume();
    refresh();
  }

  $(".add_new").on('click', function(e) {
    addRecord();
    $('.newForm').trigger('reset');
  });

  $('#request_hobby').click(function(event) {
  	/* Act on the event */
  	$('.NewHobbie-form').toggle("fast");
  });

  $('#requestHobbie').on('click',function(event) {
  	var hobbie = $('#NewHobbie').val();
  	if(hobbie.length > 3){
  		$.post('/hobbies/add', {'hobbie': hobbie}, function(res) {
		  var obj = $.parseJSON(res);
		  if(obj.resp == 1){
        console.log(obj);
        console.log(res);
      	$('#NewHobbie').val('');
        $(".NewHobbie-form").hide("fast");
        $("#hobby_requested").slideDown("fast");
        $("#hobby_requested").delay(3000).slideUp("fast");
      }
      else{
        alert(obj.msg); //have to put something else here
      }
    });
    }else{
      $('#NewHobbie').val();
      alert('Hobbie name should be more than 3 character only alphabets and space');
    }
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
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/HOBBIES.tpl"><span>HOBBIES</span>
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
        <span class="slidePanel-desc">Choose your hobbies you like</span>
        <br>
        <br>
        <div class=" data-container">
        </div>
        <div class="newForm">
          <div class="form-group form-material">
            <div class="row">
              <div class="col-xs-10">
                <select class="form-control sec1"  name="inputFloatingText">
                  
                </select>
            	  
              </div>
              
              <div class="col-xs-2">
                <button type="button" class="btn btn-success btn-xs add_new">ADD</button>
              </div>
            </div>
          </div>
          <div class="hobbie-container">
          </div>
          
        </div>
        <div style="clear:both">
          <br/>
          <span class="slidePanel-desc btn pull-right" id="request_hobby">Request a new hobby</span>
          <br>
          <br>
        </div>
        <br>
        <div>
          <div class="form-group form-material">
            <div class="row NewHobbie-form" style="display:none">
              <div class="col-xs-9">
                <input class="form-control" id="NewHobbie"  name="NewHobbie" placeholder="Enter hobby name"/>
              </div>
              
              <div class="col-xs-3">
                <button type="button" class="btn btn-success btn-xs" id="requestHobbie" style="padding-right: 14px;padding-left: 14px;">Request</button><br>
              </div>
            </div>
            <span class="slidePanel-desc btn btn-success btn-lg" id="hobby_requested" style="color:white; font-size:1.1em;margin-top:10px; display:none; font-weight:700;">Hobby Requested!</span>
          </div>
        </div>
        <div class="row margin-bottom-50 margin-top-50">
          <div class="col-sm-7 col-xs-7">
          </div>
          <div class="col-sm-5 col-xs-5">
            <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PERSONAL_DETAILS.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
          </div>
        </div>
      </div>
    </div>

  </div>

</div>
