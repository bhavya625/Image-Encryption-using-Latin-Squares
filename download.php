<?php
		   if(isset($_POST['var']))
			   $var=$_POST['var'];
			$filename=$var;
			
			$file="c:\\wamp\\www\\bhavya\\resultimages\\$filename";

			sleep(25);
			$len = filesize($file); // Calculate File Size
			ob_clean();
			header("Pragma: public");
			header("Expires: 500");
			header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
			header("Cache-Control: public"); 
			header("Content-Description: File Transfer");
			header("Content-Type:image/jpeg"); // Send type of file
			$header="Content-Disposition: attachment; filename=$filename;"; // Send File Name
			header($header );
			header("Content-Transfer-Encoding: binary");
			header("Content-Length: ".$len); // Send File Size
			@readfile($file);
?>