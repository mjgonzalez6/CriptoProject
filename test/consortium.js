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

it("should not add new Friends with value less costEntry", () => {
  return Consortium.new({value: 100, from:  accounts[3]}).then(instance => {
  instance.registerAddress({ from: accounts[6], value: 50 });
  return instance.getTotalFriends();
  }).then( totalFriends => {
    assert.equal(totalFriends,1, "Was not possible to add new Friend");
  });
});









});
