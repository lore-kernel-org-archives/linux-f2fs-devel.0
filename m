From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] f2fs:Fix error handling in the function
	recover_inline_data
Date: Sun,  9 Aug 2015 16:12:07 -0400
Message-ID: <1439151127-28063-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZOWx8-0008GX-57
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 20:12:18 +0000
Received: from mail-ig0-f179.google.com ([209.85.213.179])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZOWx6-0000R4-5z
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 20:12:18 +0000
Received: by igfj19 with SMTP id j19so38548624igf.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 09 Aug 2015 13:12:10 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This fixes error handling in the function recover_inline_data
to check if the function call to truncate_inline_inode has
failed by returning false and if so return immediately to the
caller of recover_inline_data by returning false to signal a
internal failure had occurred when calling this particular function.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a13ffcc..e237c44 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -274,7 +274,8 @@ process_inline:
 	if (f2fs_has_inline_data(inode)) {
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
-		truncate_inline_inode(ipage, 0);
+		if (!truncate_inline_inode(ipage, 0))
+			return false;
 		f2fs_clear_inline_inode(inode);
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
-- 
2.1.4


------------------------------------------------------------------------------
