{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = ./hardwareProfiles;
    inputs = {inherit inputs cell;};
  };
})
