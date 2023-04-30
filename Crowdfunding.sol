pragma solidity ^0.8.0;

contract Crowdfunding {
    address payable public owner;
    uint public goal;
    uint public raisedAmount;
    mapping(address => uint) public contributions;
    bool public goalReached;

    constructor(uint _goal) {
        owner = payable(msg.sender);
        goal = _goal;
    }

    function contribute() public payable {
        require(!goalReached, "The funding goal has already been reached");
        contributions[msg.sender] += msg.value;
        raisedAmount += msg.value;
        if (raisedAmount >= goal) {
            goalReached = true;
        }
    }

    function withdraw() public {
        require(goalReached, "The funding goal has not been reached yet");
        require(msg.sender == owner, "Only the owner can withdraw the funds");
        owner.transfer(address(this).balance);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
