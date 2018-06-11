pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;
contract Consortium {

address[] public FriendAddresses;
address[] public entryRefundAdresses;
movieProposal[] movieProposals;
address[] public alreadyVoted;
uint entryCost;



struct movieProposal {
  uint id;
  bytes32 name;
  bool isWinProposal;
  address[] voters;
  uint ticketCost;
}


constructor() public payable {
      require(msg.value > 0);
      entryCost = msg.value; 
  FriendAddresses.push(msg.sender);
  entryRefundAdresses.push(msg.sender);
}




function registerAddress() public payable {
    require(msg.value >= entryCost);
    if(msg.value >= entryCost){
    msg.sender.transfer(msg.value-entryCost);
    }
    FriendAddresses.push(msg.sender);
    entryRefundAdresses.push(msg.sender);
}

function VoteNonExistentMovie(bytes32 name, uint cost ) public {
  address[] voters;
  voters.push(msg.sender);
  movieProposal memory newProposal = movieProposal(movieProposals.length, name, false, voters, cost);
  movieProposals.push(newProposal);
  require(msg.value == cost);
}

function viewMovieProposals() public returns (movieProposal[] movieProposals)
{
 return movieProposals;
}
function VoteExistentMovie(uint idMovieProposal)
{
    require(msg.value == movieProposals[idMovieProposal].ticketCost);
    bool isFriend = false;
    for(uint i; i < FriendAddresses.length; i++)
    {
        if(FriendAddresses[i] == msg.sender)
        {
            isFriend = true;
            break;

        }
        require(isFriend);
        bool canVote = false;
        for(uint j; j < alreadyVoted.length; j++)
        {
            if(alreadyVoted[j] == msg.sender)
            {
              canVote= true;
              break;

            }
            require(canVote);
            movieProposals[idMovieProposal].voters.push(msg.sender);
        }
     }
      if(FriendAddresses.length-alreadyVoted.length == 0)
      {
          this.verifyWinner();
          this.finishVotation();
      }
}

function finishProposal(uint idMovieProposal) public
{
    require(msg.sender == movieProposals[idMovieProposal].voters[0]);
    this.verifyWinner();
    if(movieProposals[idMovieProposal].isWinProposal == true)
    {
        this.finishVotation();
    }
    else
    {
      require(this.refund(movieProposals[idMovieProposal].voters, movieProposals[idMovieProposal].ticketCost));
      delete movieProposals[idMovieProposal];
    }
}
//fn de concluir cuando todos votaron
function finishVotation()
{
    for(uint i; i < movieProposals.length; i++)
    {
        if(movieProposals[i].isWinProposal == false)
        {
          require(this.refund(movieProposals[i].voters, movieProposals[i].ticketCost));
        }
        else//propuesta ganadora
        {
        this.refundToFriends(movieProposals[i].voters[0]);
        this.payTickets(movieProposals[i].voters, movieProposals[i].ticketCost);
        }
    }
}


function verifyWinner()
{
    uint fiftyPlusOne = (uint(FriendAddresses.length)/2)+1;
    for(uint i; i< movieProposals.length; i++)
    {
        if(movieProposals[i].voters.length >= fiftyPlusOne)
        {
            movieProposals[i].isWinProposal = true;
        }
      }
}
function refund(address[] losers, uint cost) returns(bool)
{
    for(uint i; i < movieProposals.length; i++)
    {
        return losers[i].send(cost);
    }
}


function payTickets(address[] voters, uint cost) returns(bool)
{
    return voters[0].send(cost*voters.length);
}

function refundToFriends(address organizer) returns(bool success)
{
    success = organizer.send(entryRefundAdresses.length * entryCost);
    for(uint i; i<entryRefundAdresses.length; i++)
    {
        delete entryRefundAdresses[i];
    }
    return success;
}

function getTotalFriends() public view returns( uint ) {
    uint totalFriends = FriendAddresses.length;
		return totalFriends;
}
function getTotalEntryRefundFriends() public view returns( uint ) {
    uint totalEntryRefundFriends = entryRefundAdresses.length;
		return totalEntryRefundFriends;
}
function getTotalAlreadyVoted() public view returns( uint ) {
    uint totalAlreadyVoted = alreadyVoted.length;
    return totalAlreadyVoted;
}
}
