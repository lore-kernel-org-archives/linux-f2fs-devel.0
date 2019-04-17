From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: f2fs: SIT corruption upon fsck
Date: Wed, 17 Apr 2019 19:25:04 +0900
Message-ID: <CAD14+f2sT6HbP-vjwWo6A2O151hF=NqcP6_QqLEiEQaZ=QMgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGhkp-0006YC-Hg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 10:25:23 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGhkn-00B3Ek-PG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 10:25:23 +0000
Received: by mail-qk1-f196.google.com with SMTP id c1so14001244qkk.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 03:25:21 -0700 (PDT)
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

I was noticing some truncation warnings on the kernel logs so I went
ahead and ran fsck.

I dumped the image to a btrfs snapshot just in case if fsck fails and
corrupts the image even more, and turns out it did.

The image is formatted with large nat bitmap enabled and using
mkfs.f2fs v1.12.0.
The fsck is from the latest master branch.

After fsck, the image fails to mount at all:
[ 3052.298358] ------------[ cut here ]------------
[ 3052.298359] generic_make_request: Trying to write to read-only
block-device loop1 (partno 0)
[ 3052.298368] WARNING: CPU: 1 PID: 3854 at block/blk-core.c:2174
generic_make_request_checks+0x590/0x630
[ 3052.298394] CPU: 1 PID: 3854 Comm: umount Tainted: G           O
  4.19.35-zen+ #1
[ 3052.298394] Hardware name: System manufacturer System Product
Name/ROG MAXIMUS X HERO (WI-FI AC), BIOS 1704 09/14/2018
[ 3052.298395] RIP: 0010:generic_make_request_checks+0x590/0x630
[ 3052.298396] Code: 5c 03 00 00 48 8d 74 24 08 48 89 df c6 05 b5 cd
36 01 01 e8 c2 90 01 00 48 89 c6 44 89 ea 48 c7 c7 98 64 59 82 e8 d5
9b a7 ff <0f> 0b 48 8b 7b 08 e9 f2 fa ff ff 41 8b 86 98 02 00 00 49 8b
16 89
[ 3052.298397] RSP: 0018:ffff8882bcc97950 EFLAGS: 00010282
[ 3052.298397] RAX: 0000000000000050 RBX: ffff8883f22f7500 RCX: 0000000000000006
[ 3052.298398] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff88884ec56340
[ 3052.298398] RBP: ffff8888437fa6c0 R08: 0000000000000004 R09: 0000000000000405
[ 3052.298398] R10: 0000000000000001 R11: 00000000000006f3 R12: 0000000000001000
[ 3052.298399] R13: 0000000000000000 R14: ffff8886eb92d800 R15: ffff8882bcc97ac0
[ 3052.298399] FS:  00007f0471dae8c0(0000) GS:ffff88884ec40000(0000)
knlGS:0000000000000000
[ 3052.298400] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3052.298400] CR2: 00007f04727302c0 CR3: 0000000213c6f004 CR4: 00000000003606e0
[ 3052.298400] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3052.298401] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3052.298401] Call Trace:
[ 3052.298403]  ? generic_make_request+0x46/0x3d0
[ 3052.298404]  ? wait_woken+0x80/0x80
[ 3052.298405]  ? mempool_alloc+0xb7/0x1a0
[ 3052.298406]  ? submit_bio+0x30/0x110
[ 3052.298407]  ? bvec_alloc+0x7c/0xd0
[ 3052.298409]  ? __submit_merged_bio+0x68/0x390
[ 3052.298410]  ? f2fs_submit_page_write+0x1bb/0x7f0
[ 3052.298410]  ? f2fs_do_write_meta_page+0x7f/0x160
[ 3052.298411]  ? __f2fs_write_meta_page+0x70/0x140
[ 3052.298412]  ? f2fs_sync_meta_pages+0x140/0x250
[ 3052.298413]  ? f2fs_write_checkpoint+0x5c5/0x17b0
[ 3052.298414]  ? f2fs_sync_fs+0x9c/0x110
[ 3052.298416]  ? sync_filesystem+0x66/0x80
[ 3052.298417]  ? generic_shutdown_super+0x1d/0x100
[ 3052.298418]  ? kill_block_super+0x1c/0x40
[ 3052.298418]  ? kill_f2fs_super+0x64/0xb0
[ 3052.298419]  ? deactivate_locked_super+0x2d/0xb0
[ 3052.298420]  ? cleanup_mnt+0x65/0xa0
[ 3052.298421]  ? task_work_run+0x7f/0xa0
[ 3052.298422]  ? exit_to_usermode_loop+0x9c/0xa0
[ 3052.298423]  ? do_syscall_64+0xc7/0xf0
[ 3052.298425]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3052.298425] ---[ end trace d1bb538504008702 ]---
[ 3052.298481] print_req_error: I/O error, dev loop1, sector 12488
[ 3052.298486] print_req_error: I/O error, dev loop1, sector 12648
[ 3052.298488] print_req_error: I/O error, dev loop1, sector 12672
[ 3052.298488] print_req_error: I/O error, dev loop1, sector 33040
[ 3052.298489] print_req_error: I/O error, dev loop1, sector 143048
[ 3052.298491] print_req_error: I/O error, dev loop1, sector 152200
[ 3052.298492] print_req_error: I/O error, dev loop1, sector 8192
[ 3091.204798] F2FS-fs (loop1): SIT is corrupted node# 2481418 vs 2517451
[ 3091.204801] F2FS-fs (loop1): Failed to initialize F2FS segment manager

The fsck output was too huge to to attach here, please visit here instead:
http://arter97.com/f2fs.log.xz

Since I stored this f2fs image inside a btrfs snapshot, I always have
access to the original(mountable) image. Feel free to suggest risky
patches, etc.

Thanks.
