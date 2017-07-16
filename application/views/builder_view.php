  
  <div class="page animsition"> 
    <div class="page-content padding-30 container-fluid">
      
      <div class="row"> 
        <center> 
          <div class="resume-holder" style="max-width:810px;">
              <!--<button type="button" class="btn btn-pure btn-default icon wb-file primary-600"></button>-->
              <!--&nbsp; | &nbsp;-->
              <!--<button type="button" class="btn btn-pure btn-default icon fa fa-envelope-o" data-target="#email_send" data-toggle="modal">-->
              <!--  <span style="font-family:roboto;">&nbsp;Email</span>-->
              <!--</button>-->
              <div style="margin:10px 0px;">
                <div class="btn-group pull-left hidden-sm hidden-xs">
                  <button type="button" class="btn btn-outline btn-default dropdown-toggle" id="exampleSizingDropdown2" data-toggle="dropdown" aria-expanded="false">
                    Resume
                    <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu" aria-labelledby="exampleSizingDropdown2" role="menu">
                    <li role="presentation"><a role="menuitem" href="/cv/coverletter">Cover Letter</a></li>
                  </ul>
                </div>
                
                <div class="btn btn-pure btn-default">
                  <div class="radio-custom radio-default radio-inline">
                    <input id="fresher" name="type" type="radio" value="FRESHER">
                    <label for="fresher">Fresher</label>
                  </div>
                  <div class="radio-custom radio-default radio-inline">
                    <input id="experienced" name="type" type="radio" value="EXPERIENCED">
                    <label for="experienced">Experience</label>
                  </div>
                </div>

                <div class="btn btn-pure pull-right hidden-sm hidden-xs">
                  <span style="font-family:roboto;" class="btn-download downloadA4"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;A4</span>&nbsp;&nbsp;
                  <span style="font-family:roboto;margin-left:10px;" class="btn-download downloadLetter"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;Letter</span>
                </div>
              </div>
              <!--<button type="button" class="btn btn-pure btn-default icon fa fa-link" data-plugin="webuiPopover"-->
              <!--        data-title="URL of your website" data-content="www.cvowl.com/<?php $username = explode("@",$this->session->userdata('email')); echo $username[0].$this->session->userdata('user_id'); ?>&lt;a class='pull-right' target='blank' href='www.cvowl.com/<?php $username = explode("@",$this->session->userdata('email')); echo $username[0].$this->session->userdata('user_id'); ?>'&gt;Preview&lt;/i&gt;&lt;/a&gt;" >-->
              <!--  <span style="font-family:cvdffont;">&nbsp;URL</span>-->
              <!--</button>-->
              <!--<button type="button" class="btn btn-pure btn-default icon fa fa-send" data-target="#upgrade" data-toggle="modal">-->
              <!--  <span style="font-family:roboto;">&nbsp;Go to PRO</span>-->
              <!--</button>-->
          </div>
        </center>
      </div>
      <div class="row">
        <center>
        <!--box-shadow: 0 2px 2px 0 rgba(0,0,0,0.14),0 3px 1px -2px rgba(0,0,0,0.2),0 1px 5px 0 rgba(0,0,0,0.12);-->
          <div class="resume-holder resume-download" style="max-width:810px;background:white;padding:5mm 2mm;overflow-x:auto;">
            <div class="resume_style"><?php echo $framework; ?>
            </div>
            <div class="resume_html"></div>
            <div style="clear:both;"></div>
          </div>
        </center>
      </div>      
    </div>
  </div>
  
  <!-- Plugins -->
  <!-- <script src="/static/classic/global/vendor/cropper/cropper.min.js"></script> -->
  <script src="/static/classic/global/vendor/summernote/summernote.js"></script>
  
  <script>
    $.extend({
      redirectPost: function(location, args) {
        var rpfd = '';
        $.each(args, function(k, v) {
          rpfd += '<input type="hidden" name="' + k + '" value="' + v + '">';
        });
        $('<form action="' + location + '" method="POST">' + rpfd + '</form>').appendTo($(document.body)).submit();
      },
      redirectGet: function(location, args) {
        var rgfd = '';
        $.each(args, function(k, v) {
          rgfd += '<input type="hidden" name="' + k + '" value="' + v + '">';
        });
        $('<form action="' + location + '" method="GET">' + rgfd + '</form>').appendTo($(document.body)).submit();
      }
    });
    
    $('.downloadA4').on('click', function() {
      var download = $('.resume-download').html();
      $.redirectPost('/cv/buildPDF', {
        'html': encodeURIComponent(download),
        'size':'A4'
      });
    });

    $('.downloadLetter').on('click', function() {
      var download = $('.resume-download').html();
      $.redirectPost('/cv/buildPDF', {
        'html': encodeURIComponent(download),
        'size':'Letter'
      });
    });

    var ls = Date.now();

  
    $('#syncronize').on('click', function(){
      if(localStorage.getItem("data") == null || localStorage.getItem("modified_dt") == null)
      {
        alert("nothing to sync");
      }
      else
      {
        $.post('/cv/sync',{"data":localStorage.getItem("data")},function(res){
            
            ls = Date.now()
            $('#datasaved').slideDown("fast");
            $('#datasaved').delay(2500).slideUp("fast");
          
        });
      }
    });
  </script>
  <script src="/static/classic/topbar/jscript/resume1.js"></script>
  <script type="text/javascript">
    
    $(document).ready(function()
    {
        if(localStorage.getItem("data") == null)
        {
          localStorage.setItem("data",<?php echo $resume_data; ?>);
          localStorage.setItem("modified_dt",Date.now());
        }
        else if(!localStorage.getItem("modified_dt")){
          localStorage.setItem("data",null);
          location.reload();
        }
        else if(localStorage.getItem("modified_dt") < <?php echo $modified_dt; ?>){
          alert('new data loaded');
          localStorage.setItem("data",<?php echo $resume_data; ?>);
          localStorage.setItem("modified_dt",Date.now());
        }
        else{
          console.log('retain old data');
          localStorage.setItem("modified_dt",Date.now());
        }
        
        buildresume();
        
        $('#next_nav').click(function () {
        	$('.mobile_menu_content').animate( { scrollLeft: '+=100' }, 1000);
        });
        $('#prev_nav').click(function () {
        	$('.mobile_menu_content').animate( { scrollLeft: '-=100' }, 1000);
        });
    });

    
    $('input[type=radio][name=type]').change(function() {
        var Data = localStorage.getItem("data");
        Data = $.parseJSON(Data);
        Data.Profile.type = this.value;
        localStorage.setItem("data", JSON.stringify(Data));
        localStorage.setItem("modified_dt", Date.now());
        buildresume();
    });


    setInterval(function(){
        if(ls < localStorage.getItem('modified_dt')){
          $('.svsts').html('Saving changes...');
          $.post('/cv/sync',{"data":localStorage.getItem("data")},function(res){
              ls = Date.now();
              $('.svsts').show();
              $('.svsts').html('All changes saved');
              setTimeout(function(){
                $('.svsts').html('');
              }, 1200)
          });
        }
        
    }, 3000);

    // setTimeout(function(){
    //   console.log('save started');
    //   $.post('/cv/sync',{"data":localStorage.getItem("data")},function(res){
    //       console.log('save complete');
    //   });
    // },5000);
    
    $.fn.attachDragger = function(){
        var attachment = false, lastPosition, position, difference;
        $( $(this).selector ).on("mousedown mouseup mousemove",function(e){
            if( e.type == "mousedown" ) attachment = true, lastPosition = [e.clientX, e.clientY];
            if( e.type == "mouseup" ) {attachment = false;}
            if( e.type == "mousemove" && attachment == true ){
                position = [e.clientX, e.clientY];
                difference = [ (position[0]-lastPosition[0]), (position[1]-lastPosition[1]) ];
                $(this).scrollLeft( $(this).scrollLeft() - difference[0] );
                $(this).scrollTop( $(this).scrollTop() - difference[1] );
                lastPosition = [e.clientX, e.clientY];
            }
            
        });
        $(window).on("mouseup", function(e){
            attachment = false;
        });
    }
    
  </script>
