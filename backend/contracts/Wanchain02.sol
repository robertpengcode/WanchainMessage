// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@wandevs/message/contracts/app/WmbApp.sol";

//Deploy on wanchain
//0xEB14407Edc497a73934dE08D5c3079BB1F5f145D
//admin: 0xC8e5a1d3ADfF41B662aaf834BA11B95660A6c86b
contract Wanchain02 is WmbApp {
    address public owner;
    bytes32 public messageIdFrom;
    bytes public messageFrom;

    event ReceivedMessage(
        bytes receivedData,
        bytes32 indexed messageId,
        uint256 indexed fromChainId,
        address indexed fromAddress
    );

    event SentMessage(
        bytes sentData,
        uint256 indexed toChainId,
        address indexed toAddress
    );

    constructor(address admin, address _wmbGateway) WmbApp() {
        initialize(admin, _wmbGateway);
        owner = admin;
    }

    function _wmbReceive(
        bytes calldata data,
        bytes32 messageId,
        uint256 fromChainId,
        address fromSC
    ) internal override {
        messageFrom = data;
        messageIdFrom = messageId;
        emit ReceivedMessage(data, messageId, fromChainId, fromSC);
    }

    //gasLimit 200,000
    function sendMessage(
        uint256 toChainId,
        address toAddress,
        bytes memory msgData,
        uint256 gasLimit
    ) public payable {
        uint256 fee = estimateFee(toChainId, gasLimit);
        require(msg.value >= fee, "Insufficient fee");
        _dispatchMessage(toChainId, toAddress, msgData, msg.value);
        emit SentMessage(msgData, toChainId, toAddress);
    }
}
