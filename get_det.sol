pragma solidity 0.7.5;

contract HelloWorld {

    int[] numbers;
    
    function getNumber() public view returns(int) { 
        return number;
    }
    function setNumber(int _number) public {
        number = _number;
    }
}