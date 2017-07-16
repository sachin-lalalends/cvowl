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
  
  .btn-select{
    border:0px;
    border-bottom: 1px #aaaaaa solid;
    border-radius: 0px;
  }
  .btn-group.open{
    border: 0px !important;
    border-bottom:1px black solid;
    -webkit-box-shadow: none;
    box-shadow: none;
  }
  .btn-group.open .btn-select, .btn-select:focus {
      border:0px !important;
      border-bottom:1px #aaaaaa solid;
      -webkit-box-shadow: none;
      box-shadow: none;
  }
  
  .headings{
        color: rgba(123, 136, 147, 0.79);
        font-weight: 500;
        letter-spacing: 1px;
        margin: 1px;
        margin-left: -2px;
  }
</style>


<script>
  var Data;

  function init() {
    console.log("init()");
    Data = localStorage.getItem("data");
    Data = $.parseJSON(Data);

    Data.Language.sort(function(a, b) {
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
    $.each(Data.Language, function(k, v) {
      if (v != null && v.section_type == "LANGUAGE") {
        console.log(v);

        temp += '<div class="form-group form-material row">'+
                  '<div class="input-group">'+
                    '<div class="col-xs-4">'+
                      '<input type="text" class="form-control empty esec1" placeholder="Language Name" value="'+v.section_title1+'" onkeyup="updateRecord('+k+',this);">'+
                    '</div>'+
                    
                    '<div class="col-xs-2 margin-top-10" style="text-align: center;"><input class="esec2" onchange="updateRecord('+k+',this);" type="checkbox" value="Read"';
                    if (v.section_title2) {
                      temp += 'checked';
                    }
                    temp += '></div>'+
                    '<div class="col-xs-2 margin-top-10" style="text-align: center;"><input class="esec3" onchange="updateRecord('+k+',this);" type="checkbox" value="Write" ';
                    if (v.section_title3) {
                      temp += 'checked';
                    }
                    temp += '></div>'+
                    '<div class="col-xs-2 margin-top-10" style="text-align: center;"><input class="esec4" onchange="updateRecord('+k+',this);" type="checkbox" value="Speak" ';
                    if (v.section_title4) {
                      temp += 'checked';
                    }
                    temp += '></div>'+
                    '<div class="col-xs-2" style="margin-top:3px;">';
                    
                    if (v.is_active == 1) {
                      temp += '<i class="icon wb-eye visibility"' + 'data-key="' + k + '"' + 'data-status="' + v.is_active + '"' + 'style="font-size:10px;color: #76838f;    margin-top: 13px;"></i>&nbsp;&nbsp;';
                    }
                    else {
                      temp += '<i class="icon wb-eye-close visibility"' + 'data-key="' + k + '"' + 'data-status="' + v.is_active + '"' + 'style="font-size:10px;color: #76838f;    margin-top: 13px;"></i>&nbsp;&nbsp;';
                    }
            temp += '<i class="icon wb-close delete"' + 'data-key="' + k + '"' + 'style="font-size:10px;color: #DE5C5C;"></i>'+
                  '</div>'+
                '</div>'+
              '</div>';
          
      }
    });
    temp += '</span>';

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
    section_type: "LANGUAGE",
    start_date: null
  };

  function updateRecord(key,context) {
    init();
    console.log("updateRecord()");
    
    if (Data.Language[key] != null && Data.Language[key].section_type == "LANGUAGE") {
      if($(context).hasClass('esec1')){
        Data.Language[key].section_title1 = context.value;
      }else if($(context).hasClass('esec2')){
          Data.Language[key].section_title2 = context.checked;
      }else if($(context).hasClass('esec3')){
        Data.Language[key].section_title3 = context.checked;
      }else if($(context).hasClass('esec4')){
        Data.Language[key].section_title4 = context.checked;
      }else{
        return false;
      }
      localStorage.setItem("data", JSON.stringify(Data));
      return false;
    }
  }

  function deleteRecord(key) {
    init();
    console.log("deleteRecord()");
    var r = confirm("Are you sure you want to delete this Record?");
      if (r == true) {
        delete Data.Language[key];
        localStorage.setItem("data", JSON.stringify(Data));
        buildresume();
        refresh();
      }
  }

  function addRecord() {
    init();
    console.log("addRecord()");
    param.section_title1 = $(".sec1").val();
    param.section_title2 = $('.sec2').val();
    param.section_title3 = $('.sec3').val();
    param.section_title4 = $('.sec4').val();
    Data.Language.push(param);
    localStorage.setItem("data", JSON.stringify(Data));
    refresh();
  }

  function changeVisibility(key, status) {
    console.log("changeVisibility()");
    if (status == 1) {
      Data.Language[key].is_active = 0;
    }
    else {
      Data.Language[key].is_active = 1;
    }
    localStorage.setItem("data", JSON.stringify(Data));
    buildresume();
    refresh();
  }


  $(".add_new").on('click', function(e) {
    addRecord();
    $('.newForm').trigger('reset');
  });

</script>

<!-- nav-tabs -->
<ul class="site-sidebar-nav nav nav-tabs nav-justified nav-tabs-line" role="tablist">
  <li style="cursor:pointer;" role="presentation">
    <a>
        &nbsp;&nbsp;&nbsp;&nbsp;
      
<img width="30px" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/sections.tpl" src="data:image/png;base64,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">&nbsp;&nbsp;
    </a>
  </li>
  <li role="presentation">
    <a>
      <i class="icon wb-chevron-left" style="cursor:pointer;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/EDUCATION.tpl"></i>
      <span style="font-weight:500;color:#66AAEA;border-bottom: 2px solid #62a8ea;">LANGUAGES</span>
    </a>
  </li>
  <li style="cursor:pointer;font-weight:400;" role="presentation">
    <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/HOBBIES_test.tpl">HOBBIES
    </a>
  </li>
  <li style="cursor:pointer;" role="presentation" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/HOBBIES_test.tpl">
    <a>
      <span style="font-weight:400;background: -webkit-linear-gradient(left,#76838F, #fff);-webkit-background-clip: text;-webkit-text-fill-color: transparent;">PHOT</span>&nbsp;
      <i class="icon wb-chevron-right" style="color:#66AAEA" aria-hidden="true"></i>
    </a>
  </li>
</ul>

<div class="site-sidebar-tab-content tab-content">

  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">

    <div class="">
      <div class="">
        <span class="slidePanel-desc">Specify languages you are familar with</span>
        <br>
        <br>
        <div class="form-group form-material row">
            <div class="col-xs-4 headings">LANGUAGE</div>
            <div class="col-xs-2 headings">READ</div>
            <div class="col-xs-2 headings">WRITE</div>
            <div class="col-xs-2 headings">SPEAK</div>
            <div class="col-xs-2"></div>
        </div>
        
        <div class=" data-container">
          
        </div>
        
        <form class="newForm">
          <div class="form-group form-material row">
            <div class="input-group">
              <div class="col-xs-4">
                <input type="text" class="form-control empty sec1" placeholder="Language Name">
              </div>
              
              <div class="col-xs-2 margin-top-10" style="text-align: center;"><input class="sec2" type="checkbox" value="Read"></div>
              <div class="col-xs-2 margin-top-10" style="text-align: center;"><input class="sec3" type="checkbox" value="Write"></div>
              <div class="col-xs-2 margin-top-10" style="text-align: center;"><input class="sec4" type="checkbox" value="Speak"></div>
              <div class="col-xs-2" style="margin-top:7px;">
                <Button type="button" class="btn btn-success btn-xs add_new">ADD</button>
              </div>
              
            </div>
          </div>
        </form>
        <div class="row margin-bottom-50 margin-top-50">
          <div class="col-sm-7 col-xs-7">
          </div>
          <div class="col-sm-5 col-xs-5">
            <button type="button" class="btn btn-block btn-warning font-weight-400" style="letter-spacing:.1em;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PROJECTS_test.tpl">NEXT&nbsp; <i class="fa fa-chevron-right"></i> </button>
          </div>
        </div>
      </div>
    </div>

  </div>

</div>