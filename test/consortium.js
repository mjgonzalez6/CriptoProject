var consortium = artifacts.require("./Consortium.sol");

contract('Consortium', accounts => {

  it("should add a new member", () => {
    return Consorcio.new().then(instance => {
      return instance.addNewMember.call({ from: accounts[4], value: 500 });
    }).then( was_added => {
      assert.equal(was_added, true, "Was not possible to add new member");
    });
});




}
