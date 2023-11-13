// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.10 and less than 0.9.0
pragma solidity >=0.4.0;
contract Bank {
    uint balance = 1000;

    function updatebalance(uint newbalance) private{
        balance = newbalance;
    }
    function withdraw(uint amount) public {
        uint temp = balance - amount;
        updatebalance(temp);
        
    }
    function deposit(uint amount) public {
        uint temp = balance + amount;
        updatebalance(temp);
    }
    function showBalance() public view returns(uint){
        return balance;
    }
}

