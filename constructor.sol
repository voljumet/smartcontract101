pragma solidity 0.7.5;

contract HelloWorld {
    
    // state variables
    string message;
    
    constructor(string memory _message){
        message = _message;
    }
    
    function hello(int number) public view returns(string memory) { 
        
        if(number == 10){
            return message;
        }
        else{
            return "wrong number";
        }
        return message;
    }
}