{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.darwinModules.addLoadExtender {
  load = {
    src = ./darwinModules;
    inputs = {inherit inputs cell;};
  };
})
