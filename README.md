
# Enable or disable multigenerational LRU

There are simple shell scripts and oneshot systemd services to enable or disable multigenerational LRU at boot time or on the fly, and to get the current state of mg-LRU. 

## Usage

Run `mglru` (get the state), `mglru0` (disable mg-LRU) or `mglru1` (enable mg-LRU). You can add the oneshot service to startup. 

Get the current state:
```
$ mglru
#!/bin/sh -v
cat /sys/kernel/mm/lru_gen/enabled
1
```

Enable multigenerational LRU:
```
$ mglru1
#!/bin/sh -v
echo 1 | sudo tee /sys/kernel/mm/lru_gen/enabled
1
```

Disable multigenerational LRU:
```
$ mglru0
#!/bin/sh -v
echo 0 | sudo tee /sys/kernel/mm/lru_gen/enabled
0
```

Disable multigenerational LRU during system boot:
```
$ sudo systemctl enable mglru0.service
```

Enable multigenerational LRU during system boot:
```
$ sudo systemctl enable mglru1.service
```

## Installation

Install
```
$ git clone https://github.com/hakavlad/mg-lru-helper.git
$ cd mg-lru-helper
$ sudo make install
```

Uninstall
```
$ sudo make uninstall
```

## Kernels with mg-LRU

- https://github.com/xanmod/linux (https://xanmod.org)
- https://github.com/zen-kernel/zen-kernel (https://liquorix.net)

## Resources

Multigenerational LRU Framework at LKML:
- v1: https://lore.kernel.org/lkml/20210313075747.3781593-1-yuzhao@google.com/
- v2: https://lore.kernel.org/lkml/20210413065633.2782273-1-yuzhao@google.com/
- v3: https://lore.kernel.org/lkml/20210520065355.2736558-1-yuzhao@google.com/
- v4: https://lore.kernel.org/lkml/20210818063107.2696454-1-yuzhao@google.com/

Multigenerational LRU Framework at LWN.net:
- https://lwn.net/Articles/851184/
- https://lwn.net/Articles/856931/
