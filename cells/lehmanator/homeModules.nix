{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.homeModules.addLoadExtender {
  load = {
    src = ./homeModules;
    inputs = {inherit inputs cell;};
  };
})
