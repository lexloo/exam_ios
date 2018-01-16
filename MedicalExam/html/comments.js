iTek.on("Ready", function() {
	new Vue({
		el: '#app',
		data: {
			comments: [{
				userName: "x",
				comment: "mmmmmmmmmmmmmmmmmm",
				replierGuid: "xxxxxxx",
				replierName: "y",
				replierComment: "yyyyyy"
			}, {
				userName: "x",
				comment: "sdfhis",
				replierGuid: ""
			}]
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

// String questionGuid = questionDiscuss.getQuestionGuid();
// String userGuid = questionDiscuss.getUserGuid();
// String userName = questionDiscuss.getUserName();
// String comment = questionDiscuss.getComment();

// UserInfo userInfo = QuestionBankAppplication.getInstance().getUserInfo();
// String replierGuid = userInfo.getGuid();
// String replierName = userInfo.getName();
// String replierComment = mComment.getText().toString();

// RemoteDataReader.saveReplyComment(questionGuid, userGuid, userName, comment, replierGuid, replierName, replierComment);

// QuestionDiscuss qd = new QuestionDiscuss();
// qd.setQuestionGuid(questionDiscuss.getQuestionGuid());
// qd.setUserGuid(questionDiscuss.getUserGuid());
// qd.setUserName(questionDiscuss.getUserName());
// qd.setComment(questionDiscuss.getComment());
// qd.setReplierGuid(userInfo.getGuid());
// qd.setReplierName(userInfo.getName());
// qd.setReplierComment(replierComment);