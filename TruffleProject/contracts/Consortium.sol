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

  constructor(bytes32[] proposalNames) public {
        voterEntity = msg.sender;
        voters[voterEntity].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function giveRightToVote(address voter) public {
        require(
            msg.sender == voterEntity,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    function delegate(address to) public {
       
       Voter storage sender = voters[msg.sender];
       require(!sender.voted, "You already voted.");

       require(to != msg.sender, "Self-delegation is disallowed.");


       while (voters[to].delegate != address(0)) {
           to = voters[to].delegate;


           require(to != msg.sender, "Found loop in delegation.");
       }

       sender.voted = true;
       sender.delegate = to;
       Voter storage delegate_ = voters[to];
       if (delegate_.voted) {

           proposals[delegate_.vote].voteCount += sender.weight;
       } else {

           delegate_.weight += sender.weight;
       }
   }


   function vote(uint proposal) public {
       Voter storage sender = voters[msg.sender];
       require(!sender.voted, "Already voted.");
       sender.voted = true;
       sender.vote = proposal;

       proposals[proposal].voteCount += sender.weight;
   }


   function winningProposal() public view
           returns (uint winningProposal_)
   {
       uint winningVoteCount = 0;
       for (uint p = 0; p < proposals.length; p++) {
           if (proposals[p].voteCount > winningVoteCount) {
               winningVoteCount = proposals[p].voteCount;
               winningProposal_ = p;
           }
       }
   }

   function winnerName() public view
           returns (bytes32 winnerName_)
   {
       winnerName_ = proposals[winningProposal()].name;
   }




}
