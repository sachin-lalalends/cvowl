
<script>

  refresh();
  
  function refresh()
  {
    
    var Data = localStorage.getItem("data");
    if(Data != null && Data != "")
    {
      Data = $.parseJSON(Data);
      var customSections = (Data.customSections);
      
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
                    '<small>Include your custom section details</small>'+
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
        
        <h5 class="clearfix">YOUR CV SECTIONS
          <div class="pull-right">
            <a class="text-action slidePanel-close" href="javascript:void(0)" role="button">
              <i class="fa fa-angle-left fa-2x" aria-hidden="true"></i>
            </a>
          </div>
        </h5>
        
        <div class="list-group all_section">
          
        </div>
        <button type="button" class="btn btn-sm btn-outline btn-primary width-250 font-weight-500 center-block margin-30" data-target="#addcustomsection" data-toggle="modal">Add Custom Section</button>
      </div>
    </div>
  </div>
</div>

<span id="fixed_data" style="display:none;">
    <a class="list-group-item" href="javascript:void(0)" data-section="ABOUT_YOU" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/ABOUT_YOU.tpl" >
            <div class="media">
              <div class="media-left">
                <div class="avatar avatar-sm">
                  <img src="/static/classic/topbar/assets/icons/ABOUT_YOU.png" alt="..." />
                </div>
              </div>
              <div class="media-body">
                <h4 class="media-heading">ABOUT YOU</h4>
                <small>Enter a brief description of your professional background.</small>
              </div>
            </div>
          </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="EXPERIENCE" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/EXPERIENCE.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/EXPERIENCE.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">EXPERIENCE</h4>
          <small>Your professional work details</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="EDUCATION" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/EDUCATION.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/EDUCATION.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">EDUCATION</h4>
          <small>Your academic details</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="SKILLS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/SKILLS.tpl">
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/SKILLS.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">SKILLS</h4>
          <small>Enter your skills & rate your proficiency</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="PROJECTS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/PROJECTS.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm">
            <img src="/static/classic/topbar/assets/icons/PROJECTS.png" alt="..." />
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">PROJECTS</h4>
          <small>Showcase projects which you have worked on</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="ACHIEVEMENTS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/ACHIEVEMENTS_new.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/ACHIEVEMENTS.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">ACHIEVEMENTS</h4>
          <small>Showcase recognitions you have earned</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="CERTIFICATIONS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/CERTIFICATIONS.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/CERTIFICATIONS.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">CERTIFICATIONS</h4>
          <small>Enter details of any certifications you have qualified</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="LANGUAGES" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/LANGUAGES.tpl">
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/LANGUAGES.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">LANGUAGES</h4>
          <small>Enter the languages that you can speak or write</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="HOBBIES" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/HOBBIES.tpl">
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/HOBBIES.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">HOBBIES</h4>
          <small>Choose your hobbies you like</small>
        </div>
      </div>
    </a>
    <!--<a class="list-group-item" href="javascript:void(0)" data-section="PHOTO" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/PHOTO.tpl">
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm ">
            <img src="/static/classic/topbar/assets/icons/PHOTO.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">PHOTO</h4>
          <small>A picture is a worth a thousand words.</small>
        </div>
      </div>
    </a>-->
    <a class="list-group-item" href="javascript:void(0)" data-section="PERSONAL_DETAILS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/PERSONAL_DETAILS.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm">
            <img src="/static/classic/topbar/assets/icons/PERSONAL_DETAILS.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">PERSONAL DETAILS</h4>
          <small>Enter your personal details</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="CONTACT_DETAILS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/CONTACT_DETAILS.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm">
            <img src="/static/classic/topbar/assets/icons/SUMMARY.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">CONTACT DETAILS</h4>
          <small>Enter details on how to reach you and contact you</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="WORKLINKS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/WORKLINKS.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm">
            <img src="/static/classic/topbar/assets/icons/WORKLINKS.png" alt="..." />
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading">WEB LINKS</h4>
          <small>List links to your website, portfolio, blog & more</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="VOLUNTEERING" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/VOLUNTEERING.tpl" >
      <div class="media">
        <div class="media-left">
          <div class="avatar avatar-sm">
            <img src="/static/classic/topbar/assets/icons/VOLUNTEERING.png" alt="..." />
            
          </div>
        </div>
        <div class="media-body">
          <h4 class="media-heading" style="min-width:200px;">VOLUNTEERING EXPERIENCE</h4>
          <small>Include your volunteering and social works</small>
        </div>
      </div>
    </a>
    <a class="list-group-item" href="javascript:void(0)" data-section="RECOMMENDATIONS" data-toggle="slidePanel" data-url="/static/classic/topbar/tpl/RECOMMENDATIONS.tpl" >
            <div class="media">
              <div class="media-left">
                <div class="avatar avatar-sm">
                  <img src="/static/classic/topbar/assets/icons/RECOMMENDATIONS.png" alt="..." />
                  
                </div>
              </div>
              <div class="media-body">
                <h4 class="media-heading">RECOMMENDATIONS</h4>
                <small>Include a testimonial from your references here</small>
              </div>
            </div>
    </a>
</span>

<script>
  
</script>
