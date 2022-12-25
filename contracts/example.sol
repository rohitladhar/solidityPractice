// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

contract MyContract{
    // State variables

    uint public myUint  = 1;
    string public myStr = "Hello Solidity";
    address public myAddress = 0xE5D5b62D60fA2C5D25Cf2E805995349ebbfb0D88;
    struct Mystruct {
        uint256 myVar;
        string myString;
    }

    Mystruct public myStruct = Mystruct(1,"Hello Solidity");

    //Local Variables
    function getValue() public pure returns(uint){
        uint value = 1;
        return value;
    }

    uint[] public uintArray = [1,2,3];
    string[] public stringArray = ["apple","banana","carrot"];
    string[] public values;
    uint256[][] public array2D = [[1,2,3],[4,5,6]];

    function addValue(string memory _value) public{
        values.push(_value);
    }

    function valueCount() public view returns(uint){
        return values.length;
    }


}