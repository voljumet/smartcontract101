pragma solidity 0.7.5;

import "./Ownable.sol";

contract Destroyable is Ownable {
    
    function destroyContract() public onlyOwner {
        address payable reciever = msg.sender;
        selfdestruct(reciever);
    }
}