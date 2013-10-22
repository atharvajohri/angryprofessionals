package com.ap.core

import grails.converters.JSON

class PostController {

	def springSecurityService
	
    def index() { }
	
	def addAdvice(){
		def returnMap = [:]
		if (params.adviceText){
			def advice = new Advice(post: Post.get(Long.parseLong(params.adviceId.toString())), text: params.adviceText, name: params.adviceName ?: "Anonymous") 
			if (advice.save()){
				returnMap.success = true
				returnMap.post = post
			}else{
				log.info "could not add advice"
				advice.errors.each {
					println it
				}
				returnMap.success = false
				returnMap.errors = advice.errors
			}
		}else{
			params.blankText = true
		}
		
		render returnMap as JSON
	}
	
	def add() {
		def returnMap = [:]
		if (params.text){
			def user, name
			if (params.user_type_radio != "anon"){
				user = springSecurityService.getCurrentUser()
				name = params.name ?: null
			}
	 		def post = new Post(text: params.text, title: params.title, name: name, addedBy : user ?: null, adviceEnabled: (params.advice == "on" ? true: false))
			if (post.save()){
				returnMap.success = true
				returnMap.post = post
			}else{
				log.info "could not post"
				post.errors.each{
					println it
				}
				returnMap.success = false
				returnMap.errors = post.errors
			}
		}else{
			returnMap.blankText = true
		}
		
		render returnMap as JSON
	}
	
	def getPost() {
		def posts = []
		if (params.id)
			posts.push(Post.get(Long.parseLong(params.id.toString())))
		else
			posts = Post.findAllByEnabled(true)
		render(template: "postTemplate", model: [posts: posts])
	}
}
