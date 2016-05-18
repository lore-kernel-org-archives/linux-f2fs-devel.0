From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck.f2fs: check sector size if formatted from a
	regular file
Date: Wed, 18 May 2016 18:00:37 +0800
Message-ID: <1463565637-31806-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1b2yEi-0008Fy-Qd
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 May 2016 09:57:52 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b2yEg-0008ON-7j
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 May 2016 09:57:52 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com
Cc: heyunlei@huwei.com

This patch check sector size if formatted from a regular file,
write the sector info to superblock from device info.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index f866c4f..daafaa9 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1923,6 +1923,38 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 			fsck->chk.valid_nat_entry_cnt);
 }
 
+static int check_sector_size(struct f2fs_super_block * sb)
+{
+	int index;
+	u_int32_t log_sectorsize, log_sectors_per_block;
+	u_int8_t *zero_buff;
+
+	zero_buff = calloc(F2FS_BLKSIZE, 1);
+
+	log_sectorsize = log_base_2(config.sector_size);
+	log_sectors_per_block = log_base_2(config.sectors_per_blk);
+
+	if (log_sectorsize != get_sb(log_sectorsize))
+		set_sb(log_sectorsize, log_sectorsize);
+
+	if (log_sectors_per_block != get_sb(log_sectors_per_block))
+		set_sb(log_sectors_per_block, log_sectors_per_block);
+
+	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
+	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
+	for (index = 0; index < 2; index++) {
+		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
+			MSG(1, "\tError: While while writing supe_blk \
+				on disk!!! index : %d\n", index);
+			free(zero_buff);
+			return -1;
+		}
+	}
+
+	free(zero_buff);
+	return 0;
+}
+
 int f2fs_do_mount(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = NULL;
@@ -1936,6 +1968,10 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 			return -1;
 	}
 
+	ret = check_sector_size(sbi->raw_super);
+	if (ret)
+		return -1;
+
 	print_raw_sb_info(F2FS_RAW_SUPER(sbi));
 
 	init_sb_info(sbi);
-- 
1.9.1


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
