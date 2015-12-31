From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: remove f2fs_bug_on in terms of
	max_depth
Date: Thu, 31 Dec 2015 15:49:50 -0800
Message-ID: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aEmyu-0005nG-66
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aEmyt-0007Mh-9I for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:08 +0000
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

There is no report on this bug_on case, but if malicious attacker changed this
field intentionally, we can just reset it as a MAX value.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3da5826..29bb8dd 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -172,8 +172,6 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 	namehash = f2fs_dentry_hash(&name);
 
-	f2fs_bug_on(F2FS_I_SB(dir), level > MAX_DIR_HASH_DEPTH);
-
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
 
@@ -238,6 +236,14 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 		goto out;
 
 	max_depth = F2FS_I(dir)->i_current_depth;
+	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
+		f2fs_msg(F2FS_I_SB(dir)->sb, KERN_WARNING,
+				"Corrupted max_depth of %lu: %u",
+				dir->i_ino, max_depth);
+		max_depth = MAX_DIR_HASH_DEPTH;
+		F2FS_I(dir)->i_current_depth = max_depth;
+		mark_inode_dirty(dir);
+	}
 
 	for (level = 0; level < max_depth; level++) {
 		de = find_in_level(dir, level, &fname, res_page);
-- 
2.6.3


------------------------------------------------------------------------------
