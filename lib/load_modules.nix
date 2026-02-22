{inputs, ...}: {
  flake.lib = {
    loadHostModules = modules: username:
      assert builtins.isList modules;
      assert builtins.isString username; {
        imports =
          (map (module: inputs.self.modules.nixos.${module} or {}) modules)
          ++ [
            {
              imports = [
                inputs.home-manager.nixosModules.home-manager
              ];

              home-manager.users.${username}.imports =
                [
                  (
                    {osConfig, ...}: {
                      home.stateVersion = osConfig.system.stateVersion;
                    }
                  )
                ]
                ++ map (module: inputs.self.modules.homeManager.${module} or {}) modules;
            }
          ];
      };
  };
}
