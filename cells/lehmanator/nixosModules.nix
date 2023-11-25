{ inputs, cell }:
inputs.omnibus.lib.mapPopsExports
(inputs.omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = ./nixosModules;
    inputs = {inherit inputs cell;};
    #transformer = inputs.haumea.lib.transformers.liftDefault;
  };
})
