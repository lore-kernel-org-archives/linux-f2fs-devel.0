From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] fsck.f2fs: show total sectors consumed by
	filesystem
Date: Fri, 20 Mar 2015 23:06:31 -0700
Message-ID: <1426917991-25128-3-git-send-email-jaegeuk@kernel.org>
References: <1426917991-25128-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YZCYa-0007fG-KI
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 06:06:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YZCYZ-0001O1-RA for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 06:06:48 +0000
In-Reply-To: <1426917991-25128-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch shows the information about the number of total sectors composing
filesystem.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 879cadb..dfaa596 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -312,6 +312,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 int init_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = sbi->raw_super;
+	u64 total_sectors;
 
 	sbi->log_sectors_per_block =
 		le32_to_cpu(raw_super->log_sectors_per_block);
@@ -329,6 +330,11 @@ int init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
 	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SEGNO;
+
+	total_sectors = le64_to_cpu(raw_super->block_count) <<
+					sbi->log_sectors_per_block;
+	MSG(0, "Info: total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
+				total_sectors, total_sectors >> 11);
 	return 0;
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
