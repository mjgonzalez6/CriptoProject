pragma solidity ^0.4.22;

contract Consortium{

  struct Voter{

    uint weight;
    bool voted; //is true, person already voted
    address delegate; //person delegated to
    uint vote; // index of the vote proposal
  }

  struct Proposal{
    string title; //short name
    uint voteCount; //number of acumulated votes
    address creator;
    uint votes;
  }

  mapping (address => Voter) public voters;
  mapping (address => bool) public entities;

  address public voterEntity;
  uint public quota;
  uint public numEntities;

  Proposal[] public proposals;
  Proposal actualProposal;

  function Consortium(){
    quota = 2000;
    numEntities = 0;
  }

   modifier onlyEntity(){
     require(entities[msg.sender]);
     _;
   }

   function AddEntity() public {
   }


   function RemoveEntity() public  {
   }

   function Propose(string title) public onlyEntity  {
      require(actualProposal.creator != 0x0);
      actualProposal.creator = msg.sender;
      actualProposal.title = title;

   }

   function Vote(bool positive) public onlyEntity {
     require (actualProposal.votes[msg.sender]);

     actualProposal.votes[msg.sender] = true;



   }

}
