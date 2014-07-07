From: Huang Ying <ying.huang@intel.com>
Subject: f2fs: Add f2fs_balance_fs for direct IO
Date: Mon,  7 Jul 2014 13:46:28 +0800
Message-ID: <1404711988-18264-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1X41lK-0002tS-9j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 05:46:50 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X41lJ-0000qq-Hu for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 05:46:50 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Otherwise, if a large amount of direct IO writes were done, the
segment allocation may be failed because no enough segments are gced.

Signed-off-by: Huang, Ying <ying.huang@intel.com>
---
 fs/f2fs/data.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1038,6 +1038,7 @@ static ssize_t f2fs_direct_IO(int rw, st
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
 	/* Let buffer I/O handle the inline data case. */
 	if (f2fs_has_inline_data(inode))
@@ -1046,8 +1047,11 @@ static ssize_t f2fs_direct_IO(int rw, st
 	if (check_direct_IO(inode, rw, iter, offset))
 		return 0;
 
+	if (rw == WRITE)
+		f2fs_balance_fs(sbi);
+
 	/* clear fsync mark to recover these blocks */
-	fsync_mark_clear(F2FS_SB(inode->i_sb), inode->i_ino);
+	fsync_mark_clear(sbi, inode->i_ino);
 
 	return blockdev_direct_IO(rw, iocb, inode, iter, offset,
 				  get_data_block);

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
