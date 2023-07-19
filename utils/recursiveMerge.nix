let
  pkgs = import <nixpkgs> { };

  recursiveMerge = baseValue: overwriteValue:
    with builtins; with pkgs.lib;
    if isAttrs baseValue && isAttrs overwriteValue then
      let
        baseKeys = attrNames baseValue;
        overwriteKeys = attrNames overwriteValue;
        baseOnlyAttrs = filterAttrs (k: v: !(elem k overwriteKeys)) baseValue;
        overwriteOnlyAttrs = filterAttrs (k: v: !(elem k baseKeys)) overwriteValue;
        baseBothAttrs = filterAttrs (k: v: elem k overwriteKeys) baseValue;
        overwriteBothAttrs = filterAttrs (k: v: elem k baseKeys) overwriteValue;
        combinedAttrs = mapAttrs
          (k: v: {
            baseValue = baseBothAttrs.${k};
            overwriteValue = overwriteBothAttrs.${k};
          })
          baseBothAttrs;
        mergedAttrs = mapAttrs
          (k: { baseValue
              , overwriteValue
              }: recursiveMerge baseValue overwriteValue)
          combinedAttrs;
      in
      baseOnlyAttrs // overwriteOnlyAttrs // mergedAttrs
    else if isList baseValue && isList overwriteValue then
      baseValue ++ overwriteValue
    else
      overwriteValue
  ;
in
recursiveMerge
