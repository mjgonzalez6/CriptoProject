var Consortium = artifacts.require("./Consortium.sol");

contract('Consortium', accounts => {

it("should create new Contract", () => {
      return Consortium.new({value: 100, from:  accounts[3]}).then(instance => {
      return instance.getTotalFriends();
      }).then( totalFriends => {
        assert.equal(totalFriends, 1, "Was not possible create new Contract");
      });
  });


it("should add new Friends with value more costEntry", () => {
   return Consortium.new({value: 100, from:  accounts[3]}).then(instance => {
   instance.registerAddress({ from: accounts[5], value: 300 });
   return instance.getTotalFriends();
   }).then( totalFriends => {
     assert.equal(totalFriends,2, "Was not possible to add new Friend");
   });
});

it("should add new Friends with value equal costEntry", () => {
  return Consortium.new({value: 100, from:  accounts[3]}).then(instance => {
  instance.registerAddress({ from: accounts[4], value: 100 });
  return instance.getTotalFriends();
  }).then( totalFriends => {
    assert.equal(totalFriends,2, "Was not possible to add new Friend");
  });
});

/*it("should not add new Friends with value less costEntry", () => {
  return Consortium.new({value: 100, from:  accounts[3]}).then(instance => {
  instance.registerAddress({ from: accounts[6], value: 50 });
  return instance.getTotalFriends();
  }).then( totalFriends => {
    assert.equal(totalFriends,1, "Was not possible to add new Friend");
  });
});*/


it("should create a new movieProposal", () => {
   return Consortium.new({value: 100, from:  accounts[4]}).then(instance => {
   instance.VoteNonExistentMovie("avengers",{ from: accounts[4], value: 500 });
   return instance.getTotalMoviesProposals();
 }).then( totalMoviesProposals => {
     assert.equal(totalMoviesProposals, 1, "Was not possible to add new movie proposal");
   });
});

it("should can vote for existing movie", () => {
  return Consortium.new({value: 100, from:  accounts[4]}).then(instance => {
  instance.VoteNonExistentMovie("avengers",{ from: accounts[4], value: 500 });
  instance.registerAddress({ from: accounts[5], value: 100});
  instance.VoteExistentMovie(0,{ from: accounts[5], value: 500});
  return instance.getTotalVoters(0);
  }).then( totalVoters => {
    assert.equal(totalVoters, 3, "Was not possible to vote for existing movie");
  });
});











});
