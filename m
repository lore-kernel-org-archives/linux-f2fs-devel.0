From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: refactor f2fs_commit_super
Date: Mon,  7 Dec 2015 14:53:24 -0800
Message-ID: <1449528805-89661-2-git-send-email-jaegeuk@kernel.org>
References: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a64f6-0003YR-1j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 22:53:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a64f5-0003ID-C0 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 22:53:40 +0000
In-Reply-To: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
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

Previously, f2fs_commit_super hacks the bh->blocknr to write the broken
alternate superblock.
Instead of it, we should use the correct logic to retrieve its buffer head
with locking it appropriately.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bd7e9c6..dbf16ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1099,27 +1099,35 @@ out:
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
 	struct buffer_head *sbh = sbi->raw_super_buf;
-	sector_t block = sbh->b_blocknr;
+	struct buffer_head *bh;
 	int err;
 
 	/* write back-up superblock first */
-	sbh->b_blocknr = block ? 0 : 1;
-	mark_buffer_dirty(sbh);
-	err = sync_dirty_buffer(sbh);
+	bh = sb_getblk(sbi->sb, sbh->b_blocknr ? 0 : 1);
+	if (!bh)
+		return -EIO;
 
-	sbh->b_blocknr = block;
+	lock_buffer(bh);
+	memcpy(bh->b_data, sbh->b_data, sbh->b_size);
+	WARN_ON(sbh->b_size != F2FS_BLKSIZE);
+	set_buffer_uptodate(bh);
+	set_buffer_dirty(bh);
+	unlock_buffer(bh);
+
+	/* it's rare case, we can do fua all the time */
+	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
+	brelse(bh);
 
 	/* if we are in recovery path, skip writing valid superblock */
 	if (recover || err)
-		goto out;
+		return err;
 
 	/* write current valid superblock */
-	mark_buffer_dirty(sbh);
-	err = sync_dirty_buffer(sbh);
-out:
-	clear_buffer_write_io_error(sbh);
-	set_buffer_uptodate(sbh);
-	return err;
+	lock_buffer(sbh);
+	set_buffer_dirty(sbh);
+	unlock_buffer(sbh);
+
+	return __sync_dirty_buffer(sbh, WRITE_FLUSH_FUA);
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
