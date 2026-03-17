{
  buildGoModule,
  fetchFromGitHub,
  git,
}:

buildGoModule rec {
  pname = "once";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "basecamp";
    repo = "once";
    rev = "v${version}";
    sha256 = "05dh5phd07k82m7ac14zi98qb397xvv9wijqcla8r06difwji17m";
  };

  vendorHash = "sha256-Cl1/8D4loqmZFipdzZ72gwsCcZu0HGEDGsb2T8OM16U=";

  nativeBuildInputs = [ git ];

  subPackages = [ "cmd/once" ];

  postPatch = ''
    substituteInPlace go.mod --replace-fail 'go 1.26.1' 'go 1.25'
  '';
}
