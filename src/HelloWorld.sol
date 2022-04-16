// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

contract HelloWorld {

    //event for message
    event NewMessage(string message);

    //list of messages
    string[] messages;

    //owner of the contract
    address owner;

    //list of admins
    mapping(address => bool) adminMapping; 

    //Modifier for owner check
    modifier isOwner() {
        require(msg.sender == owner, "Sender is not owner");
        _;
    }

    modifier isAdmin() {
        require(adminMapping[msg.sender], "Sender is not admin");
        _;
    }

    constructor(address _owner) {
        owner = _owner;
    }

    function addMessage(string calldata _message) public isAdmin {
        messages.push(_message);
        emit NewMessage(messages[messages.length - 1]);
    }

    function addAdmin(address _admin) public isOwner {
        adminMapping[_admin] = true;
    }
}