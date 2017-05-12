function reviewPage() {

    var seconds = 60;
    var secondsArea = document.getElementById('seconds-left');

    var questionHeader = document.getElementById('question-number');
    var questionOneDescription = document.getElementById('question-1-description');
    var questionTwoDescription = document.getElementById('question-2-description');
    var questionOneAnswer = document.getElementById('ans1');
    var questionTwoAnswer = document.getElementById('ans2');

    var nextQuestionButton = document.getElementById('nextq-button');
    var submitButton = document.getElementById('submit-button');

    nextQuestionButton.addEventListener("click", function () {
        nextQuestionButton.style.display = 'none';
        submitButton.style.display = 'inherit';
        questionHeader.innerHTML = 2;
        questionOneDescription.style.display = 'none';
        questionTwoDescription.style.display = 'inherit';
        questionOneAnswer.style.display = 'none';
        questionTwoAnswer.style.display = 'inherit';
    });

    var reviewTimer = setInterval(function () {
        secondsArea.innerHTML = --seconds;
        if (seconds <= 0) {
            clearInterval(reviewTimer);
            alert("Δυστυχώς δεν πρόλαβες πριν λήξει ο χρόνος :-(");
            window.history.back();
        }
    }, 1000);

}

function practiceHelpPage() {
    var helpArea = document.getElementById('help-text');
    var helpButton = document.getElementById('help-button');
    var form = document.getElementById('main-form');
    var answerField = document.getElementById('answer');
    var i = 0;
    var helps = arguments;

    helpButton.addEventListener("click", function () {
        helpArea.innerHTML = helps[i];
        i++;
        if (i >= helps.length) {
            i = 0;
        }
    });

    form.addEventListener("submit", function (e) {
        var fixedValue = answerField.value.replace(/\s|\n/g, '');
        answerField.value = fixedValue;
    });


}

function practiceSchemaPage() {
    var $helpButton = $('#help-button');
    var form = document.getElementById('main-form');
    var answerField = document.getElementById('answer');

    $helpButton.click(function () {
        $('#schema-modal').modal('show');
    });

    form.addEventListener("submit", function (e) {
        var fixedValue = answerField.value.replace(/\s|\n/g, '');
        answerField.value = fixedValue;
    });


}

function lecturePage() {
    var form = document.getElementById('lecture-form');
    var answerField = document.getElementById('ans');
    form.addEventListener("submit", function (e) {
        var fixedValue = answerField.value.trim();
        answerField.value = fixedValue;
    });


}

function teacherPage(commentsArray) {
    commentsArray = commentsArray.substr(1, commentsArray.length - 2).split(',');
    
    var commentsList = document.getElementById('comments');

    commentsArray.forEach(function (comment) {
        var li = '<li class="student-element">'
            + '<div class="ui card student-card">'
            + '<div class="content">'
            + '<div class="header">'
            + comment
            + '</div></div></div></li>';
        commentsList.insertAdjacentHTML('beforeend',li);
    });

}
