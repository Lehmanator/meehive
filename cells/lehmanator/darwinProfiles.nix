{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.darwinProfiles.addLoadExtender {
  load = {
    src = ./darwinProfiles;
    inputs = {inherit inputs cell;};
  };
})
