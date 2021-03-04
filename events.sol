pragma solidity 0.7.5;

contract Bank {

    mapping(address => uint) balance;
    address owner;
    
    event balanceAdded(uint indexed amount, address indexed depisitedTo);
    
    modifier onlyOwner { 
        require(msg.sender == owner); 
        _; // run the function
    }
    

    constructor(){
        owner = msg.sender;
    }
    
    function addBalance(uint _toAdd) public onlyOwner returns (uint) {
        balance[msg.sender] += _toAdd;
        emit balanceAdded(_toAdd, msg.sender);
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient"); // if this throws an error, the rest of the function is not gonna run
        require(msg.sender != recipient, "Don't transfer to yourself");
        
        uint prevoiusSenderBalance = balance[msg.sender];
        
        _transfer(msg.sender, recipient, amount);    
        
        assert(balance[msg.sender] == prevoiusSenderBalance - amount);
        //event logs and further checks
    }

    // this function can only be called thom inside this contract bacause it is private
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

}