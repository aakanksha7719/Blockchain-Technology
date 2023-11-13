// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EVotingSystem {
    struct Voter {
        string name;
        bool isRegistered;
        bool hasVoted;
        string votedFor;
    }

    Voter[] public voters;
    uint public BJPVotes;
    uint public CongressVotes;

    modifier onlyRegisteredVoter(string memory _name) {
        bool isRegistered = false;
        for (uint i = 0; i < voters.length; i++) {
            if (keccak256(abi.encodePacked(voters[i].name)) == keccak256(abi.encodePacked(_name))) {
                isRegistered = true;
                break;
            }
        }
        require(isRegistered, "You are not a registered voter.");
        _;
    }

    modifier hasNotVoted(string memory _name) {
        bool hasVoted = false;
        for (uint i = 0; i < voters.length; i++) {
            if (keccak256(abi.encodePacked(voters[i].name)) == keccak256(abi.encodePacked(_name)) && voters[i].hasVoted) {
                hasVoted = true;
                break;
            }
        }
        require(!hasVoted, "You have already voted.");
        _;
    }

    function registerVoter(string memory _name) public {
        voters.push(Voter(_name, true, false, ""));
    }

    function vote(string memory _name, string memory partyName) public onlyRegisteredVoter(_name) hasNotVoted(_name) {
        for (uint i = 0; i < voters.length; i++) {
            if (keccak256(abi.encodePacked(voters[i].name)) == keccak256(abi.encodePacked(_name))) {
                voters[i].hasVoted = true;
                voters[i].votedFor = partyName;

                if (keccak256(abi.encodePacked(partyName)) == keccak256(abi.encodePacked("BJP"))) {
                    BJPVotes++;
                } else if (keccak256(abi.encodePacked(partyName)) == keccak256(abi.encodePacked("CONGRESS"))) {
                    CongressVotes++;
                }

                break;
            }
        }
    }
}