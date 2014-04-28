From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: return i_size if the hole is outside
	of i_size
Date: Mon, 28 Apr 2014 18:48:48 +0900
Message-ID: <1398678529-11067-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WeiDO-0002ey-AU
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Apr 2014 09:51:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WeiDM-0003FL-Bl
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Apr 2014 09:51:10 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4Q002V3JD0K970@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Apr 2014 18:51:00 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When SEEK_HOLE is requeted, it should return i_size if the hole position is
found outside of i_size.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d99d173..3112857 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -255,9 +255,9 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 	if (whence == SEEK_DATA)
 		goto fail;
-	else
-		data_ofs = isize;
 found:
+	if (whence == SEEK_HOLE && data_ofs > isize)
+		data_ofs = isize;
 	mutex_unlock(&inode->i_mutex);
 	return vfs_setpos(file, data_ofs, maxbytes);
 fail:
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
