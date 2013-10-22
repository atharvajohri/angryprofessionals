<g:each in="${posts }" var="post">
	<div class="post-container post-${post.id ?: '0' }">
		<g:if test="${post.adviceEnabled }">
			<div class="add-advice-btn" rel="${post.id }">
				<img src="/images/icons/icon7.JPG" />
			</div>
		</g:if>
		<g:if test="${post.title }">
			<div class="post-title">
				${post.title.encodeAsHTML()}
			</div>
		</g:if>
		<div class="post-text">
			${post.text.encodeAsHTML() }
		</div>
	</div>
</g:each>