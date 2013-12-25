<!doctype html>
<html>
	<head>
		<title>Angry Professionals</title>
		<link rel="shortcut icon" href="${resource(dir: 'images/icons', file: 'favicon.ico')}" type="image/x-icon">
		<style>
			body {margin: 0; padding: 0; font-family:"Times New Roman", "serif";font-size:13px}
				#main-container {margin:auto;border-bottom:none;background:#fff}
					#header-container{}
						#top-header {background:black;}
							#header-content-container {height:165px;background: url('/images/backgrounds/header.png') no-repeat;background-size:100% 100%;position:relative;cursor:pointer}
								#our-story-btn {position:absolute;bottom:10px;right:10px;}
						#bottom-header{height:66px;position:relative;text-align:right;padding-right:10px;padding-top:7px}
							#post-btn {position:absolute;right:220px;top:-14px;background:url('/images/icons/postbtn.png') no-repeat;background-size:100% 100%;height:83px;width:80px;cursor:pointer}
					
					#body-container {;margin-bottom:10px}
					
					#footer-container {color:#fff;padding:5px;text-align:center; background:#000;font-size:17px;}
			.limit-width {width:1000px;margin:auto}
			.button {font-size:16px; color:#000; cursor:pointer}
			.contrast {color:#fff;background:#000}
			.bold {font-weight:bolder}
			.no-scroll {overflow:hidden}
			.hide {display:none}
			#main-overlay {width:100%;height:100%;position:fixed;top:0px;left:0px;background:#000;opacity:0.6;z-index:20;display:none}
			.popup {width:500px;top:20px;background:#fff;position:fixed;z-index:40;box-shadow:0px 0px 8px 0px #444; display:none; overflow-y:auto}
				.popup-title {font-size:20px;text-align:center;background:black;color:#fff;padding:5px;font-weight:bold;}
				.popup-content {background:#f4f4f4;padding:10px 20px;}
					.form-fields-container td {padding:10px;font-size:15px;}
					.new-post-field {width:300px;border:1px solid #cdcdcd;padding:5px;font-size:14px;}
					.normal-field {width:200px;}
					.post-btn {text-align:center;padding:7px;min-width:120px;background:#2174dc;color:#fff;font-size:18px;border:none;
						font-family:"Times New Roman", "serif";border:2px solid #215da5;
						border-top:2px solid #82aadb;border-left:2px solid #82aadb;cursor:pointer;float:left;}
					.close-btn {display:inline-block;float:right;font-size:18px;cursor:pointer;}
					#post-actions-container {overflow:auto;position:relative;}
			#post-popup {margin-top:120px;}
			#server-message-container {width:500px;position:fixed;top:10px;background:#f4f4f4;color:#000;z-index:80;display:none;}
				#server-message {padding:10px;text-align:center} 
			
			#ap-our-story-container, .post-container, .post-box, .af-input {background:#edf7f9;color:#000;width:260px;margin-bottom:10px;padding:12px;font-family: "Arial", "sans-serif"; box-shadow:0px 0px 2px 0px #555; position:relative}
			.post-box {width:auto}
				.add-advice-btn {position:absolute;top:0px;right:0px;cursor:pointer}
				.post-title {color:#2502fe;font-weight:bold;}
				.post-text {max-height:300px;overflow-y:auto;}
			
			.advice-text-input {width:450px;height:150px;}
			
			#add-advice-container {margin-top:20px;}
				#coa-container {padding:0px 10px;font-size:15px;margin-top:15px;color:#555}
				.ac-name-box {font-family:serif; padding: 7px 0px;}
				.ac-advice-box {font-family:sans-serif; padding-bottom: 5px;border-bottom:1px solid #555 }
				.ac-advice-box:last-child {border-bottom:none}
			#posts-viewport {padding:10px;}
			
			#af-table {border-spacing: 10px;width:100%;}
				.af-input {box-shadow:1px 1px 2px 0px #888; border:2px solid #f4f5f6; width:150px;background:#fff}
				#af-search {background:#2174dc;color:#fff;border:none;cursor:pointer}
			
			#ap-our-story {text-align: center;}
			#ap-our-story-container {width:550px;height:300px;text-align:center;margin: auto; margin-bottom:15px;position:relative;}
			#ap-our-story-container .main-text {font-weight:bold;font-family:"Comic Sans MS"; font-size:15px; line-height: 22px	}
			
			.baseline {position:absolute;bottom:10px;text-align: center;width:550px;font-family: serif;font-size:14px;}
		</style>
		<g:javascript plugin="jquery" library="jquery"></g:javascript>
		<script type="text/javascript" src="/js/ko.js"></script>
		<r:layoutResources/>
	</head>
	<body>
		<div id="server-message-container">
			<div id="server-message"></div>
		</div>
		<div id="main-overlay"></div>
		<div id="post-popup" class='popup'>
			<div class="popup-title">
				Your Story
			</div>
			<div class="popup-content">
				<g:form controller="post" action="add">
					<div class="form-fields-container">
						<table>
							<tr>
								<td colspan="2">
									<g:radio checked="checked" name="user-type-radio" value="anon"/> Anonymous
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<g:radio name="user-type-radio" value="name"/>
									Name: <g:textField name="name" class="new-post-field normal-field" />
								</td>
							</tr>
							<tr>
								<td>Title</td>
								<td><g:textField name="title" class="new-post-field"/>
							</tr>
							<tr>
								<td valign="top">Story*</td>
								<td><g:textArea name="text" class="new-post-field post-text"/>
							</tr>
							<tr>
								<td colspan=2><g:checkBox name="advice"/> &nbsp;&nbsp;I want viewers to advise me</td>
							</tr>
							<tr>
								<td colspan=2>
									<div id="post-actions-container">
										<g:submitToRemote url="[controller:'post', action:'add']" onSuccess="addPostCallback(data)" name="submitPost" value="Post" class="post-btn"/>
										<div id="close-post" class="close-btn">Cancel</div>
									</div>
								</td>
							</tr>
						</table>
					</div>				
				</g:form>
			</div>
		</div>
		<div id="post-details" class="popup">
			
		</div>
		<div id="add-advice-container" class="popup">
			<div class="popup-title">
				Add Advice
			</div>
			<div class="popup-content">
				<g:form controller="post" action="addAdvice">
					<table>
						<tr>
							<td colspan=2>
								<g:textArea name="adviceText" class="advice-text-input"/>		
							</td>
						</tr>
						<tr>
							<td>Name:</td>
							<td><g:textField name="adviceName" class="new-post-field" /></td>
						</tr>
						<tr>
							<td colspan=2 align="center">
								<g:hiddenField id="advice-id" name="adviceId"/>
								<g:submitToRemote class="post-btn" url="[controller:'post', action:'addAdvice']" onSuccess="addAdviceCallback(data)" name="submitAdvice" value="Advice" class="post-btn"/>
								<div id="close-advice" class="close-btn">Cancel</div>							
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<div id="coa-container" class="post-box">
									<div id="adive-set-container" data-bind="foreach: advice">
										<div class="ac-name-box" data-bind="text: name">
										
										</div>
										<div class="ac-advice-box" data-bind="text: text">
										
										</div>								
									</div>
								</div>
							</td>
						</tr>
					</table>
				</g:form>
			</div>
		</div>
		<div id="main-container" class="container">
			<div id="header-container" class="container">
				<div id="top-header" >
					<div id="header-content-container" class="limit-width ">
						<div class="button contrast bold" id="our-story-btn">OUR STORY</div>
					</div>
				</div>
				 <div id="bottom-header" class="limit-width ">
				 	<div id="post-btn"></div>
				 	<div class="button bold" id="ap-archives">ARCHIVES</div>
				 	<div class="button bold" id="">AP ON FACEBOOK</div>
<%--				 	<div class="button bold" id="signup">SIGN UP/LOG IN</div>--%>
				 </div>
			</div>
			<div id="body-container" class="container limit-width">
				<div id="archive-filter">
					<table id="af-table">
						<tr>
							<td>Title</td><td>Month</td><td>Year</td><td></td>
						</tr><tr>
							<td>
								<input id="af-title" type="text" class="af-input">
							</td>
							<td>
								<select id="af-month" class="af-input">
									<option value="">&nbsp;</option>								
									<option value="0" selected="selected">Jan</option>
									<option value="1">Feb</option>
									<option value="2">Mar</option>
									<option value="3">Apr</option>
									<option value="4">May</option>
									<option value="5">Jun</option>
									<option value="6">Jul</option>
									<option value="7">Aug</option>
									<option value="8">Sep</option>
									<option value="9">Oct</option>
									<option value="10">Nov</option>
									<option value="11">Dec</option>
								</select>
							</td>
							<td>
								<input id="af-year" type="text" class="af-input" >
							</td>
							<td>
								<input type="button" value="Search" id="af-search" class="af-input">
							</td>
						</tr>
					</table>
				</div>
				<div id="posts-viewport">
					
				</div>
				<div id="ap-our-story">
					<h1>OUR STORY</h1>
					<div id="ap-our-story-container">
						<div class="main-text">
							Angry Professionals was started for a simple reason that professionals can vent out anger, frustration and any sort of feelings
							that they face at their work place.
						</div>
						<div class="baseline">
							For further information you can reach us at<br>
							angryprofessionals@gmail.com
						</div>
					</div>
				</div>
			</div>
			<div id="footer-container" class="container">
				Copyright AngryProfessionals.com 2013. All rights
			</div>
		</div>

		<script type="text/javascript" src="/js/frameworks/masonry.js"></script>				
		<g:javascript library="application"/>
		<r:layoutResources/>
	</body>
</html>