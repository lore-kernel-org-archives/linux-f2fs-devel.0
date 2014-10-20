From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/09] f2fs: should truncate any allocated block
	for inline_data write
Date: Sun, 19 Oct 2014 22:18:26 -0700
Message-ID: <1413782312-11631-3-git-send-email-jaegeuk@kernel.org>
References: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xg5Mh-0007lg-Lv
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:43 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xg5Mg-0000qi-RN for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Oct 2014 05:18:43 +0000
In-Reply-To: <1413782312-11631-1-git-send-email-jaegeuk@kernel.org>
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

When trying to write inline_data, we should truncate any data block allocated
and pointed by the inode block.
We should consider the data index is not 0.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 88036fd..e3abcfb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -166,6 +166,14 @@ int f2fs_write_inline_data(struct inode *inode,
 		return err;
 	ipage = dn.inode_page;
 
+	/* Release any data block if it is allocated */
+	if (!f2fs_has_inline_data(inode)) {
+		int count = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+		truncate_data_blocks_range(&dn, count);
+		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+		stat_inc_inline_inode(inode);
+	}
+
 	f2fs_wait_on_page_writeback(ipage, NODE);
 	zero_user_segment(ipage, INLINE_DATA_OFFSET,
 				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
@@ -174,13 +182,6 @@ int f2fs_write_inline_data(struct inode *inode,
 	memcpy(dst_addr, src_addr, size);
 	kunmap(page);
 
-	/* Release the first data block if it is allocated */
-	if (!f2fs_has_inline_data(inode)) {
-		truncate_data_blocks_range(&dn, 1);
-		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
-		stat_inc_inline_inode(inode);
-	}
-
 	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 	sync_inode_page(&dn);
 	f2fs_put_dnode(&dn);
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
