new Vue({
	el: '#app',
	data: {
		questions: null
	},
	computed: {
		title: function() {
			return this.chapterName;
		}
	},
	methods: {
		doQuestion: function(index, guid) {
			__Native__.startDoQuestion(parseInt(index), this.subjectName, this.chapterGuid, this.chapterName, this.type);
		}
	},
	created: function() {
		this.chapterGuid = getUrlKey('chapterGuid');
		this.chapterName = getUrlKey('chapterName');
		this.subjectName = getUrlKey('subjectName');
		this.type = getUrlKey('type');

		this.questions = JSON.parse(__Native__.getChapterQuestion(this.chapterGuid, this.type));
	}
});

function getUrlKey(name) {
	return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.href) || [, ""])[1].replace(/\+/g, '%20')) || null;
};