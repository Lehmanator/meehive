{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.devshellModules.addLoadExtender {
  load = {
    src = ./devshellModules;
    inputs = {inherit inputs cell;};
  };
})
