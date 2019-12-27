module.exports = {
  contracts_build_directory: './build',
  compilers: {
    solc: {
      version: "0.5.15",
      settings: {
       optimizer: {
         enabled: true,
         runs: 1
       }
      }
    }
  }
};
