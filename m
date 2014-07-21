From: Andrey Tsyvarev <tsyvarev@ispras.ru>
Subject: Fwd: f2fs: Possible use-after-free when umount filesystem
Date: Mon, 21 Jul 2014 15:09:36 +0400
Message-ID: <53CCF4F0.3010206@ispras.ru>
References: <53CCF1EC.30008@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0657635395810566901=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tsyvarev@ispras.ru>) id 1X9BSp-0004wq-TP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Jul 2014 11:09:03 +0000
Received: from smtp.ispras.ru ([83.149.199.79])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X9BSn-0004ZL-A4 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Jul 2014 11:09:03 +0000
In-Reply-To: <53CCF1EC.30008@ispras.ru>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-f2fs-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0657635395810566901==
Content-Type: multipart/alternative;
	boundary="------------060807080702010108060201"

This is a multi-part message in MIME format.
--------------060807080702010108060201
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Sorry, used old maintainers list.


-------- =D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D0=
=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 --------
=D0=A2=D0=B5=D0=BC=D0=B0: 	f2fs: Possible use-after-free when umount file=
system
=D0=94=D0=B0=D1=82=D0=B0: 	Mon, 21 Jul 2014 14:56:44 +0400
=D0=9E=D1=82: 	Andrey Tsyvarev <tsyvarev@ispras.ru>
=D0=9A=D0=BE=D0=BC=D1=83: 	Jaegeuk Kim <jaegeuk.kim@samsung.com>
=D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: 	linux-f2fs-devel@lists.sourceforge.net, =
linux-kernel=20
<linux-kernel@vger.kernel.org>, Alexey Khoroshilov <khoroshilov@ispras.ru=
>



Hello,

Using memory error detector reveals the following use-after-free error
in 3.15.0:

AddressSanitizer: heap-use-after-free in f2fs_evict_inode
Read of size 8 by thread T22279:
  [<ffffffffa02d8702>] f2fs_evict_inode+0x102/0x2e0 [f2fs]
/home/tester/linux-sources/linux-kasan/fs/f2fs/f2fs.h:584
  [<ffffffff812359af>] evict+0x15f/0x290
/home/tester/linux-sources/linux-kasan/fs/inode.c:550
  [<     inlined    >] iput+0x196/0x280 iput_final
/home/tester/linux-sources/linux-kasan/fs/inode.c:1418
  [<ffffffff812369a6>] iput+0x196/0x280
/home/tester/linux-sources/linux-kasan/fs/inode.c:1436
  [<ffffffffa02dc416>] f2fs_put_super+0xd6/0x170 [f2fs]
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:434
  [<ffffffff81210095>] generic_shutdown_super+0xc5/0x1b0
/home/tester/linux-sources/linux-kasan/fs/super.c:406
  [<ffffffff812105fd>] kill_block_super+0x4d/0xb0
/home/tester/linux-sources/linux-kasan/fs/super.c:1019
  [<ffffffff81210a86>] deactivate_locked_super+0x66/0x80
/home/tester/linux-sources/linux-kasan/fs/super.c:284
  [<ffffffff81211c98>] deactivate_super+0x68/0x80
/home/tester/linux-sources/linux-kasan/fs/super.c:307
  [<ffffffff8123cc88>] mntput_no_expire+0x198/0x250
/home/tester/linux-sources/linux-kasan/fs/namespace.c:986 (discriminator =
3)
  [<     inlined    >] SyS_umount+0xe9/0x1a0 SYSC_umount
/home/tester/linux-sources/linux-kasan/fs/namespace.c:1424
  [<ffffffff8123f1c9>] SyS_umount+0xe9/0x1a0
/home/tester/linux-sources/linux-kasan/fs/namespace.c:1392
  [<ffffffff81cc8df9>] system_call_fastpath+0x16/0x1b
/home/tester/linux-sources/linux-kasan/arch/x86/kernel/entry_64.S:426

Freed by thread T3:
  [<ffffffffa02dc337>] f2fs_i_callback+0x27/0x30 [f2fs]
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:408
  [<     inlined    >] rcu_process_callbacks+0x2d6/0x930 __rcu_reclaim
/home/tester/linux-sources/linux-kasan/kernel/rcu/rcu.h:114
  [<     inlined    >] rcu_process_callbacks+0x2d6/0x930 rcu_do_batch
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2242
  [<     inlined    >] rcu_process_callbacks+0x2d6/0x930
invoke_rcu_callbacks
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2499
  [<     inlined    >] rcu_process_callbacks+0x2d6/0x930
__rcu_process_callbacks
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2466
  [<ffffffff810fd266>] rcu_process_callbacks+0x2d6/0x930
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2483
  [<ffffffff8107cce2>] __do_softirq+0x142/0x380
/home/tester/linux-sources/linux-kasan/kernel/softirq.c:269
  [<ffffffff8107cf50>] run_ksoftirqd+0x30/0x50
/home/tester/linux-sources/linux-kasan/kernel/softirq.c:658
  [<ffffffff810b2a87>] smpboot_thread_fn+0x197/0x280
/home/tester/linux-sources/linux-kasan/kernel/smpboot.c:160
  [<ffffffff810a8238>] kthread+0x148/0x160
/home/tester/linux-sources/linux-kasan/kernel/kthread.c:207
  [<ffffffff81cc8d4c>] ret_from_fork+0x7c/0xb0
/home/tester/linux-sources/linux-kasan/arch/x86/kernel/entry_64.S:351

Allocated by thread T22276:
  [<ffffffffa02dc7dd>] f2fs_alloc_inode+0x2d/0x170 [f2fs]
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:356
  [<ffffffff8123471d>] alloc_inode+0x2d/0xe0
/home/tester/linux-sources/linux-kasan/fs/inode.c:208
  [<ffffffff81235e2a>] iget_locked+0x10a/0x230
/home/tester/linux-sources/linux-kasan/fs/inode.c:1085
  [<ffffffffa02d7495>] f2fs_iget+0x35/0xa80 [f2fs]
/home/tester/linux-sources/linux-kasan/fs/f2fs/inode.c:129
  [<ffffffffa02e2393>] f2fs_fill_super+0xb53/0xff0 [f2fs]
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:1021
  [<ffffffff81211bce>] mount_bdev+0x1de/0x240
/home/tester/linux-sources/linux-kasan/fs/super.c:992
  [<ffffffffa02dbce0>] f2fs_mount+0x10/0x20 [f2fs]
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:1127
  [<ffffffff81212a85>] mount_fs+0x55/0x220
/home/tester/linux-sources/linux-kasan/fs/super.c:1095
  [<ffffffff8123c026>] vfs_kern_mount+0x66/0x200
/home/tester/linux-sources/linux-kasan/fs/namespace.c:851
  [<     inlined    >] do_mount+0x2b4/0x1120 do_new_mount
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2129
  [<ffffffff812400d4>] do_mount+0x2b4/0x1120
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2453
  [<     inlined    >] SyS_mount+0xb2/0x110 SYSC_mount
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2647
  [<ffffffff812414a2>] SyS_mount+0xb2/0x110
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2620
  [<ffffffff81cc8df9>] system_call_fastpath+0x16/0x1b
/home/tester/linux-sources/linux-kasan/arch/x86/kernel/entry_64.S:426

The buggy address ffff8800587866c8 is located 48 bytes inside
  of 680-byte region [ffff880058786698, ffff880058786940)

Memory state around the buggy address:
  ffff880058786100: ffffffff ffffffff ffffffff ffffffff
  ffff880058786200: ffffffff ffffffff ffffffrr rrrrrrrr
  ffff880058786300: rrrrrrrr rrffffff ffffffff ffffffff
  ffff880058786400: ffffffff ffffffff ffffffff ffffffff
  ffff880058786500: ffffffff ffffffff ffffffff fffffffr
>ffff880058786600: rrrrrrrr rrrrrrrr rrrfffff ffffffff
                                                ^
  ffff880058786700: ffffffff ffffffff ffffffff ffffffff
  ffff880058786800: ffffffff ffffffff ffffffff ffffffff
  ffff880058786900: ffffffff rrrrrrrr rrrrrrrr rrrr....
  ffff880058786a00: ........ ........ ........ ........
  ffff880058786b00: ........ ........ ........ ........
Legend:
  f - 8 freed bytes
  r - 8 redzone bytes
  . - 8 allocated bytes
  x=3D1..7 - x allocated bytes + (8-x) redzone bytes


Investigation shows, that f2fs_evict_inode, when called for
'meta_inode', uses invalidate_mapping_pages() for 'node_inode'.
But 'node_inode' is deleted before 'meta_inode' in f2fs_put_super via
iput().

It seems that in common usage scenario this use-after-free is benign,
because 'node_inode' remains partially valid data even after
kmem_cache_free().
But things may change if, while 'meta_inode' is evicted in one f2fs
filesystem, another (mounted) f2fs filesystem requests inode from cache,
and formely
'node_inode' of the first filesystem is returned.


Found by Linux File System Verification project (linuxtesting.org).


--=20
Best regards,



Andrey Tsyvarev



Linux Verification Center, ISPRAS



web:http://linuxtesting.org




--------------060807080702010108060201
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    Sorry, used old maintainers list.<br>
    <div class=3D"moz-forward-container"><br>
      <br>
      -------- =D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D0=BE=D0=B5 =D1=81=D0=
=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 --------
      <table class=3D"moz-email-headers-table" cellpadding=3D"0"
        cellspacing=3D"0" border=3D"0">
        <tbody>
          <tr>
            <th valign=3D"BASELINE" align=3D"RIGHT" nowrap=3D"nowrap">=D0=
=A2=D0=B5=D0=BC=D0=B0: </th>
            <td>f2fs: Possible use-after-free when umount filesystem</td>
          </tr>
          <tr>
            <th valign=3D"BASELINE" align=3D"RIGHT" nowrap=3D"nowrap">=D0=
=94=D0=B0=D1=82=D0=B0: </th>
            <td>Mon, 21 Jul 2014 14:56:44 +0400</td>
          </tr>
          <tr>
            <th valign=3D"BASELINE" align=3D"RIGHT" nowrap=3D"nowrap">=D0=
=9E=D1=82: </th>
            <td>Andrey Tsyvarev <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:tsyvarev@ispras.ru">&lt;tsyvarev@ispras.ru&gt;</a></td>
          </tr>
          <tr>
            <th valign=3D"BASELINE" align=3D"RIGHT" nowrap=3D"nowrap">=D0=
=9A=D0=BE=D0=BC=D1=83: </th>
            <td>Jaegeuk Kim <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:jaegeuk.kim@samsung.com">&lt;jaegeuk.kim@samsung.com&gt;</a></td>
          </tr>
          <tr>
            <th valign=3D"BASELINE" align=3D"RIGHT" nowrap=3D"nowrap">=D0=
=9A=D0=BE=D0=BF=D0=B8=D1=8F: </th>
            <td><a class=3D"moz-txt-link-abbreviated" href=3D"mailto:linu=
x-f2fs-devel@lists.sourceforge.net">linux-f2fs-devel@lists.sourceforge.ne=
t</a>, linux-kernel
              <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:linux-ker=
nel@vger.kernel.org">&lt;linux-kernel@vger.kernel.org&gt;</a>, Alexey Kho=
roshilov
              <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:khoroshil=
ov@ispras.ru">&lt;khoroshilov@ispras.ru&gt;</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>Hello,

Using memory error detector reveals the following use-after-free error=20
in 3.15.0:

AddressSanitizer: heap-use-after-free in f2fs_evict_inode
Read of size 8 by thread T22279:
 [&lt;ffffffffa02d8702&gt;] f2fs_evict_inode+0x102/0x2e0 [f2fs]=20
/home/tester/linux-sources/linux-kasan/fs/f2fs/f2fs.h:584
 [&lt;ffffffff812359af&gt;] evict+0x15f/0x290=20
/home/tester/linux-sources/linux-kasan/fs/inode.c:550
 [&lt;     inlined    &gt;] iput+0x196/0x280 iput_final=20
/home/tester/linux-sources/linux-kasan/fs/inode.c:1418
 [&lt;ffffffff812369a6&gt;] iput+0x196/0x280=20
/home/tester/linux-sources/linux-kasan/fs/inode.c:1436
 [&lt;ffffffffa02dc416&gt;] f2fs_put_super+0xd6/0x170 [f2fs]=20
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:434
 [&lt;ffffffff81210095&gt;] generic_shutdown_super+0xc5/0x1b0=20
/home/tester/linux-sources/linux-kasan/fs/super.c:406
 [&lt;ffffffff812105fd&gt;] kill_block_super+0x4d/0xb0=20
/home/tester/linux-sources/linux-kasan/fs/super.c:1019
 [&lt;ffffffff81210a86&gt;] deactivate_locked_super+0x66/0x80=20
/home/tester/linux-sources/linux-kasan/fs/super.c:284
 [&lt;ffffffff81211c98&gt;] deactivate_super+0x68/0x80=20
/home/tester/linux-sources/linux-kasan/fs/super.c:307
 [&lt;ffffffff8123cc88&gt;] mntput_no_expire+0x198/0x250=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:986 (discriminator =
3)
 [&lt;     inlined    &gt;] SyS_umount+0xe9/0x1a0 SYSC_umount=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:1424
 [&lt;ffffffff8123f1c9&gt;] SyS_umount+0xe9/0x1a0=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:1392
 [&lt;ffffffff81cc8df9&gt;] system_call_fastpath+0x16/0x1b=20
/home/tester/linux-sources/linux-kasan/arch/x86/kernel/entry_64.S:426

Freed by thread T3:
 [&lt;ffffffffa02dc337&gt;] f2fs_i_callback+0x27/0x30 [f2fs]=20
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:408
 [&lt;     inlined    &gt;] rcu_process_callbacks+0x2d6/0x930 __rcu_recla=
im=20
/home/tester/linux-sources/linux-kasan/kernel/rcu/rcu.h:114
 [&lt;     inlined    &gt;] rcu_process_callbacks+0x2d6/0x930 rcu_do_batc=
h=20
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2242
 [&lt;     inlined    &gt;] rcu_process_callbacks+0x2d6/0x930=20
invoke_rcu_callbacks=20
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2499
 [&lt;     inlined    &gt;] rcu_process_callbacks+0x2d6/0x930=20
__rcu_process_callbacks=20
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2466
 [&lt;ffffffff810fd266&gt;] rcu_process_callbacks+0x2d6/0x930=20
/home/tester/linux-sources/linux-kasan/kernel/rcu/tree.c:2483
 [&lt;ffffffff8107cce2&gt;] __do_softirq+0x142/0x380=20
/home/tester/linux-sources/linux-kasan/kernel/softirq.c:269
 [&lt;ffffffff8107cf50&gt;] run_ksoftirqd+0x30/0x50=20
/home/tester/linux-sources/linux-kasan/kernel/softirq.c:658
 [&lt;ffffffff810b2a87&gt;] smpboot_thread_fn+0x197/0x280=20
/home/tester/linux-sources/linux-kasan/kernel/smpboot.c:160
 [&lt;ffffffff810a8238&gt;] kthread+0x148/0x160=20
/home/tester/linux-sources/linux-kasan/kernel/kthread.c:207
 [&lt;ffffffff81cc8d4c&gt;] ret_from_fork+0x7c/0xb0=20
/home/tester/linux-sources/linux-kasan/arch/x86/kernel/entry_64.S:351

Allocated by thread T22276:
 [&lt;ffffffffa02dc7dd&gt;] f2fs_alloc_inode+0x2d/0x170 [f2fs]=20
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:356
 [&lt;ffffffff8123471d&gt;] alloc_inode+0x2d/0xe0=20
/home/tester/linux-sources/linux-kasan/fs/inode.c:208
 [&lt;ffffffff81235e2a&gt;] iget_locked+0x10a/0x230=20
/home/tester/linux-sources/linux-kasan/fs/inode.c:1085
 [&lt;ffffffffa02d7495&gt;] f2fs_iget+0x35/0xa80 [f2fs]=20
/home/tester/linux-sources/linux-kasan/fs/f2fs/inode.c:129
 [&lt;ffffffffa02e2393&gt;] f2fs_fill_super+0xb53/0xff0 [f2fs]=20
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:1021
 [&lt;ffffffff81211bce&gt;] mount_bdev+0x1de/0x240=20
/home/tester/linux-sources/linux-kasan/fs/super.c:992
 [&lt;ffffffffa02dbce0&gt;] f2fs_mount+0x10/0x20 [f2fs]=20
/home/tester/linux-sources/linux-kasan/fs/f2fs/super.c:1127
 [&lt;ffffffff81212a85&gt;] mount_fs+0x55/0x220=20
/home/tester/linux-sources/linux-kasan/fs/super.c:1095
 [&lt;ffffffff8123c026&gt;] vfs_kern_mount+0x66/0x200=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:851
 [&lt;     inlined    &gt;] do_mount+0x2b4/0x1120 do_new_mount=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2129
 [&lt;ffffffff812400d4&gt;] do_mount+0x2b4/0x1120=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2453
 [&lt;     inlined    &gt;] SyS_mount+0xb2/0x110 SYSC_mount=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2647
 [&lt;ffffffff812414a2&gt;] SyS_mount+0xb2/0x110=20
/home/tester/linux-sources/linux-kasan/fs/namespace.c:2620
 [&lt;ffffffff81cc8df9&gt;] system_call_fastpath+0x16/0x1b=20
/home/tester/linux-sources/linux-kasan/arch/x86/kernel/entry_64.S:426

The buggy address ffff8800587866c8 is located 48 bytes inside
 of 680-byte region [ffff880058786698, ffff880058786940)

Memory state around the buggy address:
 ffff880058786100: ffffffff ffffffff ffffffff ffffffff
 ffff880058786200: ffffffff ffffffff ffffffrr rrrrrrrr
 ffff880058786300: rrrrrrrr rrffffff ffffffff ffffffff
 ffff880058786400: ffffffff ffffffff ffffffff ffffffff
 ffff880058786500: ffffffff ffffffff ffffffff fffffffr
&gt;ffff880058786600: rrrrrrrr rrrrrrrr rrrfffff ffffffff
                                               ^
 ffff880058786700: ffffffff ffffffff ffffffff ffffffff
 ffff880058786800: ffffffff ffffffff ffffffff ffffffff
 ffff880058786900: ffffffff rrrrrrrr rrrrrrrr rrrr....
 ffff880058786a00: ........ ........ ........ ........
 ffff880058786b00: ........ ........ ........ ........
Legend:
 f - 8 freed bytes
 r - 8 redzone bytes
 . - 8 allocated bytes
 x=3D1..7 - x allocated bytes + (8-x) redzone bytes


Investigation shows, that f2fs_evict_inode, when called for=20
'meta_inode', uses invalidate_mapping_pages() for 'node_inode'.
But 'node_inode' is deleted before 'meta_inode' in f2fs_put_super via=20
iput().

It seems that in common usage scenario this use-after-free is benign,=20
because 'node_inode' remains partially valid data even after=20
kmem_cache_free().
But things may change if, while 'meta_inode' is evicted in one f2fs=20
filesystem, another (mounted) f2fs filesystem requests inode from cache,=20
and formely
'node_inode' of the first filesystem is returned.


Found by Linux File System Verification project (linuxtesting.org).


--=20
Best regards,



Andrey Tsyvarev



Linux Verification Center, ISPRAS



web:<a class=3D"moz-txt-link-freetext" href=3D"http://linuxtesting.org">h=
ttp://linuxtesting.org</a>

</pre>
      <br>
    </div>
    <br>
  </body>
</html>

--------------060807080702010108060201--


--===============0657635395810566901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
--===============0657635395810566901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============0657635395810566901==--
