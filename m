From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: release inmemory pages when the file
	was closed
Date: Sat,  6 Dec 2014 11:55:38 -0800
Message-ID: <1417895739-15251-4-git-send-email-jaegeuk@kernel.org>
References: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XxLSM-0000Oh-Hx
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Dec 2014 19:55:54 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XxLSL-0007ZI-OI for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Dec 2014 19:55:54 +0000
In-Reply-To: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
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

If file is closed, let's drop inmemory pages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 146e58a..b6f3fbf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -901,6 +901,14 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	return f2fs_convert_inline_inode(inode);
 }
 
+static int f2fs_release_file(struct inode *inode, struct file *filp)
+{
+	/* some remained atomic pages should discarded */
+	if (f2fs_is_atomic_file(inode) || f2fs_is_volatile_file(inode))
+		commit_inmem_pages(inode, true);
+	return 0;
+}
+
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
@@ -1010,6 +1018,7 @@ const struct file_operations f2fs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.open		= generic_file_open,
+	.release	= f2fs_release_file,
 	.mmap		= f2fs_file_mmap,
 	.fsync		= f2fs_sync_file,
 	.fallocate	= f2fs_fallocate,
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
