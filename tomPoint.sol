// SPDX-License-Identifier: MIT
// このソフトウェアは、MITライセンスの下で公開されています。

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TomPoint is ERC20 {
    address public parent; // 親のアドレス
    mapping(address => bool) public children; // 子供のアドレスのマッピング
    mapping(address => uint256) public requests; // トークン要求のマッピング
    mapping(address => uint256) public ethRequests; // ETH要求のマッピング

    // コンストラクタ
    constructor() ERC20("TomPoint", "TMP") {
        parent = msg.sender; // コントラクトをデプロイしたアドレスを親として設定
        _mint(parent, 10000 * (10 ** uint256(decimals()))); // 初期供給量を設定
    }

    // トークンの小数点以下の桁数を取得
    function decimals() public view virtual override returns (uint8) {
        return 0; // 1ポイントはこれ以上分割できないため、小数点以下の桁数は0
    }

    // 子供を追加
    function addChild(address child) external {
        require(msg.sender == parent, "Children can only be added by the parent");
        children[child] = true; // 子供のアドレスをマッピングに追加
    }

    // トークンを要求
    function requestTokens(uint256 amount) external {
        require(children[msg.sender], "Only registered children can request tokens");
        requests[msg.sender] += amount; // 要求量を累計
    }

    // 要求されたトークンの量を減らす
    function reduceRequest(address child, uint256 amount) external {
    require(msg.sender == parent, "Only the parent can reduce requests");
    require(requests[child] >= amount, "Cannot reduce more than the requested amount");
    requests[child] -= amount;
    }

    // 要求を承認
    function approveRequest(address child) external {
        require(msg.sender == parent, "Requests can only be approved by the parent");
        uint256 amount = requests[child]; // 承認する量を取得
        _transfer(parent, child, amount); // トークンを移動
        requests[child] = 0; // 要求をリセット
    }

    // 子供から親へのトークンの移動
    function returnTokensToParent(address child, uint256 amount) external {
        require(msg.sender == parent, "Only the parent can initiate this transaction");
        require(balanceOf(child) >= amount, "Child does not have enough tokens");

        _transfer(child, parent, amount);
    }

    // 子供を削除
    function removeChild(address child) external {
        require(msg.sender == parent, "Children can only be removed by the parent");
        children[child] = false; // 子供のアドレスをマッピングから削除
    }
    
    // 子供から親にETHを請求する関数
    function requestETH(uint256 amount) external {
        require(children[msg.sender], "Only registered children can request ETH");
        ethRequests[msg.sender] += amount; // 要求量を累計
    }

    // 親がETHを支払う関数
    function payETH(address child) external payable {
        require(msg.sender == parent, "Only the parent can pay ETH");
        require(ethRequests[child] <= msg.value, "Payment does not cover the requested amount");
        payable(child).transfer(ethRequests[child]); // ETHを子供に送る
        ethRequests[child] = 0; // 要求をリセット
    }


}
