From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: fix to truncate dentry pages in the
	error case
Date: Wed, 05 Feb 2014 14:36:34 +0900
Message-ID: <1391578595-854-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WAvBg-0004fh-Ai
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Feb 2014 05:38:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WAvBe-0006zG-7V
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Feb 2014 05:38:16 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0I00DNECZHH170@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Feb 2014 14:38:05 +0900 (KST)
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

When a new directory is allocated, if an error is occurred, we should truncate
preallocated dentry pages too.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index bfcb4ae..daea906c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -372,6 +372,8 @@ static struct page *init_inode_metadata(struct inode *inode,
 
 put_error:
 	f2fs_put_page(page, 1);
+	if (S_ISDIR(inode->i_mode))
+		truncate_blocks(inode, 0);
 error:
 	remove_inode_page(inode);
 	return ERR_PTR(err);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
