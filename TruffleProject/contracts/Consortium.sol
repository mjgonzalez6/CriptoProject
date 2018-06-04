pragma solidity ^0.4.22;

contract Consortium{

  struct Voter{

    uint weight;
    bool voted; //is true, person already voted
    address delegate; //person delegated to
    uint vote; // index of the vote proposal
  }

  struct Proposal{
    bytes32 name; //short name
    uint voteCount; //number of acumulated votes
  }

  mapping (address => Voter) public voters;
  mapping (address => uint) public entities;

  address public voterEntity;
  uint public quota;
  uint public numEntities;

  Proposal[] public proposals;

  function Consortium(){
    quota = 2000;
    numEntities = 0;
  }

   function addEntity() public {

   }


   function removeEntity() public  {

   }

}
