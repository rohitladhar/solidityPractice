// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    //bool hasFavoriteNumber = true;
    uint256 public favouriteNumber;
    //string favouriteNumberInText = "Five";
    //address myAddress = 0xE5D5b62D60fA2C5D25Cf2E805995349ebbfb0D88;
    function store(uint _favouriteNumber) public{
        favouriteNumber = _favouriteNumber;
        //view function spend gas when it is calling inside blockchain
        //retrieve();
    }

    // didn't spend gas for execution
    function retrieve() public view returns(uint256){
        return favouriteNumber;
    }
    // didn't spend gas for execution
    function add() public pure returns (uint256){
        return(1+1);
    }
}