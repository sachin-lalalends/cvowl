
<script>

  //refresh();
  
  function refresh()
  {
    
    var Data = localStorage.getItem("data");
    if(Data != null && Data != "")
    {
      Data = $.parseJSON(Data);
      var customSections = (Data.customSections);
      
      console.log(customSections);
      
      var str = "";
      $.each(customSections, function(k,v)
      {
        if(v != null)
        {
          str += '<a class="list-group-item" href="javascript:void(0)" data-section="'+v.section_name+'" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/CUSTOM_SECTIONS.tpl" >'+
                '<div class="media">'+
                  '<div class="media-left">'+
                    '<div class="avatar avatar-sm">'+
                      '<img src="/static/classic/topbar/assets/images/chars/'+v.section_name.charAt(0).toUpperCase()+'.png'+'" alt="...">'+
                    '</div>'+
                  '</div>'+
                  '<div class="media-body">'+
                    '<h4 class="media-heading">'+v.section_name.toUpperCase()+'</h4>'+
                    '<small>Include Your custom section details</small>'+
                  '</div>'+
                  '<div class="media-right">';
                    if(v.is_active == 1)
                    {
                      str += '<i class="icon wb-eye visibility-section"'+ 'data-key="'+k+'"'+ 'data-status="'+v.is_active+'"' + 'style="font-size:10px;color: #76838f;"></i>';
                    }else{
                      str += '<i class="icon wb-eye-close visibility-section"'+ 'data-key="'+k+'"'+ 'data-status="'+v.is_active+'"' + 'style="font-size:10px;color: #76838f;"></i>';
                    }
                    str += '<i class="icon wb-close delete-section"'+ 'data-key="'+k+'"' + 'style="font-size:10px;color: #DE5C5C;"></i>'+
                  '</div>'+
                '</div>'+
              '</a>';
        }
      });
      
      
    }
    
    
    $('.all_section').html($('#fixed_data').html() + str);
    
    $('.visibility-section').on('click',function(e){
      e.preventDefault();
      e.stopPropagation();
      changeVisibility($(this).data('key'),$(this).data('status'));
    });
    
    $('.delete-section').on('click',function(e){
        e.preventDefault();
        e.stopPropagation();
        delete Data[Data.customSections[$(this).data('key')].section_name];
        delete Data.customSections[$(this).data('key')];
        localStorage.setItem("data", JSON.stringify(Data));
        refresh();
        buildresume();
    });
    
    $('.tab-pane').asScrollable('update');
  
    function changeVisibility(key,status)
    {
      if(status == 1)
      {
        Data.customSections[key].is_active = 0;
      }else{
        Data.customSections[key].is_active = 1;
      }
      localStorage.setItem("data", JSON.stringify(Data));
      refresh();
      buildresume();
    }
    
    $('.list-group-item').click(function(e){
      localStorage.setItem('activeSection',$(this).data('section'));
      if(localStorage.getItem('activeSection') == "" || localStorage.getItem('activeSection') == null)
      {
        alert("some problem with this section. Please contact us at mayank k dwar");
        return;
      }
    });
    
    $('#newsection').on('click',function(e){
      console.log(e);
      if(Data[$('.NewSectionName').val()] != null || $('.NewSectionName').val() == ""){
        alert("This section name already exist or is blank");
        return false;
      }
      else
      {
        var param = {};
        param.id = new Date().getTime();
        param.section_name = $('.NewSectionName').val();
        param.order_prefs = 999;
        param.is_active = 1;
        Data[param.section_name] = [];
        Data.customSections.push(param);
        localStorage.setItem('data',JSON.stringify(Data));
        refresh();
        buildresume();
      }
      
    });
  }
  
  
  
</script>

<div class="site-sidebar-tab-content tab-content">
  <div class="tab-pane fade active in" id="sidebar-userlist">
    <div>
      <div>
        
        <h5 class="clearfix">COVER LETTER SECTIONS
          <div class="pull-right">
            <a class="text-action slidePanel-close" href="javascript:void(0)" role="button">
              <i class="fa fa-angle-left fa-2x" aria-hidden="true"></i>
            </a>
          </div>
        </h5>
        
        <div class="list-group all_section">
          <a class="list-group-item" href="javascript:void(0)" data-section="BASIC_DETAILS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/BASIC_DETAILS.tpl" >
            <div class="media">
              <div class="media-left">
                <div class="avatar avatar-sm">
                  <img src="/static/classic/topbar/assets/icons/BASIC_DETAILS.png" alt="..." />
                </div>
              </div>
              <div class="media-body">
                <h4 class="media-heading">Basic Details</h4>
                <small>Enter details on how to reach you and contact you</small>
              </div>
            </div>
          </a>
          <a class="list-group-item" href="javascript:void(0)" data-section="RECRUITER_DETAILS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/RECRUITER_DETAILS.tpl" >
            <div class="media">
              <div class="media-left">
                <div class="avatar avatar-sm ">
                  <img src="/static/classic/topbar/assets/icons/RECRUITER_DETAILS.png" alt="..." />
                  
                </div>
              </div>
              <div class="media-body">
                <h4 class="media-heading">Recruiter Details</h4>
                <small>Enter recruiter contact details</small>
              </div>
            </div>
          </a>
          <a class="list-group-item" href="javascript:void(0)" data-section="LETTER_DESC" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/LETTER_DESC.tpl" >
            <div class="media">
              <div class="media-left">
                <div class="avatar avatar-sm ">
                  <img src="/static/classic/topbar/assets/icons/LETTER_DESC.png" alt="..." />
                  
                </div>
              </div>
              <div class="media-body">
                <h4 class="media-heading">Description</h4>
                <small>Introduce and sell yourself</small>
              </div>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
