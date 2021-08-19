document.addEventListener('turbolinks:load', function () {
  let timer = document.querySelector('.timer')

  if (timer) {
    let timeRemaining = timer.dataset.remainingTime;
    startTimer(timer, timeRemaining);
  }
})

function startTimer(control, remainingTime) {
  if (remainingTime > 0) {
    let timerContent = document.querySelector('.timer_content');
    timerContent.textContent = formatTime(remainingTime);
    remainingTime--;
    setTimeout(startTimer, 1000, control, remainingTime);
  } else {
    window.location.reload();
  }
}

function formatTime(numberOfSecs) {
  let seconds = numberOfSecs % 60
  let minutes = (numberOfSecs - seconds) / 60

  if (seconds < 10) {
    seconds = `0${seconds}`
  }

  return minutes + ':' + seconds
}
