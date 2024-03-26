function getFortune() {
    
    // 現在の日付を取得
    const today = new Date().toDateString();

    // ローカルストレージから前回の日付と'tokensRequested'の値を取得
    const lastDate = localStorage.getItem('lastDate');
    const tokensRequested = localStorage.getItem('tokensRequested');

    // 前回の日付と現在の日付を比較、または'tokensRequested'が'true'かどうかを確認
    if (lastDate === today || tokensRequested !== 'true') {
        alert('今日はすでにおみくじを引いています、または役に立つ仕事がまだです。');
        return;
    }
    // おみくじのロジックをここに書く...
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

    // ローカルストレージに現在の日付を保存
    localStorage.setItem('lastDate', today);
    // おみくじを引いた後にリセット
    localStorage.setItem('tokensRequested', 'false'); 

}
