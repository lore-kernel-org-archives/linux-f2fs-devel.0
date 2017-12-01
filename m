From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] mkfs.f2fs: match uid/gid/projid between root
 inode and quota info
Date: Thu, 30 Nov 2017 21:51:54 -0800
Message-ID: <20171201055157.72846-3-jaegeuk@kernel.org>
References: <20171201055157.72846-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eKeFH-0008MD-4L
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKeFG-0004B1-Ci
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:19 +0000
In-Reply-To: <20171201055157.72846-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch fixes mismatched root inode and quota info.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 45963c8..ddd0809 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1061,7 +1061,8 @@ static int f2fs_write_root_inode(void)
 	return 0;
 }
 
-static int f2fs_write_default_quota(int qtype, unsigned int blkaddr)
+static int f2fs_write_default_quota(int qtype, unsigned int blkaddr,
+						__le32 raw_id)
 {
 	char *filebuf = calloc(F2FS_BLKSIZE, 2);
 	int file_magics[] = INITQMAGICS;
@@ -1098,7 +1099,7 @@ static int f2fs_write_default_quota(int qtype, unsigned int blkaddr)
 
 	filebuf[5120 + 8] = 1;
 
-	dqblk.dqb_id = cpu_to_le32(0);
+	dqblk.dqb_id = raw_id;
 	dqblk.dqb_pad = cpu_to_le32(0);
 	dqblk.dqb_ihardlimit = cpu_to_le64(0);
 	dqblk.dqb_isoftlimit = cpu_to_le64(0);
@@ -1129,6 +1130,7 @@ static int f2fs_write_qf_inode(int qtype)
 	struct f2fs_node *raw_node = NULL;
 	u_int64_t data_blk_nor;
 	u_int64_t main_area_node_seg_blk_offset = 0;
+	__le32 raw_id;
 	int i;
 
 	raw_node = calloc(F2FS_BLKSIZE, 1);
@@ -1180,9 +1182,17 @@ static int f2fs_write_qf_inode(int qtype)
 	for (i = 0; i < qtype; i++)
 		if (sb->qf_ino[i])
 			data_blk_nor += QUOTA_DATA(i);
+	if (qtype == 0)
+		raw_id = raw_node->i.i_uid;
+	else if (qtype == 1)
+		raw_id = raw_node->i.i_gid;
+	else if (qtype == 2)
+		raw_id = raw_node->i.i_projid;
+	else
+		ASSERT(0);
 
 	/* write two blocks */
-	if (f2fs_write_default_quota(qtype, data_blk_nor)) {
+	if (f2fs_write_default_quota(qtype, data_blk_nor, raw_id)) {
 		free(raw_node);
 		return -1;
 	}
-- 
2.15.0.403.gc27cc4dac6-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
