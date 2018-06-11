pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;
contract Consortium {

address[] public FriendAddresses;
address[] public entryRefundAdresses;
movieProposal[] public movieProposals;
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

function VoteNonExistentMovie(bytes32 name) public payable {
  address[] voters;
  voters.push(msg.sender);
  alreadyVoted.push(msg.sender);
  movieProposal memory newProposal = movieProposal(movieProposals.length, name, false, voters, msg.value);
  movieProposals.push(newProposal);
  require(msg.value > 0);
}

function viewMovieProposals() public returns (movieProposal[] movieProposals)
{
 return movieProposals;
}
function VoteExistentMovie(uint idMovieProposal) public payable
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
    }
    require(isFriend);
    bool canVote = true;
    for(uint j; j < alreadyVoted.length; j++)
    {
        if(alreadyVoted[j] == msg.sender)
        {
          canVote = false;
          break;
        }
    }
    require(canVote);
    movieProposals[idMovieProposal].voters.push(msg.sender);
    alreadyVoted.push(msg.sender);
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

          require(this.refundToFriends(movieProposals[i].voters[0]));
          require(this.payTickets(movieProposals[i].voters, movieProposals[i].ticketCost));
          for(uint j; j < movieProposals.length; j++)
          {
              delete movieProposals[j];
          }

        }
    }
}


function verifyWinner()
{
    uint fiftyPlusOne = getFiftyPlusOne();
    for(uint i; i< movieProposals.length; i++)
    {
        if(movieProposals[i].voters.length >= fiftyPlusOne)
        {
            movieProposals[i].isWinProposal = true;
            break;
        }
    }
}

function  getFiftyPlusOne() public view returns ( uint ){
  uint number = ((FriendAddresses.length)/2);
  if (2*(FriendAddresses.length/2) == FriendAddresses.length){
    return number;
  }
  else
  {
    number++;
    return number;
  }
}

function refund(address[] losers, uint cost) returns(bool success)
{
    success = false;
    for(uint i; i < losers.length; i++)
    {
        success = losers[i].send(cost);
    }
    return success;
}


function payTickets(address[] voters, uint cost) returns(bool)
{
    return voters[0].send(cost*voters.length);
}

function refundToFriends(address organizer) returns(bool success)
{
    success = organizer.send(entryRefundAdresses.length * entryCost);
    require(success);
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
function getTotalMoviesProposals() public view returns ( uint ){
    uint totalMoviesProposals = movieProposals.length;
    return totalMoviesProposals;
}
function getTotalVoters(uint idMovieProposal) public view returns ( uint ){
    uint totalVoters = movieProposals[idMovieProposal].voters.length;
    return totalVoters;
}
function getIsWinProposal(uint idMovieProposal) public view returns ( bool ){
    bool isWinProposal = movieProposals[idMovieProposal].isWinProposal;
    return isWinProposal;
}

}
