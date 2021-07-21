
# Enable or disable multigenerational LRU

## Install
```
$ git clone https://github.com/hakavlad/mg-lru-helper.git
$ cd mg-lru-helper
$ sudo make install
```

## Uninstall
```
$ sudo make uninstall
```

## Usage

Get the current status:
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
sudo systemctl enable mglru0.service
```

Enable multigenerational LRU during system boot:
```
sudo systemctl enable mglru1.service
```

Multigenerational LRU Framework at LKML:
- v1: https://lore.kernel.org/lkml/20210313075747.3781593-1-yuzhao@google.com/
- v2: https://lore.kernel.org/lkml/20210413065633.2782273-1-yuzhao@google.com/
- v3: https://lore.kernel.org/lkml/20210520065355.2736558-1-yuzhao@google.com/

