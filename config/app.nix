{ pkgs }:
let
  mkCustomRC = plugins:
  let
    inherit (builtins) map filter concatMap readDir concatStringsSep replaceStrings pathExists;
    inherit (pkgs.lib.trivial) pipe;
    inherit (pkgs.lib.strings) hasSuffix;

    mapIf = predicate: mapper: array:
      map (el: if predicate el then mapper el else el ) array;
  in
    pipe plugins [
        (map ({pname, ...}: pname))
        (map (pluginName: replaceStrings ["."] ["-"] pluginName))
        (filter (plugin: pathExists ./plugin_configs/${plugin}))
        (concatMap (pluginName: 
          map (configFile: ./plugin_configs/${pluginName}/${configFile}) (builtins.attrNames (readDir ./plugin_configs/${pluginName})))
        )
        (mapIf (hasSuffix "runtime.nix") (file: ""))
        (mapIf (hasSuffix ".lua") (file: "luafile ${file}"))
        (mapIf (hasSuffix ".vim") (file: "source ${file}"))
        (concatStringsSep "\n")
    ];


  mkDependencies = plugins:
  let 
    inherit (builtins) map filter concatMap replaceStrings pathExists;
    inherit (pkgs.lib.trivial) pipe;
  in
    pipe plugins [
        (map ({pname, ...}: pname))
        (map (pluginName: replaceStrings ["."] ["-"] pluginName))
        (filter (plugin: pathExists ./plugin_configs/${plugin}/runtime.nix))
        (concatMap (pluginPath: import ./plugin_configs/${pluginPath}/runtime.nix { inherit pkgs; }))
    ];

  # todo: gather runtime dependecies like customRC

  plugins = import ./plugins.nix { inherit pkgs; };
  dependencies = mkDependencies plugins;
in 
pkgs.wrapNeovim pkgs.neovim-unwrapped {
  configure = { 
    customRC = mkCustomRC ([{ pname = "init"; }] ++ plugins);
    packages.all.start = plugins;
  };
  extraMakeWrapperArgs = ''--prefix PATH : "${pkgs.lib.makeBinPath dependencies}"'';
} 
