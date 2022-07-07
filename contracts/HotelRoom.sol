//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract HotelRoom{
    // ENUMS
    //An enum is a user-defined type consisting of a set of named constants called enumerators.
    //set hotel room statuses
    enum Statuses{Vacant,Occupied}

    //instanciate a cuurent status
    Statuses public currentStatus;
    
    // owner of hotel wallet address
    address payable public owner;
 
    //set the owner address on first instanciation of contract
    constructor(){
        owner = payable(msg.sender);
        //set current status to vacant when the contract ias first called
        currentStatus = Statuses.Vacant;
    }
    //Events Event is an inheritable member of a contract. An event is emitted, it stores the arguments passed in transaction logs.
    event Occupy(address _occupant,uint _value);


    //Function Modifiers are used to modify the behaviour of a function. For example to add a prerequisite to a function

    modifier onlyWhileVacant{
        //check room stats
        require(currentStatus == Statuses.Vacant,"This room is not vacant :(");
        //this tells the function to continue
        _;
    }

    modifier costs(uint _amount){
        //check price
        require(msg.value >= _amount,"Insufficient Ether");
        //this tells the function to continue
        _;
    }

    function bookRoom() payable public onlyWhileVacant costs(2 ether){
        currentStatus = Statuses.Occupied;

        // There are problems with using the transfer() method and its not a safe way 
        //to confirm payments
        // owner.transfer(msg.value);

        //use this instead
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        //make sure the transaction was successful
        require(true);

        //how you use and emit and event
        emit Occupy(msg.sender,msg.value);
    }
}