document.addEventListener('turbolinks:load', function () {
    let progress = document.querySelector('.progress-bar');

    if (progress) {
        let questionNumber = progress.dataset.questionPosition;
        let questionsCount = progress.dataset.questionsCount;

        progress.style.width = Math.floor(questionNumber / questionsCount * 100) + '%'
    }
})