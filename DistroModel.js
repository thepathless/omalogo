.pragma library

var DISTROS = [
  { key: "omarchy", name: "Omarchy", icon: "\ue900", font: "omarchy" },
  { key: "arch", name: "Arch Linux", icon: "\uf303", font: "nerd" },
  { key: "debian", name: "Debian", icon: "\uf306", font: "nerd" },
  { key: "ubuntu", name: "Ubuntu", icon: "\uf31b", font: "nerd" },
  { key: "fedora", name: "Fedora", icon: "\uf30a", font: "nerd" },
  { key: "nixos", name: "NixOS", icon: "\uf313", font: "nerd" },
  { key: "gentoo", name: "Gentoo", icon: "\uf30d", font: "nerd" },
  { key: "void", name: "Void Linux", icon: "\uf32e", font: "nerd" },
  { key: "alpine", name: "Alpine Linux", icon: "\uf300", font: "nerd" },
  { key: "opensuse", name: "openSUSE", icon: "\uf314", font: "nerd" },
  { key: "manjaro", name: "Manjaro", icon: "\uf312", font: "nerd" },
  { key: "mint", name: "Linux Mint", icon: "\uf30e", font: "nerd" },
  { key: "endeavour", name: "EndeavourOS", icon: "\uf322", font: "nerd" },
  { key: "popos", name: "Pop!_OS", icon: "\uf32a", font: "nerd" },
  { key: "kali", name: "Kali Linux", icon: "\uf327", font: "nerd" },
  { key: "artix", name: "Artix Linux", icon: "\uf31f", font: "nerd" },
  { key: "freebsd", name: "FreeBSD", icon: "\uf30c", font: "nerd" },
  { key: "redhat", name: "Red Hat", icon: "\uf316", font: "nerd" },
  { key: "rocky", name: "Rocky Linux", icon: "\uf32b", font: "nerd" },
  { key: "almalinux", name: "AlmaLinux", icon: "\uf31d", font: "nerd" },
  { key: "centos", name: "CentOS", icon: "\uf304", font: "nerd" },
  { key: "linux", name: "Linux (Tux)", icon: "\uf17c", font: "nerd" }
];

function findDistro(key) {
  if (!key) return DISTROS[0];
  var normalized = String(key).toLowerCase().trim();
  for (var i = 0; i < DISTROS.length; i++) {
    if (DISTROS[i].key === normalized) return DISTROS[i];
  }
  return DISTROS[0];
}

function filterDistros(query) {
  if (!query || !query.trim()) return DISTROS;
  var q = String(query).toLowerCase().trim();
  return DISTROS.filter(function(d) {
    return d.name.toLowerCase().indexOf(q) !== -1 || d.key.toLowerCase().indexOf(q) !== -1;
  });
}

function allDistros() {
  return DISTROS;
}
