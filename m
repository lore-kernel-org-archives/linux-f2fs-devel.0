From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: fix deadlock to grab 0'th data page
Date: Thu, 13 Nov 2014 16:59:33 -0800
Message-ID: <1415926774-49230-2-git-send-email-jaegeuk@kernel.org>
References: <1415926774-49230-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xp5Eq-0000bI-U4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 00:59:48 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xp5Ep-0005Gr-Ts for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 00:59:48 +0000
In-Reply-To: <1415926774-49230-1-git-send-email-jaegeuk@kernel.org>
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

The scenario is like this.

One trhead triggers:
  f2fs_write_data_pages
    lock_page
    f2fs_write_data_page
      f2fs_lock_op  <- wait

The other thread triggers:
  f2fs_truncate
    truncate_blocks
      f2fs_lock_op
        truncate_partial_data_page
          lock_page  <- wait for locking the page

This patch resolves this bug by relocating truncate_partial_data_page.
This function is just to truncate user data page and not related to FS
consistency as well.
And, we don't need to call truncate_inline_data. Rather than that,
f2fs_write_data_page will finally update inline_data later.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 54722a0..edc3ce8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -477,8 +477,6 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		truncate_inline_data(ipage, from);
-		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
 		goto out;
 	}
@@ -504,13 +502,13 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	f2fs_put_dnode(&dn);
 free_next:
 	err = truncate_inode_blocks(inode, free_from);
+out:
+	if (lock)
+		f2fs_unlock_op(sbi);
 
 	/* lastly zero out the first data page */
 	if (!err)
 		err = truncate_partial_data_page(inode, from);
-out:
-	if (lock)
-		f2fs_unlock_op(sbi);
 
 	trace_f2fs_truncate_blocks_exit(inode, err);
 	return err;
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
