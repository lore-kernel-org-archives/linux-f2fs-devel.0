From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] resize.f2fs: correct checkpoint_ver of new
	checkpoint
Date: Sat, 4 Feb 2017 14:45:59 +0800
Message-ID: <20170204064559.23476-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1cZuIQ-0003MF-TU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Feb 2017 06:58:06 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cZuIK-0001tj-IJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Feb 2017 06:58:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: guoweichao@huawei.com

resize.f2fs rebuilds a new checkpoint at the new position. Its
checkpoint_ver should be increased.

Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
Signed-off-by: Weichao Guo <guoweichao@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/resize.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsck/resize.c b/fsck/resize.c
index 29cb1c0..4791f74 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -415,6 +415,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 			struct f2fs_super_block *new_sb, unsigned int offset)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	unsigned long long cp_ver = get_cp(checkpoint_ver);
 	struct f2fs_checkpoint *new_cp;
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	unsigned int free_segment_count, new_segment_count;
@@ -476,6 +477,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 
 	memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap -
 						(unsigned char *)cp);
+	new_cp->checkpoint_ver = cpu_to_le64(cp_ver + 1);
 
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CHECKSUM_OFFSET);
 	*((__le32 *)((unsigned char *)new_cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
