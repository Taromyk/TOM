function getFortune() {
    const randomNum = Math.floor(Math.random() * 30);
    let fortune = '';
    let eth = 0;

    if (randomNum === 0) {
        fortune = '大吉 0.0001ETH';
        eth = 1; // ここを整数に変更
    } else if (randomNum <= 5) {
        fortune = '吉 0.00007ETH';
        eth = 7; // ここを整数に変更
    } else if (randomNum <= 15) {
        fortune = '中吉 0.00003ETH';
        eth = 3; // ここを整数に変更
    } else {
        fortune = '小吉 0.00001ETH';
        eth = 1; // ここを整数に変更
    }

    const fortuneElement = document.getElementById('fortune');
    if (fortuneElement) {
        fortuneElement.innerText = '今日の運勢は: ' + fortune;
    }

	let total = parseFloat(localStorage.getItem('totalETH')) || 0;
    const newTotal = total + eth;
    localStorage.setItem('totalETH', newTotal.toString());

    const totalEthElement = document.getElementById('totalETH');
    if (totalEthElement) {
        totalEthElement.innerText = '合計: ' + (newTotal / 100000).toFixed(5) + ' ETH';
    }   
}