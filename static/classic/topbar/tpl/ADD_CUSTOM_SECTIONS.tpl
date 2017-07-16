<script>
refresh();
  function refresh() {
    $.post('/cv/getinfo',{'get':'WORKPERMIT'},function(data)
    {
      var obj = $.parseJSON(data);
      if(obj.resp == 0 )
      {
        $('.workform').show();
        $('.workskill').hide();
        $('.tab-pane').css('opacity','1');
        $('.tab-pane').asScrollable('update');
      }
      else
      {
        var expstr = '';
        var form = '';
        $.each(obj.msg, function(k,v)
        {
          form = '<form class="padding-left-30 padding-right-30 editform edit-'+v.id+' margin-top-20" style="display:none;"><span class="eid" style="display:none;"></span><div class="form-group form-material floating"><input type="text" class="form-control eplce" /><label class="floating-label">Place</label></div><div class="form-group form-material row "><button type="button" class="btn btn-sm btn-outline btn-primary width-250 font-weight-500 center-block update margin-bottom-20">SAVE</button></div></form>';
          expstr += '<a class="list-group-item" href="javascript:void(0)" >'+
                '<div class="media">'+
                  '<div class="media-left">'+
                    '<div class="avatar avatar-sm avatar-away">'+
                      '<img src="http://placehold.it/30x30" alt="..." />'+
                      '<i></i>'+
                    '</div>'+
                  '</div>'+
                  '<div class="media-body" data-1="'+v.id+'" data-2="'+v.section_title1+'" data-3="" data-4="'+v.section_name+'">'+
                    '<h4 class="media-heading">'+v.section_title1+'</h4>'+
                  '</div>'+
                  '<div class="media-right">'+
                    '<i class="icon wb-close delete-exp"'+ 'data-id="'+v.id+'"' + 'style="font-size:10px;color: #DE5C5C;"></i>'+
                  '</div>'+
                '</div>'+
              '</a>'+
              form;
        });
        expstr += '<button type="button" class="btn btn-sm btn-outline btn-default width-250 font-weight-400 center-block form-handle margin-top-20 margin-bottom-50"><i class="icon wb-plus"></i>&nbsp;Add WORKPERMIT</button>';
        $('.workskill').html(expstr);
        $('.workskill').show();
        $('.workform').hide();
        $('.tab-pane').css('opacity','1');
        $('.form-handle').on('click', function()
        {
          $('.form-handle').hide();
          $('.editform').slideUp('fast');
          
          $('.workform').slideDown('fast', function()
          {
            $('.tab-pane').asScrollable('update');
          });
        });
        $('div.media-body').on('click', function(e)
        {
          
          if($('.edit-'+$(this).data('1')).is(':visible'))
          {
            
            $('.edit-'+$(this).data('1')).slideUp('fast', function()
            {
                $('.tab-pane').asScrollable('update');
              //$('.form-handle').slideDown('fast', function() {});
            });
          }
          else
          {
            $('.editform').slideUp('fast');
            $(".edit-"+$(this).data('1')+" "+".eid").html($(this).data('1'));
            $(".edit-"+$(this).data('1')+" "+".eplce").val($(this).data('2'));
            //$('.form-handle').hide();
            //$('.workform').slideUp();
            $('.edit-'+$(this).data('1')).slideDown();
            $('.edit-'+$(this).data('1')).slideDown('fast', function() {
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
            param.section_type = 'WORKPERMITDEL';
            param.id = updid;
            
            $.post('/cv/fillinfo',{'param':param},function(data)
            {
              $('.workform').trigger('reset');
              refresh();
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
      param.section_type = 'WORKPERMIT';
      param.section_title1 = $(".plce").val();
      
      $.post('/cv/fillinfo',{'param':param},function(data)
      {
        
        $('.workform').trigger('reset');
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
      param.section_type = 'WORKPERMITUPD';
      param.section_title1 = $(".eplce").val();
      
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
      WORKPERMIT
    </a>
  </li>
  <li style="cursor:pointer;" role="presentation">
    <a data-toggle="slidePanel" aria-hidden="true" data-url="../../static/classic/topbar/tpl/PHOTOS.tpl">
      Next &nbsp;<i class="icon wb-chevron-right" aria-hidden="true"></i>
    </a>
  </li>
</ul>

<div class="site-sidebar-tab-content tab-content">

  
  <div class="tab-pane fade active in" id="sidebar-editing" style="opacity:0;">
      <div class="">
        <div class="">
          <div class="list-group workskill">
          </div>
          <form class="workform margin-top-20">
            
            <div class="form-group form-material floating margin-bottom-10">
              <span class="new-heading">ADD WORKPERMIT</span><i class="icon wb-close pull-right"></i>
            </div>
            
            <div class="form-group form-material floating">
              <input type="text" class="form-control empty plce" />
              <label class="floating-label">Place</label>
            </div>
            
            <div class="form-group form-material row ">
                <button type="button" class="btn btn-sm btn-outline btn-primary refresh width-250 font-weight-500 center-block margin-bottom-20">SAVE</button>
            </div>
            
          </form>
          
        </div>
      </div>
  </div>
</div>
