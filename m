From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: fix livelock calling f2fs_iget during
	f2fs_evict_inode
Date: Sun, 23 Nov 2014 21:52:53 -0800
Message-ID: <1416808373-24417-2-git-send-email-jaegeuk@kernel.org>
References: <1416808373-24417-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xsma3-0001x9-Rc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Nov 2014 05:53:00 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xsma2-0001n2-Up for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Nov 2014 05:52:59 +0000
In-Reply-To: <1416808373-24417-1-git-send-email-jaegeuk@kernel.org>
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

In f2fs_evict_inode,
 commit_inmemory_pages
   f2fs_gc
     f2fs_iget
       iget_locked
         -> wait for inode free

Here, if the inode is same as the one to be evicted, f2fs should wait forever.
Actually, we should not call f2fs_balance_fs during f2fs_evict_inode to avoid
this.

But, the commit_inmem_pages calls f2fs_balance_fs by default, even if
f2fs_evict_inode wants to free inmemory pages only.

Hence, this patch adds to trigger f2fs_balance_fs only when there is something
to write.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9de857f..9a33e34 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -230,7 +230,16 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 		.rw = WRITE_SYNC,
 	};
 
-	f2fs_balance_fs(sbi);
+	/*
+	 * The abort is true only when f2fs_evict_inode is called.
+	 * Basically, the f2fs_evict_inode doesn't produce any data writes, so
+	 * that we don't need to call f2fs_balance_fs.
+	 * Otherwise, f2fs_gc in f2fs_balance_fs can wait forever until this
+	 * inode becomes free by iget_locked in f2fs_iget.
+	 */
+	if (!abort)
+		f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 
 	mutex_lock(&fi->inmem_lock);
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
