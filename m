From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid stale fi->gdirty_list pointer
Date: Thu, 12 Oct 2017 19:14:11 -0700
Message-ID: <20171013021411.25850-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e2pUS-0005hv-1V
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 02:14:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e2pUR-0004Km-Ao
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 02:14:19 +0000
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

When doing fault injection test, f2fs_evict_inode() didn't remove gdirty_list
which incurs a kernel panic due to wrong pointer access.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f6db9d533ca4..1ae5396c97d6 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -535,6 +535,8 @@ void f2fs_evict_inode(struct inode *inode)
 
 	if (!is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
 		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
+	else
+		f2fs_inode_synced(inode);
 
 	/* ino == 0, if f2fs_new_inode() was failed t*/
 	if (inode->i_ino)
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
