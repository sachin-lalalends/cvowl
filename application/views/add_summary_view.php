<!DOCTYPE html>
<html lang="en">
<head>
  <title>Add summary</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" />
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<form method="post" id="form_main">
	<div class="col-md-12" style="border-right: 1px #ddd solid; padding-bottom:15px;padding:20px;">
		<button type="button" class="btn btn-xs addnewtag pull-right">add new Tag</button>
	  <h3>Summer Panel</h3>
	  	<div class="row" style="border-bottom: 1px #ddd solid;">
	  		<div class="col-md-6">
	  			<div class="form-group ">
			      <label for="firstname">Summary Text</label>
			      <input type="text" class="form-control" name="summary_text" placeholder="Full summary">
			    </div>
	  		</div>
	  		
	  		<div class="col-md-6">
	  			<div class="form-group ">
			      <label for="Compay">Summary Tags</label>
			      <select class="form-control" placeholder="Summary Tags" multiple="multiple" name="summary_tag[]" id="summary_tag">
			      	<option value=""></option>
			      	<?php if($tags){
			      		foreach ($tags as $key => $value) {
			      			# code...
			      			echo '<option value="'.$value->id.'">'.$value->tag_name.'</option>';
			      		}
			      	}
			      	?>

			      </select>
			    </div>
	  		</div>
	  		
	  		<div class="col-md-12">
	  			<div class="form-group ">
			      <label for="Compay">Summary For</label>
			      <input type="checkbox" name="summary_for[]" value="1">All</input>
			      <input type="checkbox" name="summary_for[]" value="2">Intern</input>
			      <input type="checkbox" name="summary_for[]" value="3">Fresher</input>
			      <input type="checkbox" name="summary_for[]" value="4">0-3 year</input>
			      <input type="checkbox" name="summary_for[]" value="5">0-8 year</input>
			      <input type="checkbox" name="summary_for[]" value="6">more than 8</input>
			      
			    </div>
	  		</div>
	  	</div>
	</div>

  	<div class="col-md-12">
	  	<div class="checkbox">
	      <label><input type="checkbox">All Information entered is correct to best of my knowlegde</label>
	    </div>
	    <br>
	    <button type="submit" class="btn btn-primary" style="margin-bottom:20px;">Submit</button>
  	</div>
</form>

<form method="post" id="form_main_skill">
	<div class="col-md-12" style="border-right: 1px #ddd solid; padding-bottom:15px;padding:20px;">
		<button type="button" class="btn btn-xs addnewskill pull-right">add new Skill</button>
	  <h3>Skill Panel</h3>
	  	<div class="row" style="border-bottom: 1px #ddd solid;">
	  		<div class="col-md-6">
	  			<div class="form-group ">
			      <label for="firstname">Job Title</label>
			      <select class="form-control" placeholder="Skill Tags" name="job_title" id="job_title">
			      	<option value=""></option>
			      	<?php if($tags){
			      		foreach ($tags as $key => $value) {
			      			# code...
			      			echo '<option value="'.$value->tag_name.'">'.$value->tag_name.'</option>';
			      		}
			      	}
			      	?>

			      </select>
			    </div>
	  		</div>
	  		
	  		<div class="col-md-6">
	  			<div class="form-group ">
			      <label for="Compay">Skill Tags</label>
			      <select class="form-control" placeholder="Skill Tags" multiple="multiple" name="skill_tag[]" id="skill_tag">
			      	<option value=""></option>
			      	<?php if($skill_tags){
			      		foreach ($skill_tags as $key => $value) {
			      			# code...
			      			echo '<option value="'.$value->id.'">'.$value->tag_name.'</option>';
			      		}
			      	}
			      	?>

			      </select>
			    </div>
	  		</div>
	  	</div>
	</div>

  	<div class="col-md-12">
	  	<div class="checkbox">
	      <label><input type="checkbox">All Information entered is correct to best of my knowlegde</label>
	    </div>
	    <br>
	    <button type="submit" class="btn btn-primary" style="margin-bottom:20px;">Submit</button>
  	</div>
</form>



<div id="addnewtag" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add new summary tag</h4>
      </div>
      <div class="modal-body">
  			<div class="form-group ">
		      <input type="text" class="form-control" id="tagname" name="tag_name" placeholder="Tag Name">
		    </div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-success" id="addnewtagbtn">Add</button>
      </div>
    </div>

  </div>
</div>


<div id="addnewskill" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add new Skill Name</h4>
      </div>	
      <div class="modal-body">
  			<div class="form-group ">
		      <input type="text" class="form-control" id="skill_name" name="skill_name" placeholder="Skill Name">
		    </div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-success" id="addnewskillbtn">Add</button>
      </div>
    </div>

  </div>
</div>


</body>

<script type="text/javascript">
	
	$(document).ready(function(){
		$('.addnewtag').click(function(e){
			$('#addnewtag').modal('toggle');
		})

		$('#addnewtagbtn').click(function(e){
			$.post('/summary/addnewtag',{'tag_name':$('#tagname').val()}, function(data){
				var obj = $.parseJSON(data);
				if(obj.resp == '1'){
					$('#addnewtag').modal('toggle');
					alert('tag added. Please refresh');
				}else{
					alert(obj.msg);
				}
			});
		});
	});
</script>

<script type="text/javascript">
	
	$(document).ready(function(){
		$('.addnewskill').click(function(e){
			$('#addnewskill').modal('toggle');
		})

		$('#addnewskillbtn').click(function(e){
			$.post('/summary/addnewskill',{'tag_name':$('#skill_name').val()}, function(data){
				var obj = $.parseJSON(data);
				if(obj.resp == '1'){
					$('#addnewskill').modal('toggle');
					alert('tag added. Please refresh');
				}else{
					alert(obj.msg);
				}
			});
		});
	});
</script>

<!-- $ is Jquery -->
<script type="text/javascript">
	$('#form_main').submit(function(e){
		e.preventDefault();
		var o = {};
		var a = $(this).serializeArray();

		console.log(a);

	    $.each(a, function() {
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });	
	    $.post('/summary/addsummary',o, function(d){
	    	console.log(d);
			var obj = $.parseJSON(d);
			if(obj.resp == '1'){
				$('#form_main').trigger('reset').trigger('change');
				alert(obj.msg);
			}else{
				alert(obj.msg);
			}
		});
	})
</script>

<script type="text/javascript">
	$('#form_main_skill').submit(function(e){
		e.preventDefault();
		var o = {};
		var a = $(this).serializeArray();

		console.log(a);

	    $.each(a, function() {
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });	
	    $.post('/summary/addjobskill',o, function(d){
	    	console.log(d);
			var obj = $.parseJSON(d);
			if(obj.resp == '1'){
				$('#form_main_skill').trigger('reset').trigger('change');
				alert(obj.msg);
			}else{
				alert(obj.msg);
			}
		});
	})
</script>



<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.full.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$("#summary_tag, #summary_for").select2();
		$("#skill_tag").select2();
	});
</script>
</html>

