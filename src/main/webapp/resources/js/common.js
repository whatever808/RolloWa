/* ---------------------------------------- 이예찬 ---------------------------------------- */
// css 이벤트 요소 발생시 애니메이션 요소 실해시키는 funtuion
const animateCSS = (element, animation, prefix = 'animate__') =>
// We create a Promise and return it
new Promise((resolve, reject) => {
const animationName = `${prefix}${animation}`;
const node = document.querySelector(element);

node.classList.add(`${prefix}animated`, animationName);

// When the animation ends, we clean the classes and resolve the Promise
function handleAnimationEnd(event) {
event.stopPropagation();
node.classList.remove(`${prefix}animated`, animationName);
resolve('Animation ended');
}

node.addEventListener('animationend', handleAnimationEnd, {once: true});
});

/* 현재 날짜 및 시간을 구해서 해당 id의 input[type=data, time]에 값을 넣어주는 스크립트문 */
const offset = new Date().getTimezoneOffset() * 60000;
const today = new Date(Date.now() - offset);
let dateData = today.toISOString().slice(0, 10);
let timeData = today.toISOString().slice(11, 16);
document.getElementById('currentDate1').value = dateData;
document.getElementById('currentTime1').value = timeData;

today.setDate(today.getDate() + 1);
today.setTime(today.getTime() + 12*1000*60*60);

dateData = today.toISOString().slice(0, 10);
timeData = today.toISOString().slice(11, 16);
document.getElementById('currentDate2').value = dateData;
document.getElementById('currentTime2').value = timeData;


/* ---------------------------------------- 이예찬 ---------------------------------------- */