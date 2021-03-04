pragma solidity 0.7.5;
pragma abicoder v2;
import "./Destro.sol";
//import "./Ownable.sol";

interface GovernmentInterface{
    function addTransaction(address _from, address _to, uint _amount) external payable;
}

contract Bank is Ownable{
    
    GovernmentInterface governmentInstance = GovernmentInterface(0x048816Ed0f45956A297d11aa05169e476d586e2a);

    mapping(address => uint) balance;
    
    event depositDone(uint amount, address indexed depisitedTo);
    
    struct Test {
        uint number;
    }
    
    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value; // who added the balance
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender];
    }
    
    function withdraw(uint amount) public onlyOwner returns (uint) { //could add ToAddress, to withdraw to someone elses address.
        require(balance[msg.sender] >= amount, "Insufficient funds");
        balance[msg.sender] -= amount;
        msg.sender.transfer(amount);
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function getOwner() public view returns (address){
        return owner;
    }

    
    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient"); // if this throws an error, the rest of the function is not gonna run
        require(msg.sender != recipient, "Don't transfer to yourself");
        
        uint prevoiusSenderBalance = balance[msg.sender];
        
        _transfer(msg.sender, recipient, amount);    
        
        governmentInstance.addTransaction{value: 1 ether}(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == prevoiusSenderBalance - amount);
        //event logs and further checks
    }

    // this function can only be called thom inside this contract bacause it is private
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

}