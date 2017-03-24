<html>
 <head>
  <title>Image Encryption</title>
  <link href="encryption.css" type="text/css" rel="stylesheet" >
  </head>
 <body>
  <div id="wrapper">
  
	
	 <div id="header">
		<img src="images/menu-bg.png" width="100%" height="30%"/>
		<h3 style="font-family:'Arial Black'; font-weight:900; margin-top:-10%; margin-left:35%; color:pink; font-size:250%;">IMAGE ENCRYPTION</h3>
				
	</div>
	 <div id="leftnav">
	<marquee direction="down" behavior="scroll" loop="infinite" scrolldelay="10" height="120%"> 
	<ul style="list-style:none">

	<li> <img src="images/conf1.jpg" width="13%" height="50%"/><a href="#"></a></li><br/>
	<li> <img src="images/conf2.jpg" width="13%" height="50%"/><a href="#"></a></li><br/>
	<li> <img src="images/conf3.jpg" width="13%" height="50%"/><a href="#"></a></li><br/>
	<li> <img src="images/conf4.jpg" width="13%" height="50%"/><a href="#"></a></li><br/>

	</ul> 
	</marquee>

	 </div>

	 <div id="rightnav">
	<marquee direction="down" behavior="scroll" loop="infinite" scrolldelay="10" height="58%"> 
	<ul style="list-style:none">

	<li> <img src="images/conf5.jpg" width="55%" height="50%"/><a href="#"></a></li><br/>
	<li> <img src="images/conf6.jpg" width="55%" height="50%"/><a href="#"></a></li><br/>
	<li> <img src="images/conf7.jpg" width="55%" height="50%"/><a href="#"></a></li><br/>
	<li> <img src="images/conf8.jpg" width="55%" height="50%"/><a href="#"></a></li><br/>
	
	</ul> 
	</marquee>

	 </div>

	 <div id="body">
	 <p style="font-family:'Arail Black'; font-size:150% ">This site helps you to encrypt your confidential images before sending them through internet.</p>
	 <p style="font-family:'Arail Black'; font-size:120%; margin-left: 5%"><b>You have selected this image to encrypt</b></p>
	<?php
			$filename = $_FILES['uploadFile'] ['name'];
			if ( move_uploaded_file ($_FILES['uploadFile'] ['tmp_name'], "C:/wamp/www/bhavya/upload/{$_FILES['uploadFile'] ['name']}")  )
		{
	//		print '<p> The file has been successfully uploaded </p>';
		}
		else
		{ 
	        switch ($_FILES['uploadFile'] ['error'])
		     {  
				case 1:
				       print '<p> The file is bigger than this PHP installation allows</p>';
					   break;
	            case 2:
		               print '<p> The file is bigger than this form allows</p>';
			           break;
				case 3:
					   print '<p> Only part of the file was uploaded</p>';
						break;
	            case 4:
		               print '<p> No file was uploaded</p>';
			           break;
			}
		}
		$inputDir  = "C:\\wamp\\www\\bhavya\\matlab";
		$outputDir = "C:\\wamp\\www\\bhavya\\upload";
	    $command = "matlab -sd ".$inputDir." -r demo4('".$outputDir."\\".$filename."','".$filename."')";
		exec($command) ;
		//echo "the command is executed";
		$dir=array('http://localhost/bhavya/upload',$filename);
		$b=implode("/",$dir);
		$c='cipher1'.$filename;
		
?>
<img src="<?php echo $b ?>" style="margin-left:5%; margin-top:0%;"/>
<p style="font-family:'Arial Black'; font-size:100%; margin-left:40%; margin-top:-26.2%; font-style:none;">Download the cipher image</p>';
<form action="download.php" method="post">
<input type='hidden' name='var' value="<?php echo $c; ?>"/> 
<input type="submit" value="Download" style="margin-left:45%; margin-top:10%;">
</form>

</div>

	 <div id="footer">
	<p> © Copyrights reserved </p>
	 </div>

</div>
</body>
</html>
