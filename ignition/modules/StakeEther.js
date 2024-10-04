const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const tokenAddress = "0x755B47353B00253b2Eeeb45495630156f48b0b8b"; 

const StakeEtherModule = buildModule("StakeEtherModule", (m) => {
    const save = m.contract("StakeEther");
    return { save };
});

module.exports = StakeEtherModule;


// Deployed SaveERC20: 0x90b9E1C8645bC731be19537A4932B26Fc218e464
