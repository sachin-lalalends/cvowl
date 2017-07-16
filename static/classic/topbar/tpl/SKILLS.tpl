<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
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

<style type="text/css">
  .btn-tags{
    margin:5px;
    border-radius: 10px;
    background: #F2F2F2;
    color: #3B3B3B;
    font-weight: 400;
    font-size: 10px;
  }
</style>


<script>
  var Data;

  var tempData = localStorage.getItem("data");
  tempData = $.parseJSON(tempData);
  $.post('/skills/get',{'title':tempData.Profile.jobTitle},function(data){
    var obj = $.parseJSON(data);
    if(obj.resp ==1){

      var result = 0;
      $.each(obj.msg, function(k,v){
          result = $.grep(tempData.Skill, function(e){ return e.section_title1 == v.tag_name; });
          if(!result.length)
            $('#skill-suggester').append('<button type="button" class="btn btn-link btn-tags" data-skill="'+v.tag_name+'">'+v.tag_name+'</i> </button>');
      });

      $( "[data-skill]" ).click(function(e){
        var status = addSugesstion($(this).data('skill'));
        if(status){
          $(this).remove();
        }else{
          $(this).remove();
        }
      });
    }

    
  });

  function init() {
    console.log("init()");
    Data = localStorage.getItem("data");
    Data = $.parseJSON(Data);

    Data.Skill.sort(function(a, b) {
      if (a == null || b == null) return 0;
      return parseFloat(a.order_prefs) - parseFloat(b.order_prefs);
    });


  }

  refresh();

  $('.tab-pane').css('opacity', '1');
  function refresh() {
    init();
    console.log("refresh()");

    var temp = '<span class="allowSort">';
    var id = 0;
    $.each(Data.Skill, function(k, v) {
      if (v != null && v.section_type == "SKILL") {

        temp += '<div class="form-group form-material row">' +
          '<div class="input-group">' +
          '<div class="col-xs-5">' +
          '<input type="text" class="form-control empty esec1" placeholder="Skill Name" onkeyup="updateRecord('+k+',this);" value="' + v.section_title1 + '">' +
          '</div>' +
          '<div class="col-xs-5">' +
          '<select class="form-control empty esec2"  onchange="updateRecord('+k+',this);">' +
          '<option disabled>Proficiency </option>' +
          '<option value="Beginner"';
        if (v.section_title2 == "Beginner") {
          temp += 'selected';

        }
        temp += '>Beginner</option>' +
          '<option value="Intermediate"';
        if (v.section_title2 == "Intermediate") {
          temp += 'selected';

        }
        temp += '>Intermediate</option>' +
          '<option value="Advanced"';
        if (v.section_title2 == "Advanced") {
          temp += 'selected';

        }
        temp += '>Advanced</option>' +
          '<option value="Expert"';
        if (v.section_title2 == "Expert") {
          temp += 'selected';

        }
        temp += '>Expert</option>' +
          '</select>' +
          '</div>' +
          '<div class="col-xs-2 no-line-break">';
        if (v.is_active == 1) {
          temp += '<i class="icon wb-eye visibility"' + 'data-key="' + k + '"' + 'data-status="' + v.is_active + '"' + 'style="font-size:10px;color: #76838f;    margin-top: 13px;"></i>&nbsp;&nbsp;';
        }
        else {
          temp += '<i class="icon wb-eye-close visibility"' + 'data-key="' + k + '"' + 'data-status="' + v.is_active + '"' + 'style="font-size:10px;color: #76838f;    margin-top: 13px;"></i>&nbsp;&nbsp;';
        }
        temp += '<i class="icon wb-close delete"' + 'data-key="' + k + '"' + 'style="font-size:10px;color: #DE5C5C;"></i>';
        temp += '</div>' +
          '</div>' +
          '</div>';
      }
    });
    temp += '</span>';

    //temp += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block addnewBtn margin-top-20 margin-bottom-50"><i class="icon wb-plus"></i>&nbsp;Add Skill</button>';


    $('.data-container').html(temp);
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

  var param = {
    is_active: 1,
    order_prefs: 999,
    section_title1: null,
    section_title2: null,
    section_type: "SKILL",
  };

  function updateRecord(key,context) {
    init();
    console.log("updateRecord()");
    
    if (Data.Skill[key] != null && Data.Skill[key].section_type == "SKILL") {
      if($(context).hasClass('esec1')){
        
        $('[data-for="SKL-' + key + '"] .E1').html(context.value);
        Data.Skill[key].section_title1 = context.value;
        localStorage.setItem("data", JSON.stringify(Data));
        localStorage.setItem("modified_dt", Date.now());
        
      }else if($(context).hasClass('esec2')){
        Data.Skill[key].section_title2 = context.value;
        localStorage.setItem("data", JSON.stringify(Data));
        localStorage.setItem("modified_dt", Date.now());
        buildresume();
      }
      else{
        return false;
      }
    }
  }

  function deleteRecord(key) {
    init();
    console.log("deleteRecord()");
    var r = confirm("Are you sure you want to delete this Record?");
      if (r == true) {
        delete Data.Skill[key];
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
    param.section_title2 = $(".sec2").val();

    if(param.section_title1!=""){
      Data.Skill.push(param);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
      refresh();
    }
  }

  function addSugesstion(skill,prof="Advanced"){
    init();
    
    var is_exist = 0;
    $.each(Data.Skill,function(k,v){
      if(v.section_title1 == skill){
        is_exist = 1;
      }
    });

    if(is_exist)
      return false;

    console.log("addSuggestion() addRecord()");

    param.section_title1 = skill;
    param.section_title2 = prof;

    if(param.section_title1!=""){
      Data.Skill.push(param);
      localStorage.setItem("data", JSON.stringify(Data));
      localStorage.setItem("modified_dt", Date.now());
      buildresume();
      refresh();
    }

    return true;
  }

  function changeVisibility(key, status) {
    console.log("changeVisibility()");
    if (status == 1) {
      Data.Skill[key].is_active = 0;
    }
    else {
      Data.Skill[key].is_active = 1;
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
        <a class="active_menu" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/SKILLS.tpl"><span>SKILLS</span>
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
        <span class="slidePanel-desc">Enter your skills &  rate you proficiency</span>
        <br>
        <br>
        <div class="row" style="margin:5px 0px;" id="skill-suggester">
        </div>
        <div class=" data-container">
        </div>
        <form class="newForm">
          <div class="form-group form-material row">
            <div class="input-group">
              <div class="col-xs-5">
                <input type="text" class="form-control empty sec1" placeholder="Skill Name">
              </div>
              <div class="col-xs-5">
                <select class="form-control empty sec2">
                  <option disabled>Proficiency </option>
                  <option value="Beginner">Beginner</option>
                  <option value="Intermediate">Intermediate</option>
                  <option value="Advanced">Advanced</option>
                  <option value="Expert">Expert</option>
                </select>
              </div>
              <div class="col-xs-2 no-line-break">
                <Button type="button" class="btn btn-success btn-xs add_new">ADD</button>
              </div>
            </div>
          </div>
        </form>
        <div class="row margin-bottom-50 margin-top-50">
          <div class="col-sm-7 col-xs-7">
          </div>
          <div class="col-sm-5 col-xs-5">
            <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PROJECTS.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
          </div>
        </div>
        
      </div>
    </div>

  </div>

</div>
