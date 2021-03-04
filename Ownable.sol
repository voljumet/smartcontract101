pragma solidity 0.7.5;

contract Ownable {
    address public owner;
    
    modifier onlyOwner { 
        require(msg.sender == owner, "You are not the owner of the contract!"); 
        _; // run the function
    }

    constructor(){
        owner = msg.sender;
    }
    
}