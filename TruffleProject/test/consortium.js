var Consortium = artifacts.require("./Consortium.sol");

contract('Consortium', function(accounts) {
    var entity = accounts[0];

    describe("IsMember", function(accounts){
      return Consortium new() then(function(instance){
      return instance IsMember call();
    })then(function(resultado){
      assert equal(result, true, "Entity is member")
    });
  });
});
