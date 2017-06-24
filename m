From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: report # of free inodes more precisely
Date: Sat, 24 Jun 2017 09:25:22 -0700
Message-ID: <20170624162522.48931-2-jaegeuk@kernel.org>
References: <20170624162522.48931-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dOnsR-0001Z5-Gm
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 16:25:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dOnsO-0007M9-1P
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 16:25:39 +0000
In-Reply-To: <20170624162522.48931-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If the partition is small, we don't need to report total # of inodes including
hidden free nodes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8e39b850bfc0..3da6fb276f8b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -680,6 +680,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
 	block_t total_count, user_block_count, start_count, ovp_count;
+	u64 avail_node_count;
 
 	total_count = le64_to_cpu(sbi->raw_super->block_count);
 	user_block_count = sbi->user_block_count;
@@ -692,9 +693,16 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi);
 
-	buf->f_files = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
-	buf->f_ffree = min(buf->f_files - valid_node_count(sbi),
-							buf->f_bavail);
+	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
+
+	if (avail_node_count > user_block_count) {
+		buf->f_files = user_block_count;
+		buf->f_ffree = buf->f_bavail;
+	} else {
+		buf->f_files = avail_node_count;
+		buf->f_ffree = min(avail_node_count - valid_node_count(sbi),
+					buf->f_bavail);
+	}
 
 	buf->f_namelen = F2FS_NAME_LEN;
 	buf->f_fsid.val[0] = (u32)id;
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
