pragma solidity 0.7.5;

contract HelloWorld {

    int[] numbers;
    
    function addNumber(int _number) public {
        numbers.push(_number);
        
    }
    
    function getNumber() public view returns(int[] memory){
        return numbers;
    }
    
}