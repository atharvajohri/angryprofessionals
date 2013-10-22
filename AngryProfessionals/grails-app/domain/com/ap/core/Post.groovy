package com.ap.core

import com.ap.secure.SecUser

class Post {

	SecUser addedBy
	String name
	String title
	String text
	Date dateCreated
	Boolean adviceEnabled = true
	Boolean enabled = true
	static hasMany = [advice: Advice]
	
	static mapping = {
		text type: "text"
		sort dateCreated: "desc"
	}
	
    static constraints = {
		title nullable:true
		addedBy nullable:true
		text blank: false
		name nullable: true
    }
}
