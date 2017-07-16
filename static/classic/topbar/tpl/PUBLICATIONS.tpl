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
    $.post('/cv/getinfo',{'get':'PUBLICATIONS'},function(data)
    {
      var obj = $.parseJSON(data);
      if(obj.resp == 0 )
      {
        $('.pubform').show();
        $('.prevpub').hide();
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
        expstr += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block form-handle margin-top-20"><i class="icon wb-plus"></i>&nbsp;Add Patents</button>';
        $('.prevpub').html(expstr);
        $('.prevpub').show();
        $('.pubform').hide();
        $('.tab-pane').css('opacity','1');
        $('.form-handle').on('click', function()
        {
          $('.form-handle').hide();
          $('.pubform').slideDown('fast', function()
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
            $(".epule").val($(this).data('2'));
            $(".epurl").val($(this).data('3'));
            var res = $(this).data('4').split('-');
              $(".eenmn").val(res[0]);
              $(".eenyr").val(res[1]);
            $(".edeon").html($(this).data('5'));
            $(".eid").html($(this).data('1'));
            $('.form-handle').hide();
            $('.pubform').slideUp();
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
            param.section_type = 'PUBLICATIONSDEL';
            param.id = updid;
            $(this).html('<i class="fa fa-pulse fa-spinner"></i>');
            $.post('/cv/fillinfo',{'param':param},function(data)
            {
              $('.pubform').trigger('reset');
              refresh();
              $(this).html('');
              flag = 1;
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
      param.section_type = 'PUBLICATIONS';
      param.section_title1 = $(".pule").val();
      param.section_title2 = $(".purl").val();
      param.end_date = $(".enmn").val()+' - '+$(".enyr").val();
      param.more_info1 = $(".deon").val();
      
      $.post('/cv/fillinfo',{'param':param},function(data)
      {
        $('.pubform').trigger('reset');
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
      flag = 0;
      $('.update').html('<i class="fa fa-pulse fa-spinner"></i>');
      var param = {};
      param.id = $(".eid").html();
      param.section_type = 'PATENTSUPD';
      param.section_title1 = $(".epule").val();
      param.section_title2 = $(".epurl").val();
      param.end_date = $(".eenmn").val()+' - '+$(".eenyr").val();
      param.more_info1 = $(".edeon").html();
      
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
    
</script>


<div class="site-sidebar-tab-content tab-content">

  
  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">
    <!-- nav-tabs -->
    <ul class=" nav nav-tabs nav-justified nav-tabs-line" data-plugin="nav-tabs"
    role="tablist">
      <li style="cursor:pointer;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="/static/classic/topbar/tpl/sections.tpl">
          <i class="icon wb-chevron-left" aria-hidden="true"></i>Sections
        </a>
      </li>
      <li class="active" role="presentation">
        <a style="font-weight:400;">
          <span style="font-size:12px">PUBLICATIONS</span>
        </a>
      </li>
      <li style="cursor:pointer;" role="presentation">
        <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/SKILLS.tpl">
          Next &nbsp;<i class="icon wb-chevron-right" aria-hidden="true"></i>
        </a>
      </li>
    </ul>
      <div class="">
        <div class="">
          <div class="list-group prevpub">
          </div>
          
          <form class="pubform">
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control empty pule" />
              <label class="floating-label">Publication Title</label>
            </div>
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control empty purl" />
              <label class="floating-label">Publication URL</label>
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
              <input type="text" class="form-control epule" />
              <label class="floating-label">Publication Title</label>
            </div>
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control epurl" />
              <label class="floating-label">Publication URL</label>
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
