From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/19] f2fs: introduce f2fs_commit_super
Date: Fri,  1 May 2015 17:48:33 -0700
Message-ID: <1430527726-68547-6-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcP-0001Bf-Ox
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:21 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcP-0004So-3E for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:21 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch introduces f2fs_commit_super to write updated superblock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c98454d..7ff3ac7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1535,6 +1535,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 /*
  * super.c
  */
+int f2fs_commit_super(struct f2fs_sb_info *);
 int f2fs_sync_fs(struct super_block *, int);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *, const char *, const char *, ...);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b2dd1b0..8584168 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -966,6 +966,30 @@ retry:
 	return 0;
 }
 
+int f2fs_commit_super(struct f2fs_sb_info *sbi)
+{
+	struct buffer_head *sbh = sbi->raw_super_buf;
+	sector_t block = sbh->b_blocknr;
+	int err;
+
+	/* write back-up superblock first */
+	sbh->b_blocknr = block ? 0 : 1;
+	mark_buffer_dirty(sbh);
+	err = sync_dirty_buffer(sbh);
+
+	sbh->b_blocknr = block;
+	if (err)
+		goto out;
+
+	/* write current valid superblock */
+	mark_buffer_dirty(sbh);
+	err = sync_dirty_buffer(sbh);
+out:
+	clear_buffer_write_io_error(sbh);
+	set_buffer_uptodate(sbh);
+	return err;
+}
+
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct f2fs_sb_info *sbi;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
