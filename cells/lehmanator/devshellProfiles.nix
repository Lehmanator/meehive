{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.devshellProfiles.addLoadExtender {
  load = {
    src = ./devshellProfiles;
    inputs = {inherit inputs cell;};
  };
})
