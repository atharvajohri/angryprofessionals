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
							#header-content-container {height:165px;background: url('/images/backgrounds/header.png') no-repeat;background-size:100% 100%;position:relative;visibility:hidden}
								#our-story-btn {position:absolute;bottom:10px;right:10px;}
						#bottom-header{height:66px;position:relative;text-align:right;padding-right:10px;padding-top:7px}
							#post-btn {position:absolute;right:220px;top:-14px;background:url('/images/icons/postbtn.png') no-repeat;background-size:100% 100%;height:83px;width:80px;cursor:pointer}
					
					#body-container {;margin-bottom:10px}
					
					#footer-container {color:#fff;padding:5px;text-align:center; background:#000;font-size:17px;}
			.limit-width {width:1000px;margin:auto}
			.button {font-size:16px; color:#000;}
			.contrast {color:#fff;background:#000}
			.bold {font-weight:bolder}
			.no-scroll {overflow:hidden}
			#main-overlay {width:100%;height:100%;position:fixed;top:0px;left:0px;background:#000;opacity:0.6;z-index:20;display:none}
			.popup {width:500px;top:20px;background:#fff;position:fixed;z-index:40;box-shadow:0px 0px 8px 0px #444; display:none;}
				.popup-title {font-size:20px;text-align:center;background:black;color:#fff;padding:5px;font-weight:bold;}
				.popup-content {background:#f4f4f4;padding:10px 20px;}
					.form-fields-container td {padding:10px;font-size:15px;}
					.new-post-field {width:300px;border:1px solid #cdcdcd;padding:5px;font-size:14px;}
					.normal-field {width:200px;}
					.post-btn {text-align:center;padding:7px;min-width:120px;background:#2174dc;color:#fff;font-size:18px;border:none;
						font-family:"Times New Roman", "serif";border:2px solid #215da5;
						border-top:2px solid #82aadb;border-left:2px solid #82aadb;cursor:pointer;float:left;}
					.close-btn {display:inline-block;float:right;font-size:18px;position:absolute;right:10px;bottom:10px;cursor:pointer;}
					#post-actions-container {overflow:auto;position:relative;}
			#post-popup {margin-top:120px;}
			#server-message-container {width:500px;position:fixed;top:10px;background:#f4f4f4;color:#000;z-index:80;display:none;}
				#server-message {padding:10px;text-align:center} 
				
			.post-container {background:#edf7f9;color:#000;width:260px;margin-bottom:10px;padding:12px;font-family: "Arial", "sans-serif"; box-shadow:0px 0px 2px 0px #555; position:relative}
				.add-advice-btn {position:absolute;top:0px;right:0px;cursor:pointer}
				.post-title {color:#2502fe;font-weight:bold;}
				.post-text {max-height:300px;overflow-y:auto}
			
			.advice-text-input {width:450px;height:300px;}
			
			#add-advice-container {margin-top:120px;}
			#posts-viewport {padding:10px;}
		</style>
		<g:javascript plugin="jquery" library="jquery"></g:javascript>
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
<%--					<div class="user-type-container">--%>
<%--						<table>--%>
<%--							<tr>--%>
<%--								<td><g:radio checked="checked" name="user-type-radio" value="anon"/></td><td>Anonymous</td>--%>
<%--							</tr>--%>
<%--							<sec:ifLoggedIn>--%>
<%--							<tr>--%>
<%--								<td><g:radio name="user-type-radio" value="name"/>Name</td>--%>
<%--								<td><g:textField name="name" class="new-post-field normal-field" /></td>--%>
<%--							</tr>
<%--							</sec:ifLoggedIn>--%>
<%--							<sec:ifNotLoggedIn>--%>
<%--								<tr>--%>
<%--									<td colspan=2>Login to post with your name</td>--%>
<%--								</tr>--%>
<%--							</sec:ifNotLoggedIn>--%>
<%--						</table>--%>
<%--					</div>--%>
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
				 	<div class="button bold" id="">ARCHIVES</div>
				 	<div class="button bold" id="">AP ON FACEBOOK</div>
<%--				 	<div class="button bold" id="signup">SIGN UP/LOG IN</div>--%>
				 </div>
			</div>
			<div id="body-container" class="container limit-width">
				<div id="posts-viewport">
					
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