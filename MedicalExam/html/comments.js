iTek.on("Ready", function() {
	new Vue({
		el: '#app',
		data: {
			comments: []
		},
		methods: {
			addComment: function(questionGuid, userGuid, userName, comment) {
				alert("kkk");
			}
		},
		created: function() {
			var questionGuid = iTek.local["questionGuid"];

			var that = this;

			iTek.qb.getComments({
				questionGuid: questionGuid
			}, function(result) {
				that.comments = result;
			});
		}
	});
});
