pragma solidity 0.7.5;

contract Bank {

    mapping(address => uint) balance;
    
    function addBalance(uint _toAdd) public returns (uint){
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function transfer(address recipient, uint amount) public {
        //checks balance of msg.sender
        _transfer(msg.sender, recipient, amount);    
        //event logs and further checks
    }

    // this function can only be called thom inside this contract bacause it is private
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

}