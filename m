From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix oops of set_bit_le in arm64
	architecture
Date: Tue, 7 Mar 2017 09:59:31 +0800
Message-ID: <20170307015931.119518-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cl4QU-0005YJ-42
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 02:00:34 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cl4QS-0007NM-8c
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 02:00:34 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As Adam borowski reported:

"The filesystem mounts fine on amd64 on 4.11-rc1, it also works fine with
both next-20170216 and 4.9 on arm64.

The machine in question is not fully mainlined yet, I'm using Icenowy's
patchsets from git@github.com:Icenowy/linux.git; I have no other arm64
hardware to test (could try qemu...).

good: icenowy/sunxi64-next-20170216
bad:  icenowy/sunxi64-4.11-rc1

[<ffff000008463798>] set_bit+0x18/0x30
[<ffff0000083f4640>] scan_nat_page+0xe0/0x118
[<ffff0000083f4784>] build_free_nids+0x10c/0x5e8
[<ffff0000083f6fe4>] build_node_manager+0x394/0x3d0
[<ffff0000083e2d1c>] f2fs_fill_super+0x884/0x11e0
[<ffff0000081f26d8>] mount_bdev+0x190/0x1b8
[<ffff0000083e0c84>] f2fs_mount+0x14/0x20
[<ffff0000081f355c>] mount_fs+0x4c/0x168
[<ffff000008210bc0>] vfs_kern_mount+0x50/0x130
[<ffff000008213700>] do_mount+0x1b0/0xbb8
[<ffff000008214494>] SyS_mount+0x8c/0xf8
[<ffff000008b110ac>] mount_block_root+0x100/0x25c
[<ffff000008b11324>] mount_root+0x11c/0x134
[<ffff000008b11478>] prepare_namespace+0x13c/0x184
[<ffff000008b10d70>] kernel_init_freeable+0x214/0x238
[<ffff0000088445d8>] kernel_init+0x10/0x100
[<ffff000008082ec0>] ret_from_fork+0x10/0x50
Code: d2800022 8b400c21 f9800031 9ac32043 (c85f7c22)
---[ end trace a8a385a1e8cd5a36 ]---
Kernel panic - not syncing: Attempted to kill init! "

The reason is in arm64 architecture there is restriction for parameter
@addr of {set,clear}_bit_le, the value of it must be 64-bits aligned.

In this patch we will change each bitmap size of NAT block to be 64-bits
aligned to avoid that issue.

Reported-by: Adam Borowski <kilobyte@angband.pl>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/linux/f2fs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index e2d239ed4c60..92697f3fff7b 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -279,7 +279,7 @@ struct f2fs_node {
  * For NAT entries
  */
 #define NAT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_nat_entry))
-#define NAT_ENTRY_BITMAP_SIZE	((NAT_ENTRY_PER_BLOCK + 7) / 8)
+#define NAT_ENTRY_BITMAP_SIZE	((NAT_ENTRY_PER_BLOCK + 63) / 8)
 
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
