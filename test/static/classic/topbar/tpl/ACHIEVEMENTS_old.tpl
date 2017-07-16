<style>
input::-webkit-outer-spin-button, /* Removes arrows */
input::-webkit-inner-spin-button, /* Removes arrows */
input::-webkit-clear-button { /* Removes blue cross */
  -webkit-appearance: none;
  margin: 0;
}
</style>
<script>
refresh();
  function refresh() {
    $.post('/cv/getinfo',{'get':'ACHIEVEMENTS'},function(data)
    {
      var obj = $.parseJSON(data);
      if(obj.resp == 0 )
      {
        $('.honform').show();
        $('.prevhon').hide();
        $('.tab-pane').css('opacity','1');
        $('.tab-pane').asScrollable('update');
      }
      else
      {
        var expstr = '';
        $.each(obj.msg, function(k,v)
        {
          expstr += '<a class="list-group-item" href="javascript:void(0)" >'+
                '<div class="media">'+
                  '<div class="media-left">'+
                    '<div class="avatar avatar-sm avatar-away">'+
                      '<img src="http://placehold.it/30x30" alt="..." />'+
                      '<i></i>'+
                    '</div>'+
                  '</div>'+
                  '<div class="media-body" data-1="'+v.id+'" data-2="'+v.section_title1+'" data-3="'+v.section_title2+'" data-4="'+v.end_date+'" data-5="'+v.more_info1+'" data-6="" data-7="" data-8="">'+
                    '<h4 class="media-heading">'+v.section_title1+'</h4>'+
                    '<small>'+v.section_title2+'</small>'+
                  '</div>'+
                  '<div class="media-right">'+
                    '<i class="icon wb-close delete-exp"'+ 'data-id="'+v.id+'"' + 'style="font-size:10px;color: #DE5C5C;"></i>'+
                  '</div>'+
                '</div>'+
              '</a>';
        });
        expstr += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block form-handle margin-top-20"><i class="icon wb-plus"></i>&nbsp;Add Achievements</button>';
        $('.prevhon').html(expstr);
        $('.prevhon').show();
        $('.honform').hide();
        $('.tab-pane').css('opacity','1');
        $('.form-handle').on('click', function()
        {
          $('.form-handle').hide();
          $('.honform').slideDown('fast', function()
          {
            $('.tab-pane').asScrollable('update');
          });
        });
        $('div.media-body').on('click', function(e)
        {
          if($('.editform').is(':visible'))
          {
            $('.editform').slideUp('fast', function()
            {
              $('.form-handle').slideDown('fast', function()
              {
                $('.tab-pane').asScrollable('update');
              });
            });
          }
          else
          {
            $(".ehole").val($(this).data('2'));
            $(".einme").val($(this).data('3'));
            var res = $(this).data('4').split('-');
              $(".eenmn").val(res[0]);
              $(".eenyr").val(res[1]);
            $(".edeon").html(decodeURIComponent( $(this).data('5')));
            $(".eid").html($(this).data('1'));
            $('.form-handle').hide();
            $('.honform').hide();
            $('.editform').slideDown('fast', function() {
              $('.tab-pane').asScrollable('update');
            });
          }
        });
        var flag = 1;
        $("i.delete-exp").on('click', function(e)
        {
          if(flag)
          {
            var param = {};
            var updid = $(this).data('id');
            param.section_type = 'ACHIEVEMENTSDEL';
            param.id = updid;
            $(this).html('<i class="fa fa-pulse fa-spinner"></i>');
            $.post('/cv/fillinfo',{'param':param},function(data)
            {
              $('.honform').trigger('reset');
              refresh();
              flag = 1;
              $(this).html('');
              buildresume();
            });
            $('.editform').hide();
            $('.tab-pane').asScrollable('update');
          }
        });
      }
    });
  }
  
  var flag = 1;
  $('.refresh').on('click', function()
  {
    if(flag)
    {
      $('.refresh').html('<i class="fa fa-pulse fa-spinner"></i>');
      flag = 0;
      var param = {};
      param.section_type = 'ACHIEVEMENTS';
      param.section_title1 = $(".hole").val();
      param.section_title2 = $(".inme").val();
      param.end_date = $(".enmn").val()+' - '+$(".enyr").val();
      param.more_info1 = encodeURIComponent($(".deon").val());
      
      $.post('/cv/fillinfo',{'param':param},function(data)
      {
        $('.honform').trigger('reset');
        refresh();
        $('.refresh').html('SAVE');
        flag = 1;
        buildresume();
      });
    }
  });
  
  $('.update').on('click', function()
  {
    if(flag)
    {
      $('.update').html('<i class="fa fa-pulse fa-spinner"></i>');
      flag = 0;
      var param = {};
      param.id = $(".eid").html();
      param.section_type = 'ACHIEVEMENTSUPD';
      param.section_title1 = $(".ehole").val();
      param.section_title2 = $(".einme").val();
      param.end_date = $(".eenmn").val()+' - '+$(".eenyr").val();
      param.more_info1 =  encodeURIComponent($(".edeon").val());
      
      $.post('/cv/fillinfo',{'param':param},function(data)
      {
        $('.editform').slideUp();
        refresh();
        $('.update').html('SAVE');
        flag = 1;
        buildresume();
      });
    }
  });
  
  $(".seol").on('change',function() {
    $.post('/cv/section_toggle',{'param':$(this).is(":checked")+"-ACHIEVEMENTS"},function(data)
    {
      
      //alert(data);
    });
  });
    
</script>

<!-- nav-tabs -->
<ul class="site-sidebar-nav nav nav-tabs nav-justified nav-tabs-line" role="tablist">
  <li style="cursor:pointer;" role="presentation">
    <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/sections.tpl">
      &nbsp;&nbsp;&nbsp;&nbsp;
      
<img src="data:image/png;base64,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">&nbsp;&nbsp;
    </a>
  </li>
  <li role="presentation">
    <a>
      <i class="icon wb-chevron-left" style="cursor:pointer;" data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PROJECTS.tpl"></i>
      <span style="font-weight:500;color:#66AAEA;border-bottom: 2px solid #62a8ea;">ACHIEVEMENTS</span>
    </a>
  </li>
  <li style="cursor:pointer;font-weight:400;" role="presentation">
    <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/CERTIFICATIONS.tpl"><span style="background: -webkit-linear-gradient(left,#76838F, #fff);-webkit-background-clip: text;-webkit-text-fill-color: transparent;">CERTIFICATIONS</span>
      <i class="icon wb-chevron-right" style="color:#66AAEA" aria-hidden="true"></i>
    </a>
  </li>
</ul>

<div class="site-sidebar-tab-content tab-content">

  
  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">
    
    
      <div class="">
        <div class="">
          <span>Showcase recognitions you have earned</span>
          <br><br>
          <div class="list-group prevhon">
          </div>
          <form class="honform">
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control empty hole" />
              <label class="floating-label"> Title</label>
            </div>
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control empty inme" />
              <label class="floating-label"> INSTITUTION/COMPANY NAME</label>
            </div>
            
            <div class="row">
              <div class="col-sm-4">
                <div class="form-group form-material floating">
                  <select class="form-control enmn">
                    <option value="">Month</option>
                    <option value="01">January</option>
                    <option value="02">February</option>
                    <option value="03">March</option>
                    <option value="04">April</option>
                    <option value="05">May</option>
                    <option value="06">June</option>
                    <option value="07">July</option>
                    <option value="08">August</option>
                    <option value="09">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                  </select>
                  <label class="floating-label">End Date</label>
                </div>
              </div>
              <div class="col-sm-4">
                <div class="form-group form-material floating">
                  <select class="form-control enyr">
                    <option value="">Year</option>
                    <option value="2001">2001</option>
                      <option value="2002">2002</option>
                      <option value="2003">2003</option>
                      <option value="2004">2004</option>
                      <option value="2005">2005</option>
                      <option value="2006">2006</option>
                      <option value="2007">2007</option>
                      <option value="2008">2008</option>
                      <option value="2009">2009</option>
                      <option value="2010">2010</option>
                      <option value="2011">2011</option>
                      <option value="2012">2012</option>
                      <option value="2013">2013</option>
                      <option value="2014">2014</option>
                      <option value="2015">2015</option>
                      <option value="2016">2016</option>
                      <option value="2017">2017</option>
                      <option value="2018">2018</option>
                      <option value="2019">2019</option>
                      <option value="2020">2020</option>
                      <option value="2021">2021</option>
                      <option value="2022">2022</option>
                      <option value="2023">2023</option>
                      <option value="2024">2024</option>
                      <option value="2025">2025</option>
                      <option value="2026">2026</option>
                      <option value="2027">2027</option>
                      <option value="2028">2028</option>
                      <option value="2029">2029</option>
                      <option value="2030">2030</option>
                      <option value="2031">2031</option>
                  </select>
                </div>
              </div>
            </div>
            
            
            <div class="form-group form-material floating">
              <textarea class="form-control deon empty" rows="3" ></textarea>
              <label class="floating-label">Description</label>
            </div>
          
            <div class="row ">
                <button type="button" class="btn btn-sm btn-outline btn-primary refresh width-250 font-weight-500 center-block margin-bottom-50">SAVE</button>
            </div>
            
            
          </form>
          
          <form class='editform margin-top-20' style="display:none">
            <span class="eid" style="display:none;"></span>
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control ehole" />
              <label class="floating-label"> Title</label>
            </div>
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control einme" />
              <label class="floating-label"> INSTITUTION/COMPANY NAME</label>
            </div>
            
            <div class="row">
              <div class="col-sm-4">
                <div class="form-group form-material floating">
                  <select class="form-control eenmn">
                    <option value=""></option>
                    <option value="01">January</option>
                    <option value="02">February</option>
                    <option value="03">March</option>
                    <option value="04">April</option>
                    <option value="05">May</option>
                    <option value="06">June</option>
                    <option value="07">July</option>
                    <option value="08">August</option>
                    <option value="09">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                  </select>
                  <label class="floating-label">End Date</label>
                </div>
              </div>
              <div class="col-sm-4">
                <div class="form-group form-material floating">
                  <select class="form-control eenyr">
                    <option value="">&nbsp;</option>
                    <option value="2001">2001</option>
                      <option value="2002">2002</option>
                      <option value="2003">2003</option>
                      <option value="2004">2004</option>
                      <option value="2005">2005</option>
                      <option value="2006">2006</option>
                      <option value="2007">2007</option>
                      <option value="2008">2008</option>
                      <option value="2009">2009</option>
                      <option value="2010">2010</option>
                      <option value="2011">2011</option>
                      <option value="2012">2012</option>
                      <option value="2013">2013</option>
                      <option value="2014">2014</option>
                      <option value="2015">2015</option>
                      <option value="2016">2016</option>
                      <option value="2017">2017</option>
                      <option value="2018">2018</option>
                      <option value="2019">2019</option>
                      <option value="2020">2020</option>
                      <option value="2021">2021</option>
                      <option value="2022">2022</option>
                      <option value="2023">2023</option>
                      <option value="2024">2024</option>
                      <option value="2025">2025</option>
                      <option value="2026">2026</option>
                      <option value="2027">2027</option>
                      <option value="2028">2028</option>
                      <option value="2029">2029</option>
                      <option value="2030">2030</option>
                      <option value="2031">2031</option>
                  </select>
                </div>
              </div>
            </div>
            
            <div class="form-group form-material floating">
              <textarea class="form-control edeon" rows="3" ></textarea>
              <label class="floating-label">Description</label>
            </div>
            
            <div class="row">
                <button type="button" class="btn btn-sm btn-outline btn-primary width-250 font-weight-500 center-block update margin-bottom-20">SAVE</button>
            </div>
            
          </form>
        </div>
      </div>
  </div>
</div>
