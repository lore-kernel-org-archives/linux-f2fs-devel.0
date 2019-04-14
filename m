From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: f2fs: trying to write to read-only block-device
Date: Sun, 14 Apr 2019 23:14:26 +0900
Message-ID: <CAD14+f2WfTX9HDW6n6Ljsekg-b+jgfeP39a7KkAKpURs0at4NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hFfuC-0007K1-70
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 14:14:48 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hFfuA-005JlK-Ui
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Apr 2019 14:14:48 +0000
Received: by mail-qt1-f195.google.com with SMTP id v32so16343485qtc.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 14 Apr 2019 07:14:46 -0700 (PDT)
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

Hi,

While I was playing around a f2fs image dumped from an Android device,
I observed that f2fs were trying to write to the image when I mounted
it via ro.

The host is Linux 4.19 with 5.1-rc1-4.19 merged.

f2fs might be trying to write to the device when the quota is
corrupted, regardless of ro being passed to the mount option or not.

I believe this is an easy issue to fix.

Thanks.

[17431.491120] F2FS-fs (loop0): orphan cleanup on readonly fs
[17431.491121] F2FS-fs (loop0): quota file may be corrupted, skip loading it
[17431.491710] F2FS-fs (loop0): recover fsync data on readonly fs
[17431.491711] F2FS-fs (loop0): quota file may be corrupted, skip loading it
[17431.492021] ------------[ cut here ]------------
[17431.492022] generic_make_request: Trying to write to read-only
block-device loop0 (partno 0)
[17431.492035] WARNING: CPU: 0 PID: 23437 at block/blk-core.c:2174
generic_make_request_checks+0x594/0x630
[17431.492081] CPU: 0 PID: 23437 Comm: mount Tainted: G     U  W
  4.19.33-zen+ #1
[17431.492082] Hardware name: LG Electronics
14ZD980-GX50K/14Z980, BIOS K2ZC0250 X64 03/08/2018
[17431.492084] RIP: 0010:generic_make_request_checks+0x594/0x630
[17431.492085] Code: 5c 03 00 00 48 8d 74 24 08 48 89 df c6 05 71 ec
36 01 01 e8 6e 91 01 00 48 89 c6 44 89 ea 48 c7 c7 10 61 59 82 e8 21
bb a7 ff <0f> 0b 48 8b 7b 08 e9 ee fa ff ff 65 8b 05 8a 71 91 7e 89 c0
48 0f
[17431.492086] RSP: 0018:ffff88825a94b700 EFLAGS: 00010286
[17431.492087] RAX: 0000000000000050 RBX: ffff88842d3e0b00 RCX: 0000000000000006
[17431.492088] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff888433416340
[17431.492088] RBP: ffff8884303d1d10 R08: 0000000000000004 R09: 0000000000000542
[17431.492089] R10: 0000000000000001 R11: 000000000000027f R12: 0000000000001000
[17431.492090] R13: 0000000000000000 R14: ffff88840a179000 R15: ffff88825a94b870
[17431.492091] FS:  00007fd885c988c0(0000) GS:ffff888433400000(0000)
knlGS:0000000000000000
[17431.492091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17431.492092] CR2: 00007fd88636eee0 CR3: 000000017a4c3006 CR4: 00000000003606f0
[17431.492093] Call Trace:
[17431.492096]  ? generic_make_request+0x46/0x3d0
[17431.492098]  ? wait_woken+0x80/0x80
[17431.492099]  ? mempool_alloc+0xb7/0x1a0
[17431.492101]  ? submit_bio+0x30/0x110
[17431.492102]  ? bvec_alloc+0x7c/0xd0
[17431.492104]  ? __submit_merged_bio+0x68/0x390
[17431.492106]  ? f2fs_submit_page_write+0x1bb/0x7f0
[17431.492108]  ? f2fs_do_write_meta_page+0x7f/0x160
[17431.492109]  ? __f2fs_write_meta_page+0x70/0x140
[17431.492110]  ? f2fs_sync_meta_pages+0x140/0x250
[17431.492112]  ? f2fs_write_checkpoint+0x5c5/0x17b0
[17431.492115]  ? __schedule+0x1b9/0x6b0
[17431.492116]  ? f2fs_sync_fs+0x9c/0x110
[17431.492119]  ? sync_filesystem+0x66/0x80
[17431.492120]  ? f2fs_recover_fsync_data+0x790/0xa30
[17431.492122]  ? f2fs_fill_super+0xe4e/0x1980
[17431.492123]  ? pointer+0x149/0x320
[17431.492124]  ? pcpu_alloc_area+0xdd/0x120
[17431.492126]  ? snprintf+0x39/0x40
[17431.492127]  ? mount_bdev+0x518/0x610
[17431.492128]  ? mount_bdev+0x518/0x610
[17431.492129]  ? f2fs_commit_super+0x160/0x160
[17431.492130]  ? mount_fs+0x34/0x13f
[17431.492132]  ? vfs_kern_mount.part.11+0x4f/0x120
[17431.492133]  ? do_mount+0x2d1/0xe40
[17431.492135]  ? memdup_user+0x39/0x60
[17431.492137]  ? __x64_sys_mount+0xbf/0xe0
[17431.492139]  ? do_syscall_64+0x4a/0xf0
[17431.492140]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[17431.492141] ---[ end trace 74417a97d9cf58c5 ]---
[17431.492237] print_req_error: I/O error, dev loop0, sector 16872
[17431.492243] print_req_error: I/O error, dev loop0, sector 21032
[17431.492245] print_req_error: I/O error, dev loop0, sector 47728
[17431.492247] print_req_error: I/O error, dev loop0, sector 4096
[17431.492258] F2FS-fs (loop0): Mounted with checkpoint version = 26e7ba3f
