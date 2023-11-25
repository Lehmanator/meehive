{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = ./homeProfiles;
    inputs = {inherit inputs cell;};
  };
})
