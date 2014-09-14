From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/10] f2fs: do not skip latest inode information
Date: Sun, 14 Sep 2014 15:14:20 -0700
Message-ID: <1410732864-53069-6-git-send-email-jaegeuk@kernel.org>
References: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XTI45-0003DZ-RY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:37 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XTI44-0007K1-Rq for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:37 +0000
In-Reply-To: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
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

In f2fs_sync_file, if there is no written appended writes, it skips
to write its node blocks.
But, if there is up-to-date inode page, we should write it to update
its metadata during the roll-forward recovery.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c814cd2..fb96256 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -169,12 +169,21 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
 			!exist_written_data(sbi, ino, APPEND_INO)) {
+		struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
+
+		/* But we need to avoid that there are some inode updates */
+		if ((i && PageDirty(i)) || !fsync_mark_done(sbi, ino)) {
+			f2fs_put_page(i, 0);
+			goto go_write;
+		}
+		f2fs_put_page(i, 0);
+
 		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) ||
 				exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
 	}
-
+go_write:
 	/* guarantee free sections for fsync */
 	f2fs_balance_fs(sbi);
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
