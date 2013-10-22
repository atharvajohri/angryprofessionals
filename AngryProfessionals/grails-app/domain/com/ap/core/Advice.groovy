package com.ap.core

import com.ap.secure.SecUser

class Advice {
	
	static belongsTo = [post:Post]
	String text
	SecUser addedBy
	String name
	Date dateCreated
	Boolean allowAdvice = false
	Boolean enabled = true
	static mapping = {
		text type: "text"
	}
    
	static constraints = {
		text blank: false
		addedBy nullable:true	
		name nullable:true
    }
}
