const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const tokenAddress = "0x755B47353B00253b2Eeeb45495630156f48b0b8b"; 

const StakeERC20Module = buildModule("StakeERC20Module", (m) => {
    const save = m.contract("StakeERC20", [tokenAddress]);
    return { save };
});

module.exports = StakeERC20Module;
