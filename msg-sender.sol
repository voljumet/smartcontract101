pragma solidity 0.7.5;

contract HelloWorld {

    
    function hello(int number) public view returns(string memory) { 
        
        if(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4){
            return message;
        }
        else{
            return "wrong address";
        }
        return message;
    }
}