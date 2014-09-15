From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/5] f2fs: skip punching hole in special condition
Date: Mon, 15 Sep 2014 18:03:32 +0800
Message-ID: <002f01cfd0cc$6a4c3a00$3ee4ae00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XTT92-00056i-E6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 10:04:28 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XTT91-0006Oh-5o
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 10:04:28 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NBX00BWUTB797A0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 19:04:19 +0900 (KST)
Content-language: zh-cn
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Now punching hole in directory is not supported in f2fs, so let's limit file
type in punch_hole().

In addition, in punch_hole if offset is exceed file size, we should skip
punching hole.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b34101..ecf94e1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -645,6 +645,13 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	loff_t off_start, off_end;
 	int ret = 0;
 
+	if (!S_ISREG(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	/* skip punching hole beyond i_size */
+	if (offset >= inode->i_size)
+		return ret;
+
 	ret = f2fs_convert_inline_data(inode, MAX_INLINE_DATA + 1, NULL);
 	if (ret)
 		return ret;
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
