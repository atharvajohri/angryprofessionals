package com.ap.core

import grails.converters.JSON
import static java.util.Calendar.YEAR

class PostController {

	def springSecurityService, validationUtilsService
	
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
	
	def getFilteredPosts(){
//		log.info "got req \n$params"
		def posts = []
		def year = false, month = false, title = false
		if (params.year && validationUtilsService.isInteger(params.year.toString()) && params.year.toString().size() == 4  ){
			year = Integer.parseInt(params.year.toString())
		}
		
		if (params.month && validationUtilsService.isInteger(params.month.toString()) && Integer.parseInt(params.month) < 12){
			month = Integer.parseInt(params.month.toString())
		}
		
		def c = Post.createCriteria()
		def curDate = new Date()
		def dateStart = new Date(), dateEnd = new Date()
		def calendar = GregorianCalendar.getInstance()
		
		def ys, ye, ms, me, ds = 28, de = 1
		
		if (year){
			if (month || month == 0){
				if (month == 11){
					ys = year
					ye = year + 1
					ms = 10
					me = 0	
				}else if (month == 0){
					ys = year - 1
					ye = year
					ms = 11
					me = 1
				}else{
					ys = year
					ye = year
					ms = month - 1
					me = month + 1
				}
			} else{
				ys = year - 1
				ms = 11
				ye = year + 1
				me = 0
			}
		}else if (month || month == 0){
			if (month == 11){
				ys = curDate[YEAR]
				ye = curDate[YEAR] + 1
				ms = 10
				me = 0
			}else if (month == 0){
				ys = curDate[YEAR] - 1
				ye = curDate[YEAR]
				ms = 11
				me = 1
			}else{
				ys = curDate[YEAR]
				ye = curDate[YEAR]
				ms = month - 1
				me = month + 1
			}
		}else{
			ys = 2012
			ye = curDate[YEAR] + 1
			ms = 0
			me = 0
		}
		
//		log.info "$params"
		calendar.set(ys, ms, ds)
		dateStart = calendar.getTime()
		calendar.set(ye, me, de)
		dateEnd = calendar.getTime()
		
//		log.info "\n $dateStart \n $dateEnd"
		def filteredPosts = c.list {
			like("title", "%${params.title}%")
			and {
				between ("dateCreated", dateStart, dateEnd)
			}
			maxResults(100)
			order("dateCreated", "desc")
		}
		
		render(template: "postTemplate", model: [posts: filteredPosts])
	}
	
	def getAdviceForPost(){
		def advice = []
		if (params.post){
			def post = Post.get(params.post)
			if (post)
				advice = post.advice
		}
		
		render advice as JSON
	}
}
