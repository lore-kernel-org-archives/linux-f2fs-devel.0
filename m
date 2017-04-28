From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: support to set and recognize
	CP_TRIMMED_FLAG
Date: Fri, 28 Apr 2017 17:16:31 +0800
Message-ID: <20170428091631.56063-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d4227-0004XK-Ny
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Apr 2017 09:17:47 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d4224-0006sp-J2
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Apr 2017 09:17:47 +0000
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

During mkfs, once we have issued discard for all device, we can set
CP_TRIMMED_FLAG in cp pack, this can make kernel module to record
undiscard blocks correctly, it will help to avoid unneeded discard.

Also this patch makes f2fs-tools be with the ability of recognizing
that new flag.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c             | 2 ++
 include/f2fs_fs.h        | 2 ++
 lib/libf2fs.c            | 1 +
 mkfs/f2fs_format.c       | 4 ++++
 mkfs/f2fs_format_utils.c | 1 +
 5 files changed, 10 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 6350ad626bda..a0b0beadad70 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -259,6 +259,8 @@ void print_cp_state(u32 flag)
 		MSG(0, "%s", " fastboot");
 	if (flag & CP_NAT_BITS_FLAG)
 		MSG(0, "%s", " nat_bits");
+	if (flag & CP_TRIMMED_FLAG)
+		MSG(0, "%s", " trimmed");
 	if (flag & CP_UMOUNT_FLAG)
 		MSG(0, "%s", " unmount");
 	else
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index fa9d5365961a..43760d4359b0 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -287,6 +287,7 @@ struct f2fs_configuration {
 	int dbg_lv;
 	int show_dentry;
 	int trim;
+	int trimmed;
 	int func;
 	void *private;
 	int fix_on;
@@ -515,6 +516,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_TRIMMED_FLAG		0x00000100
 #define CP_NAT_BITS_FLAG	0x00000080
 #define CP_CRC_RECOVERY_FLAG	0x00000040
 #define CP_FASTBOOT_FLAG	0x00000020
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 7352837f8924..c96506aa81da 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -571,6 +571,7 @@ void f2fs_init_configuration(void)
 	c.heap = 0;
 	c.vol_label = "";
 	c.trim = 1;
+	c.trimmed = 0;
 	c.ro = 0;
 	c.kd = -1;
 }
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index d354c881fbef..2e9c19a07fc2 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -579,6 +579,10 @@ static int f2fs_write_check_point_pack(void)
 	if (get_cp(cp_pack_total_block_count) <=
 			(1 << get_sb(log_blocks_per_seg)) - nat_bits_blocks)
 		flags |= CP_NAT_BITS_FLAG;
+
+	if (c.trimmed)
+		flags |= CP_TRIMMED_FLAG;
+
 	set_cp(ckpt_flags, flags);
 	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
 	set_cp(valid_node_count, 1);
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index fc80ec6ab06f..558684d45909 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -90,5 +90,6 @@ int f2fs_trim_devices(void)
 	for (i = 0; i < c.ndevs; i++)
 		if (trim_device(i))
 			return -1;
+	c.trimmed = 1;
 	return 0;
 }
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
