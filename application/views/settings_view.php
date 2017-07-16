  <style type="text/css">
    .btn-customDark{
        margin-top:20px;
        margin-bottom:20px;
        background:#515050 !important;
        border-radius:0px;
      }
    
    .changeEmail.active, .changePass.active{
      color:#89BDEF !important;
    }
    
    .Panel-desc-primary{
      color:#89BDEF !important;
      font-size: 12px;
    }
    
    .Panel-desc-warning{
      color:#fbbc05 !important;
      font-size: 12px;
    }
    
    .Panel-desc-success{
      color:#34a853 !important;
      font-size: 12px;
    }
    
    .error-block{
      font-size:12px !important;
      color:#d64937;
      cursor:pointer;
      text-align: center;
    }
    
  </style>
  <!-- Page -->
  
  <div class="page">
    
    <div class="page-content">
      
      <div class="row">
          
<!--         <div class="col-md-4 col-sm-12">
        <div class="panel">
          <div class="panel-heading">
            <h3 class="panel-title">Shared CV's</h3>
          </div>
          <div class="panel-body">
            <p class="Panel-desc-primary">Below is the list of all those resumes whom others ahve shared you and you can clone them :)</p>
            <ul class="list-group">
              <li class="list-group-item">
              <div class="media">
                <div class="media-body">
                  <h4 class="media-heading">Mayank Aggarwal</h4>
                  <div>mayank@gmail.com <span class="fa fa-close pull-right cursor-pointer" style="color:#d64937;"></span></div>
                </div>
              </div>
            </li>
            <li class="list-group-item">
              <div class="media">
                
                <div class="media">
                  <div class="media-body">
                    <h4 class="media-heading">Ankur Aggarwal</h4>
                    <div>ankur@yahoo.in <span class="fa fa-close pull-right cursor-pointer" style="color:#d64937;"></span></div>
                  </div>
                </div>
              </div>
            </li>
            </ul>
          </div>
        </div>
    </div>
    
        <div class="col-md-4 col-sm-12">
          <div class="panel">
            <div class="panel-heading">
              <h3 class="panel-title">Your CV is shared to..</h3>
            </div>
            <div class="panel-body">
              <p class="Panel-desc-warning">You can share you CV to your friends and allow them to copy your cv.</p>
              <ul class="list-group">
                <li class="list-group-item">
                  <div class="media">
                    <div class="media-body">
                      <h4 class="media-heading">James Dyson</h4>
                      <div>Jamesdyson@gmail.com <span class="fa fa-close pull-right cursor-pointer" style="color:#d64937;"></span></div>
                    </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <div class="media">
                    
                    <div class="media">
                      <div class="media-body">
                        <h4 class="media-heading">Ruben Baker</h4>
                        <div>rubenbaker@yahoo.in <span class="fa fa-close pull-right cursor-pointer" style="color:#d64937;"></span></div>
                      </div>
                    </div>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div> -->
        
        <div class="col-md-4 col-sm-12">
            <div class="panel">
              <div class="panel-heading">
                <h3 class="panel-title">Change Settings</h3>
              </div>
              <div class="panel-body">
                <p class="Panel-desc-success">Change your email or password here</p>
                <ul class="list-group">
                  <li class="list-group-item">
                    <div class="media">
                      <div class="media-body">
                        <h4 class="media-heading">Email</h4>
                        <div>mayank20014@gmail.com <span class="fa fa-edit pull-right cursor-pointer changeEmail"></span></div>
                      </div>
                    </div>
                  </li>
                  <li class="list-group-item">
                    <div class="media">
                      <div class="media-body">
                        <h4 class="media-heading">Password</h4>
                        <div>	&#8226; &#8226; &#8226; &#8226; &#8226; &#8226; &#8226;
                        <span class="fa fa-edit pull-right cursor-pointer changePass"></span></div>
                      </div>
                    </div>
                  </li>
                </ul>
    
                <div id="changeEmailForm" style="display:none;">
                  <h4 class="login-form-help error-block-email"></h4>
                  <div class="form-group">
                    <input type="text" class="form-control" id="new_email" name="new_email" placeholder="New Email" autocomplete="off">
                  </div>
                  <div class="form-group">
                    <button type="button" id="changeEmail" class="btn btn-primary"><strong>Change Email</strong></button>
                  </div>
                </div>
    
                <div id="changePassForm" style="display:none;">
                  <h4 class="error-block password"></h4>
                  <div class="form-group">
                    <input type="password" class="form-control" id="old_password" name="old_password" placeholder="Password" autocomplete="off">
                  </div>
                  <div class="form-group">
                    <input type="password" class="form-control" id="new_password" name="new_password" placeholder="New Password" autocomplete="off">
                  </div>
                  <div class="form-group">
                    <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirm Password" autocomplete="off">
                  </div>
                  <div class="form-group">
                    <button type="button" id="changePass" class="btn btn-primary"><strong>Change Password</strong></button>
                  </div>

                </div>
              </div>
            </div>
            <!-- End Example Panel List Group Inner -->
          </div>
        
      </div>
      
      
    </div>
  </div>
  
  <script type="text/javascript">
  
  $(function() {
    $('.site-skintools').hide();
    $('.slidePanel').hide();
  });

    $('.changePass').click(function(e){
      if($(this).hasClass('active')){
        $(this).removeClass('active');
        $('#changePassForm').slideUp('fast');
      }else{
        $(this).addClass('active')
        $('#changePassForm').slideDown('fast');
        $('.changeEmail').removeClass('active');
        $('#changeEmailForm').slideUp('fast');
      }
    });
    
    $('.changeEmail').click(function(e){
      if($(this).hasClass('active')){
        $(this).removeClass('active');
        $('#changeEmailForm').slideUp('fast');
      }else{
        $(this).addClass('active')
        $('#changeEmailForm').slideDown('fast');
        $('.changePass').removeClass('active');
        $('#changePassForm').slideUp('fast');
      }
    });



    $('#changePass').click(function(e){
      if($('#new_password').val() == $('#confirm_password').val()){
        if($('#new_password').val().length > 6){
          
          $('#changePass').html('<i class="fa fa-gear fa-spin"></i>');
          $.post('/settings/changepassword',{"old_password":$('#old_password').val(),'new_password':$('#new_password').val()}, function(res){
            
            var obj = $.parseJSON(res);
            if(obj.resp == 1){
              
              $(this).removeClass('active');
              $('#changePassForm').slideUp('fast');
              $('#changePassForm').find('input:password').val(''); 
              $('#changePass').html('Change Password');
              $('.error-block.password').html('');
              
            }else{
              
              $('#changePassForm').find('input:password').val(''); 
              $('.error-block.password').html(obj.msg);
              $('#changePass').html('Change Password');
              
            }
            
          });
          
        }else{
          $('#changePassForm').find('input:password').val(''); 
          $('.error-block.password').html('Password should be more than 6 character');
        }
      }else{
        $('#changePassForm').find('input:password').val(''); 
        $('.error-block.password').html('Password do not match');
      }
    });
    
  </script>