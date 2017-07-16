
    <div id="feed">
      <div style="position:fixed;bottom:30px;right:0px;color:white;font-weight:500;">
        <div style="
          -webkit-transform: rotate(315deg); /* Safari and Chrome */
          -moz-transform: rotate(315deg);   /* Firefox */
          -ms-transform: rotate(315deg);   /* IE 9 */
          -o-transform: rotate(315deg);   /* Opera */
          transform: rotate(315deg);cursor:pointer;">Feedback
        </div>
      </div>  
    </div>  
  <div class="modal fade" id="email_send" aria-hidden="false" aria-labelledby="exampleFormModalLabel" role="dialog" tabindex="-1">
    <div class="modal-dialog">
      <form class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
          <h4 class="modal-title" id="exampleFormModalLabel">Mail Your Resume</h4>
        </div>
        <div class="modal-body">
          <form autocomplete="off">
            <div class="form-group form-material">
            <div class="input-group">
                <div class="form-control-wrap">
                  <input type="text" class="form-control empty" placeholder="To">
                  <!--<label class="floating-label">To</label>-->
                </div>
                <span class="input-group-btn">
                  <button class="btn btn-link cc_link" type="button">CC</button>
                  <button class="btn btn-link bcc_link" type="button">BCC</button>
                </span>
                </div>
            </div>
            <div class="form-group form-material">
                <input type="text" class="form-control" name="inputFloatingText" placeholder="From"/>
                <!--<label class="floating-label">CC</label>-->
            </div>
            <div class="form-group form-material" style="display:none;" id="cc_input">
                <input type="text" class="form-control" name="inputFloatingText" placeholder="CC"/>
                <!--<label class="floating-label">CC</label>-->
            </div>
            <div class="form-group form-material" style="display:none;" id="bcc_input">
              <input type="text" class="form-control" name="inputFloatingText" placeholder="BCC"/>
              <!--<label class="floating-label">BCC</label>-->
            </div>
            <div class="form-group form-material">
            	<input type="text" class="form-control" name="inputFloatingText" list="list1" placeholder="Subject" />
            	<!--<datalist id="list1">
    						<option value="Job Code 1234 : District Sales Manager - Your Name">
    						<option value="Application for Customer Service Job">
    						<option value="Grant Miller Resume : Website Designer">
    						<option value="Events Director - John Smith MBA">
    						<option value="Job Application : Terry Hooks IT Manager">
    						<option value="Job Candidate : Award-Winning Design Specialist Now in New Jersey">
    						<option value="Social Media Manager Seeking New Opportunity">
    						<option value="Referred by Tony Dungy - John Smith">
    						<option value="Marketing Manager 10 years' experience">
    						<option value="IT Manager, 10 yrs IT experience">
    						<option value="Referred by Tom Smith-Product Development Job">
    						<option value="Marketing Manager posting, No.MMO1176, MBA/10yrs exp">
    						<option value="Job Posting No. 234, Harvard Grad is interested">
    					</datalist>
              <!--<label class="floating-label">Subject</label>-->
            </div>
            <div class="form-group form-material " id="summernote">
              <!--<textarea class="form-control"  rows="5" name="inputFloatingText" placeholder="Message"></textarea>
              <label class="floating-label">Message</label>-->
            </div>
            <div class="form-group form-material">
              <span class="fa fa-check"></span>&nbsp;&nbsp;&nbsp; Resume attached (.pdf)
            </div>
            <div class="form-group form-material row" style="margin-right:0px;margin-left:0px;">
              <button type="button" class="btn btn-primary col-md-2">Send</button>
              <button type="reset" class="btn btn-outline btn-warning col-md-2 pull-right">Reset</button>
            </div>
          </form>
        </div>
      </form>
    </div>
  </div>
  <div class="modal fade" id="ShareModal" aria-hidden="false" aria-labelledby="sampleFormModalLabel" role="dialog" tabindex="-1">
  
    <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
            <h4 class="modal-title" id="sampleFormModalLabel">Share with others</h4>
          </div>
          <div class="modal-body">
            <div style="font-weight: 300;letter-spacing: .3px;color: #f2a654;">
              Enter the Email ID of person whom you want to share your resume and allow him to clone your resume
            </div>
            <br>
            <div class="row">
              <div class="col-sm-9">
                <div class="form-group form-material ">
                  <input type="text" class="form-control" id="shareEmail" placeholder="Enter Email ID"/>
                </div>
              </div>
              <div class="col-sm-3">
                <button type="button" style="letter-spacing:1px;" class="btn btn-sm btn-block btn-primary font-weight-400" id="allowshare" style="color:#673AB7">Allow</button>
              </div>
            </div>
            <div style="font-weight: 300;letter-spacing: .3px;color: #d6d5d3;">
              Resume is already shared to ..
            </div>
          </div>
        </div>
    </div>
    
    </div>
  <div class="modal fade docs-cropped" id="getCroppedCanvasModal" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle" role="dialog" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title" id="getCroppedCanvasTitle">Cropped</h4>
        </div>
        <div class="modal-body"></div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <a class="btn btn-primary" id="download" href="javascript:void(0);" download="cropped.png">Download</a>
        </div>
      </div>
    </div>
  </div>
  <div class="modal fade" id="addcustomsection" aria-hidden="false" aria-labelledby="addcustomsection" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-center">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
          <h4 class="modal-title">Add Custom Section</h4>
        </div>
        <div class="modal-body padding-top-0">
          <div style="font-weight: 300;letter-spacing: .3px;color: #f2a654;">
            Showcase anything extra you want to include in your resume e.g. award, honour, affiliations, extra curricular activities, etc.
          </div>
          <br>
          <div class="row">
            <div class="col-sm-8 col-xs-8">
              <div class="form-group form-material floating">
                <input type="text" class="form-control empty NewSectionName" />
                <label class="floating-label">Enter Section Name</label>
              </div>
            </div>
            <div class="col-sm-3 col-xs-3">
              <button type="button" class="btn btn-sm btn-primary btn-block margin-20" data-dismiss="modal" id="newsection">Add</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="modal fade" id="feedback" aria-hidden="false" aria-labelledby="feedback" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-center">
      <div class="modal-content" style="box-shadow: 0 2px 12px rgba(0,0,0,0.8);border-radius:0;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
          <h4 class="modal-title">Feedback</h4>
        </div>
        <div class="modal-body padding-top-0">
          <div style="font-weight: 300;letter-spacing: .3px;color: #f2a654;">
            Please help us to improve your experience
          </div>
          <br>
          <form class="feedbackform" action="/">
            <div class="row">
              <div class="col-sm-12">
                <div class="form-group form-material floating">
                  <textarea class="form-control empty" name="message"></textarea> 
                  <label class="floating-label">Message</label>
                </div>
              </div>
              <div class="col-sm-12">
                <button type="submit" class="btn btn-sm btn-primary width-100">Submit</button>
              </div>
            </div>
          </form>
          
        </div>
      </div>
    </div>
  </div>
  <div class="modal fade" id="sampleFormModal" aria-hidden="false" aria-labelledby="sampleFormModalLabel" role="dialog" tabindex="-1">
  
    <div class="modal-dialog">
      <form id="filtersummary" class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
          <h4 class="modal-title" id="sampleFormModalLabel">Suggestions</h4>
        </div>
        <div class="modal-body">
          <div class="row">
            <input type="hidden" value="1" id="jsp_lim"/>
            <div class="col-sm-6">
              <div class="form-group form-material ">
                <input type="text" class="form-control" placeholder="Enter your designation and skills" id="jsp_tags"/>
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group form-material ">
                <select class="form-control empty" id="jsp_experience">
                  <option value="" disabled selected hidden>Experience</option>
                  <option value="1">All</option>
                  <option value="2">Intern</option>
                  <option value="3">Fresher</option>
                  <option value="4">0-3 years</option>
                  <option value="5">3-8 years</option>
                  <option value="6">8 years and above</option>
                </select>
              </div>
            </div>
            <div class="col-sm-2">
              <button type="submit" style="letter-spacing:1px;" class="btn btn-sm btn-outline width-120 btn-default font-weight-400" style="color:#673AB7">APPLY FILTER</button>
            </div>
          </div>
          
          <div class="row" style="max-height:250px; overflow:auto;">
            <ul class="list-group list-group-full padding-15 summary-list-group">
            </ul>
          </div>
        </div>
      </form>
  </div>
  
  </div>
  
  <script src="/static/classic/global/vendor/bootstrap/bootstrap.min.js"></script>
  <script src="/static/classic/global/vendor/animsition/animsition.min.js"></script>
  <script src="/static/classic/global/vendor/asscroll/jquery-asScroll.min.js"></script>
  <script src="/static/classic/global/vendor/mousewheel/jquery.mousewheel.js"></script>
  <script src="/static/classic/global/vendor/asscrollable/jquery.asScrollable.all.min.js"></script>
  <script src="/static/classic/global/vendor/ashoverscroll/jquery-asHoverScroll.js"></script>
  
  <!--plugin-->
  <script src="/static/classic/global/vendor/slidepanel/jquery-slidePanel.min.js"></script>
  

  <!-- Scripts -->
  <script src="/static/classic/global/js/core.min.js"></script>
  <script src="/static/classic/topbar/assets/js/site.min.js"></script>
  <script src="/static/classic/topbar/assets/js/sections/menu.min.js"></script>
  <script src="/static/classic/topbar/assets/js/sections/menubar.min.js"></script>
  <script src="/static/classic/topbar/assets/js/sections/sidebar.min.js"></script>
  <script src="/static/classic/global/js/components/asscrollable.min.js"></script>
  <script src="/static/classic/global/js/components/animsition.min.js"></script>
  <!-- <script src="/static/classic/global/vendor/jquery-confirm/jquery-confirm.js"></script> -->
  <script src="/static/classic/global/js/components/slidepanel.js"></script>
  <script src="/static/classic/global/js/components/material.min.js"></script>
  
  <script type="text/javascript">
      (function(document, window, $) {
          'use strict';
        
          var Site = window.Site;
        
          $(document).ready(function($) {
            Site.run();

            Date.prototype.yyyymmdd = function() {
              var mm = this.getMonth() + 1; // getMonth() is zero-based
              var dd = this.getDate();

              return [this.getFullYear(),
                      (mm>9 ? '' : '0') + mm,
                      (dd>9 ? '' : '0') + dd
                     ].join('');
            };

            var date = new Date();
            date.yyyymmdd();
            setTimeout(function(){$('.site-skintools').trigger('click');}, 1000);
            $('.remove-notification').click(function(){
              $(this).parent().slideUp('fast');
            });

            $('#filtersummary').on('submit', function(e){
              e.preventDefault();
              $("#jsp_lim").val(1);
              $('.summary-list-group').html('<center><i class="fa fa-gear fa-spin"></i></center>');
              getmoresuggestions();
              
            });
            
            function getmoresuggestions(l = null){
              $.post('/summary/suggestion',{"t":$("#jsp_tags").val(),"e":$("#jsp_experience").val(),"l":l},function(res){
                
                var obj = $.parseJSON(res);
                if(obj.resp)
                {
                  var temp ="";
                  var pre_count = $('.summary-list-group li').length;
                  $.each(obj.msg , function(k, v) {
                      temp += '<li class="list-group-item"><span class="badge badge-success sum_ex" style="cursor:pointer;margin:10px" data-id="text-sum'+k+'">Select</span> <span id="text-sum'+k+'">'+v.summary+'</span></li>';
                  });
                  if(pre_count < obj.msg.length)
                  temp += '<center><span class="view_more">View more</span> </center>';
                  
                  $('.summary-list-group').html(temp);
                  
                  $('.sum_ex').on('click', function(e)
                  {
                    $('.sury').removeClass('empty');
                    $('.sury').height(1);
                    $('.sury').val($('#'+$(this).data('id')).html());
                    var height = $('.sury').prop("scrollHeight")
                    height = height;
                    $('.sury').height(height);
                    updateSummary();
                  });
                  
                  $('.view_more').on('click', function()
                  {
                    $('.view_more').html('<i class="fa fa-gear fa-spin"></i>');
                    $("#jsp_lim").val(parseInt($("#jsp_lim").val())+1);
                    getmoresuggestions($("#jsp_lim").val());
                  });
                }else
                {
                  $('.summary-list-group').html("No record found");
                }
                
              });
            }
          });
      })(document, window, jQuery);
  </script>
  
  
  <script src="/static/classic/topbar/jscript/builder.js"></script>


 
  <script>
  
    $('#feed').on('click', function(){
      $('#feedback').modal('toggle');
    });

    $('#feedback form.feedbackform').submit(function(e){
      e.preventDefault();
      var o = $(this).serializeArray();
      var a = {};
      $.each(o,function(k,v){
        a[v.name] = v.value;
      });
      if(!a['message']){
        alert('Please type you feedack in message');
        return;
      }
      $('#feedback form.feedbackform button').html('<i class="fa fa-cog fa-spin"></i>');
      $.post('/feedback/submit',a,function(e){
        $('#feedback form.feedbackform button').html('Submit');
        var obj = $.parseJSON(e);
        if(obj.resp == 1){
          $('#feedback').modal('toggle');
        }
        alert(obj.msg);
      });
    });
  
  
  
    $('#share').on('click', function(){
      $('#ShareModal').modal('toggle');
    });
    
    $('#allowshare').on('click', function(){
      
      $('#allowshare').html('<i class="fa fa-gear fa-spin"></i>');
      
      $.post('/share',{"proposedEmails":$('#shareEmail').val()}, function(res){
        $('#shareEmail').val('')
        $('#allowshare').html('Allow');
      });
    });
  
    <?php if($this->session->userdata('verified')==0){
      echo "function resendConfEmail(e){
        $('#resendEmail').html('<i class=\"fa fa-gear fa-spin\"></i>');
        $.post('/settings/resendConfEmail',{},function(res,err){
          $('#resendEmail').remove();
          setTimeout(function(){\$('.emailverify-backline').slideUp();}, 5000);
        });
      }";
    }
    ?>
    
  </script>

  <div class="modal fade upgrade-modal" id="upgrade" aria-hidden="false" aria-labelledby="upgrade" role="dialog" tabindex="-1">
      <div class="modal-dialog">
        <form class="modal-content">
          <!--<div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
            <h4 class="modal-title" id="exampleFormModalLabel">Mail Your Resume</h4>
          </div>-->
          <div class="modal-body">
            
            <div class="pricing-table">
                  <div class="pricing-column-three">
                    <div class="pricing-header">
                      <div class="pricing-price">
                        <span class="avatar">
                          <img src="/static/classic/global/portraits/5.jpg" alt="...">
                        </span>
                      </div>
                      <div class="pricing-title">Testimonials</div>
                    </div>
                    <ul class="pricing-features">
                      <li>
                        Access all CV and web designs</li>
                      <li>
                        No VisualCV branding</li>
                      <li>
                        <strong>2GHZ</strong> Dedicated Support</li>
                      <li>
                        Export as PDF & Google Doc</li>
                      <li>
                        Advanced CV tracking</li>
                    </ul>
                    <div class="pricing-footer">
                      <a class="btn btn-primary btn-outline" role="button"><i class="icon wb-check font-size-16 margin-right-15" aria-hidden="true"></i>FREE</a>
                    </div>
                  </div>
                  <div class="pricing-column-three featured">
                    <div class="pricing-header">
                      <div class="pricing-price">
                        <span class="pricing-currency">$</span>
                        <span class="pricing-amount">50</span>
                        <span class="pricing-period">/ mo</span>
                      </div>
                      <div class="pricing-title">Premium</div>
                    </div>
                    <ul class="pricing-features">
                      <li>
                        Access all CV and web designs</li>
                      <li>
                        Multiple resume versionse</li>
                      <li>
                        Access all CV and web designs
                      </li>
                      <li>
                        Multiple resume versions
                      </li>
                      <li>
                        <strong>2 GB</strong> Storage</li>
                      <li>
                        Export as PDF & Google Doc</li>
                    </ul>
                    <div class="pricing-footer">
                      <a class="btn btn-primary btn-outline" role="button"><i class="icon wb-arrow-up font-size-16 margin-right-15" aria-hidden="true"></i>UPGRADE</a>
                    </div>
                  </div>
                  <div class="pricing-column-three">
                    <div class="pricing-header">
                      <div class="pricing-price">
                        <span class="pricing-currency">$</span>
                        <span class="pricing-amount">60</span>
                        <span class="pricing-period">/ mo</span>
                      </div>
                      <div class="pricing-title">Professional</div>
                    </div>
                    <ul class="pricing-features">
                      <li>
                        <strong>10GB</strong> Content dal lena</li>
                      <li>
                        I hope you like it</li>
                      <li>
                         Personal domain name</li>
                      <li>
                        Content khud daal dena</li>
                      <li>
                        <strong>4 GB</strong> Storage</li>
                    </ul>
                    <div class="pricing-footer">
                      <a class="btn btn-primary btn-outline" role="button"><i class="icon wb-arrow-right font-size-16 margin-right-15" aria-hidden="true"></i>UPGRADE</a>
                    </div>
                  </div>
                  
                </div>
          </div>
        </form>
      </div>
    </div>
  <div class="site-skintools" style="display:block;" data-toggle="slidePanel" data-url="<?= $slidepanel_url; ?>">
    <div class="site-skintools-inner">
      <div class="site-skintools-toggle" style="box-shadow: 1px 1px 3px #ccc;border-radius: 10px;height:2.35em;">&nbsp;<i class="icon wb-chevron-right primary-600"></i>&nbsp;</div>
    </div>
  </div>

</body>



</html>
