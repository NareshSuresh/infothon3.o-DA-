const Identity = artifacts.require("Identity");

contract('Identity', (accounts) => {
    let instance;

    before(async () => {
        instance = await Identity.deployed();
    });

    it('should register a user and retrieve their data', async () => {
        const name = 'Alice';
        const email = 'alice@example.com';
        const did = 'did:ethr:0x123456789abcdef';

        // Register the user
        await instance.register(name, email, did, { from: accounts[0] });

        // Retrieve the user data
        const userData = await instance.getUser(accounts[0]);

        // Assertions
        assert.equal(userData[0], name, 'Name should match');
        assert.equal(userData[1], email, 'Email should match');
        assert.equal(userData[2], did, 'DID should match');
    });
});
