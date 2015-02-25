From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid wrong error during recovery
Date: Wed, 25 Feb 2015 13:47:25 -0800
Message-ID: <1424900845-54141-2-git-send-email-jaegeuk@kernel.org>
References: <1424900845-54141-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YQjnt-0000Vm-Dm
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 21:47:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQjns-0004oC-Dm for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 21:47:37 +0000
In-Reply-To: <1424900845-54141-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@motorola.com>

From: Jaegeuk Kim <jaegeuk@motorola.com>

During the roll-forward recovery, -ENOENT for f2fs_iget can be skipped.
So, this error value should not be propagated.

Change-Id: I230ad2371e3fb4b9df42059c4a61f92c1f9838de
Signed-off-by: Jaegeuk Kim <jaegeuk@motorola.com>
---
 fs/f2fs/recovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b2a92d4..6e40874 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -212,8 +212,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 			if (IS_ERR(entry->inode)) {
 				err = PTR_ERR(entry->inode);
 				kmem_cache_free(fsync_entry_slab, entry);
-				if (err == -ENOENT)
+				if (err == -ENOENT) {
+					err = 0;
 					goto next;
+				}
 				break;
 			}
 			list_add_tail(&entry->list, head);
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
