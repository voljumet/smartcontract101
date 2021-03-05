pragma solidity 0.7.5;

contract Ownable {
    
    address[] public owners;
    uint numberOfSignatures;
    bool owner = false;

    modifier onlyOwner { 
        for (uint8 i = 0; i < owners.length; i++){
                if (owners[i] == msg.sender){
                    owner = true;
                }
            }
        require(owner, "You are not allowed to interact with the contract!"); 
        owner = false;
        _; // run the function
    }
}