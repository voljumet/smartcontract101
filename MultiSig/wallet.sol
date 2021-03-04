pragma solidity 0.7.5;
pragma abicoder v2;

import "./Ownable.sol";

contract Wallet is Ownable {
    
    bool checker = false;
    struct Transfer {
        address ownerAddress;
        uint value;
    }
    
    struct Approval {
        address signing;
        address needsSignature;
    }
    
    Transfer[] transferRequests;
    Approval[] approval;
    
    constructor(address addr1, address addr2, uint _numberOfSignatures){
        adder(msg.sender);
        adder(addr1);
        adder(addr2);
        numberOfSignatures = _numberOfSignatures;
    }
    
    //support function to constructor
    function adder(address addrIn) internal{
        owners.push(addrIn);
    }
    
    function deposit() public payable returns (uint){
        return address(this).balance;
    }
    
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
    
    function requestTransfer(uint requestSum) public onlyOwner returns (string memory){
        if(address(this).balance >= requestSum){
            transferRequests.push(Transfer(msg.sender,requestSum));
            return "Transfer request sent!";
        } else {
            return "Not enough tokens!";
        }
    }
    
    function getResquests() public view returns(Transfer[] memory){
        return transferRequests;
    }
    
    function approve(address toAddr) public onlyOwner {
        approval.push(Approval(msg.sender, toAddr));
    }
    
    function checkApprovals(address toAddr) public returns(address[] memory){
        address[] memory temp = new address[](approval.length);
        for(uint i = 0;i < approval.length ;i++){
            if(toAddr == approval[i].needsSignature){
                temp[i] = approval[i].signing;
                if(checker){
                    delete approval;
                }
            }
        }
        checker = false;
        return temp;
    }
    
    function withdraw(uint amount) public onlyOwner returns (string memory, uint) {
        uint sum = address(this).balance;
        require(sum >= amount, "Insufficient funds");
        string memory message;
        if(checkApprovals(msg.sender).length >= numberOfSignatures){
            checker = true;
            sum -= amount;
            msg.sender.transfer(amount);
            checkApprovals(msg.sender);
            message = "Transfer complete";
        } else {
            message = "Transfer not complete";
        }
        return (message,address(this).balance);
    }
}