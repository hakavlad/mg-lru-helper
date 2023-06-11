
# Enable or disable multigenerational LRU

There are simple shell scripts and oneshot systemd services to enable or disable multigenerational LRU at boot time or on the fly, and to get the current state of mg-LRU.

[MGLRU Patches Merged To "mm-stable" Ahead Of Linux 6.1](https://www.phoronix.com/news/MGLRU-Reaches-mm-stable)

## Usage

Run `mglru` (get the current state), `set_mglru N` (enable/disable mg-LRU), and `set_min_ttl_ms M`. You can add the oneshot service to startup.

Get the current state:
```
$ mglru
#!/bin/sh -ev
cat /sys/kernel/mm/lru_gen/enabled
0x0007
cat /sys/kernel/mm/lru_gen/min_ttl_ms
1000
```

Disable multigenerational LRU:
```
$ set_mglru 0
#!/bin/sh -ev
echo $1 | sudo tee /sys/kernel/mm/lru_gen/enabled
0
```

Enable multigenerational LRU:
```
$ set_mglru 1
#!/bin/sh -ev
echo $1 | sudo tee /sys/kernel/mm/lru_gen/enabled
1
```

Apply all the multigenerational LRU features:
```
$ set_mglru y
#!/bin/sh -ev
echo $1 | sudo tee /sys/kernel/mm/lru_gen/enabled
y
```

`set_mglru ` takes values from 0 to 7 and `[yYnN]` (since MGLRU v7). [Most users should enable or disable all the features unless some of them have unforeseen side effects.](https://lore.kernel.org/linux-mm/20220208081902.3550911-13-yuzhao@google.com/#iZ31Documentation:admin-guide:mm:multigen_lru.rst)

Set `min_ttl_ms`:
```
$ set_min_ttl_ms 2000
#!/bin/sh -v
echo $1 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
2000
```

Enable/disable multigenerational LRU during system boot:
```bash
$ sudo systemctl enable mglru.service
```
By default it sets `/sys/kernel/mm/lru_gen/enabled` to Y and `/sys/kernel/mm/lru_gen/min_ttl_ms` to 1000.

Edit the unit file using systemctl (to change `enabled` and `min_ttl_ms` values):
```bash
$ sudo systemctl edit mglru.service --full
```

## Installation

Install
```bash
$ git clone https://github.com/hakavlad/mg-lru-helper.git
$ cd mg-lru-helper
$ sudo make install
```

Uninstall
```bash
$ sudo make uninstall
```

## Kernels with mg-LRU

- https://github.com/xanmod/linux (https://xanmod.org)
- https://github.com/zen-kernel/zen-kernel (https://liquorix.net)
- https://gitlab.com/post-factum/pf-kernel/-/wikis/README

## Resources

Multigenerational LRU Framework at LKML:
- v1: https://lore.kernel.org/lkml/20210313075747.3781593-1-yuzhao@google.com/
- v2: https://lore.kernel.org/lkml/20210413065633.2782273-1-yuzhao@google.com/
- v3: https://lore.kernel.org/lkml/20210520065355.2736558-1-yuzhao@google.com/
- v4: https://lore.kernel.org/lkml/20210818063107.2696454-1-yuzhao@google.com/
- v5: https://lore.kernel.org/lkml/20211111041510.402534-1-yuzhao@google.com/
- v6: https://lore.kernel.org/lkml/20220104202227.2903605-1-yuzhao@google.com/
- v7: https://lore.kernel.org/lkml/20220208081902.3550911-1-yuzhao@google.com/
- v8: https://lore.kernel.org/lkml/20220308234723.3834941-1-yuzhao@google.com/
- v9: https://lore.kernel.org/lkml/20220309021230.721028-1-yuzhao@google.com/
- v10: https://lore.kernel.org/lkml/20220407031525.2368067-1-yuzhao@google.com/
- v11: https://lore.kernel.org/lkml/20220518014632.922072-1-yuzhao@google.com/
- v12: https://lore.kernel.org/lkml/20220614071650.206064-1-yuzhao@google.com/
- v13: https://lore.kernel.org/lkml/20220706220022.968789-1-yuzhao@google.com/

Multigenerational LRU Framework at LWN.net:
- https://lwn.net/Articles/851184/
- https://lwn.net/Articles/856931/
- https://lwn.net/Articles/881675/
- https://lwn.net/Articles/894859/

Multigenerational LRU Framework at phoronix:
- https://www.phoronix.com/scan.php?page=news_item&px=Linux-Multigen-LRU
- https://www.phoronix.com/scan.php?page=news_item&px=Multigenerational-LRU-v2
- https://www.phoronix.com/scan.php?page=news_item&px=Multigen-LRU-Framework-V3
- https://www.phoronix.com/scan.php?page=news_item&px=Multigen-LRU-v5
- https://www.phoronix.com/scan.php?page=news_item&px=Linux-MGLRU-v6-Linux
- https://www.phoronix.com/scan.php?page=news_item&px=MGLRU-Not-For-5.18
- https://www.phoronix.com/scan.php?page=news_item&px=Linux-MGLRU-v9-Promising
- https://www.phoronix.com/scan.php?page=news_item&px=MGLRU-v10
- https://www.phoronix.com/scan.php?page=news_item&px=MGLRU-v11-Linux-Perf
- https://www.phoronix.com/scan.php?page=news_item&px=MGLRU-v12-For-Linux-5.19-rc
- https://www.phoronix.com/scan.php?page=news_item&px=MGLRU-July-2022-Performance
- https://www.phoronix.com/scan.php?page=news_item&px=MGLRU-v13-More-Benchmarks

Multigenerational LRU Framework at linux.org.ru:
- https://www.linux.org.ru/forum/general/16321096


