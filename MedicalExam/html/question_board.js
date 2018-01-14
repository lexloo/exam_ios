iTek.on("Ready", function(){
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
//                __Native__.startDoQuestion(parseInt(index), this.subjectName, this.chapterGuid, this.chapterName, this.type);
            }
        },
        created: function() {
            this.chapterGuid = iTek.local['chapterGuid'];
            this.chapterName = iTek.local['chapterName'];
            this.subjectName = iTek.local['subjectName'];
            this.type = iTek.local['type'];
        
            this.questions = JSON.parse(__Native__.getChapterQuestion(this.chapterGuid, this.type));
        }
    });
});

