{ inputs, cell }: {
  wyse = {
    networking.hostName = "wyse";
    deployment = {
      allowLocalDeployment = true;
      targetHost = "wyse";
    };
    imports = [ cell.nixosConfigurations.wyse ];
  };
}
