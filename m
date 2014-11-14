From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: convert inline_data when i_size
	becomes large
Date: Thu, 13 Nov 2014 16:59:34 -0800
Message-ID: <1415926774-49230-3-git-send-email-jaegeuk@kernel.org>
References: <1415926774-49230-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xp5Et-0001vH-SK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 00:59:51 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xp5Es-0007xw-SL for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 00:59:51 +0000
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

If i_size becomes large outside of MAX_INLINE_DATA, we shoud convert the inode.
Otherwise, we can make some dirty pages during the truncation, and those pages
will be written through f2fs_write_data_page.
At that moment, the inode has still inline_data, so that it tries to write non-
zero pages into inline_data area.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c   | 6 ++++++
 fs/f2fs/inline.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc3ce8..7c2ec3e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -522,6 +522,12 @@ void f2fs_truncate(struct inode *inode)
 
 	trace_f2fs_truncate(inode);
 
+	/* we should check inline_data size */
+	if (f2fs_has_inline_data(inode) && !f2fs_may_inline(inode)) {
+		if (f2fs_convert_inline_inode(inode))
+			return;
+	}
+
 	if (!truncate_blocks(inode, i_size_read(inode), true)) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 2310670..053d114 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -24,6 +24,9 @@ bool f2fs_may_inline(struct inode *inode)
 	if (!S_ISREG(inode->i_mode))
 		return false;
 
+	if (i_size_read(inode) > MAX_INLINE_DATA)
+		return false;
+
 	return true;
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
