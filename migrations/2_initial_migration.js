const MultiSignatureWallet = artifacts.require("MultiSignatureWallet");

module.exports = function (deployer) {
  deployer.deploy(MultiSignatureWallet);
};
