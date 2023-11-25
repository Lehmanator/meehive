{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ./nixosProfiles;
    inputs = {inherit inputs cell;};
  };
})
