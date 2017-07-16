   
  <div class="page animsition"> 
    <div class="page-content padding-30 container-fluid">
      
      <div class="row"> 
        <center> 
          <div class="resume-holder" style="max-width:810px;">
            <div class="hidden-sm hidden-xs" style="margin:10px 0px;">
              <div class="btn-group pull-left">
                <button type="button" class="btn btn-outline btn-default dropdown-toggle" id="exampleSizingDropdown2" data-toggle="dropdown" aria-expanded="false">
                  Cover Letter
                  <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" aria-labelledby="exampleSizingDropdown2" role="menu">
                  <li role="presentation"><a role="menuitem" href="/cv/builder">Resume</a></li>
                </ul>
              </div>
              
              <div class="btn btn-pure btn-default">
                &nbsp;
              </div>

              <div class="btn btn-pure pull-right">
                  <span style="font-family:roboto;" id="downloadA4" class="btn-download"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;A4</span>&nbsp;&nbsp;
                  <span style="font-family:roboto;margin-left:10px;" id="downloadLetter" class="btn-download"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;Letter</span>
                </div>
            </div>
          </div>
        </center>
      </div>
      <div class="row">
        <center>
        <!--box-shadow: 0 2px 2px 0 rgba(0,0,0,0.14),0 3px 1px -2px rgba(0,0,0,0.2),0 1px 5px 0 rgba(0,0,0,0.12);-->
          <div class="cover-holder cover-download" style="max-width:810px;background:white;padding:5mm 2mm;overflow-x:auto;min-height:29.7cm">
            <div class="cover_style"><?php echo $framework; ?></div>
            <div class="cover_html">
              <div id="myresume">
                
              </div>
            </div>
            <div style="clear:both;"></div>
          </div>
        </center>
      </div>
    </div>
  </div>
  
  <!-- Plugins -->
  <script src="/static/classic/global/vendor/cropper/cropper.min.js"></script>
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
    
    $('#downloadA4').on('click', function() {
      var download = $('.cover-download').html();
      $.redirectPost('/cv/buildPDF', {
        'html': encodeURIComponent(download),
        'size':'A4'
      });
    });

    $('#downloadLetter').on('click', function() {
      var download = $('.cover-download').html();
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
          localStorage.setItem("modified_dt",Date.now());
        }
        
        //buildresume();

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

    buildcoverletter();

    function buildcoverletter(){
      console.log('buildcoverletter()');

      var Data = localStorage.getItem("data");
      Data = $.parseJSON(Data);
      var d = new Date();

      var str = "";
      str += '  <div class="name">'+ Data.Profile.firstName.toUpperCase() + ' ' + Data.Profile.lastName.toUpperCase() +'</div>';
      str += '  <div class="address">'+Data.Profile.location.address+'</div>';
      str += '  <div class="phone">'+Data.Profile.phone+'</div>';
      str += '  <div class="email">'+Data.Profile.email+'</div>';
      str += '    <div class="section-break"></div>';
      str += '    <div class="letter-header">';
      str += '       <div>'+Data.Profile.coverletterDate+'</div>';
      str += '       '+Data.Coverletter.companyName+'<br>';
      str += '       '+Data.Coverletter.address;
      str += '    </div>';
      str += '    <div class="letter-salutation">';
      str += '        Dear '+Data.Coverletter.recruiterSal+''+Data.Coverletter.recruiterName+',';
      str += '    </div>';
      str += '    <div class="letter-body">';
      str += '    '+Data.Coverletter.description;
      str += '    <br><br>';
      str += '    Sincerely,';
      str += '    <br>'+ Data.Profile.firstName.toUpperCase() + ' ' + Data.Profile.lastName.toUpperCase();
      str += '  </div>';

      $('#myresume').html(str);

    }
  

  </script>
