From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH RESEND] f2fs:Fix error handling for calls to
	various functions in the function recover_inline_data
Date: Mon, 21 Sep 2015 18:55:49 -0400
Message-ID: <1442876149-15874-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZeA07-0003Sh-H8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 22:55:59 +0000
Received: from mail-io0-f176.google.com ([209.85.223.176])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZeA06-00033N-QI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 22:55:59 +0000
Received: by ioii196 with SMTP id i196so135895886ioi.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 21 Sep 2015 15:55:53 -0700 (PDT)
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

This fixes error handling for calls to various functions in the
function  recover_inline_data to check if these particular functions
either return a error code or the boolean value false to signal their
caller they have failed internally and if this arises return false
to signal failure immediately to the caller of recover_inline_data
as we cannot continue after failures to calling either the function
truncate_inline_inode or truncate_blocks.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/inline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a13ffcc..0ddab9b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -274,12 +274,14 @@ process_inline:
 	if (f2fs_has_inline_data(inode)) {
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
-		truncate_inline_inode(ipage, 0);
+		if (!truncate_inline_inode(ipage, 0))
+			return false;
 		f2fs_clear_inline_inode(inode);
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
-		truncate_blocks(inode, 0, false);
+		if (truncate_blocks(inode, 0, false))
+			return false;
 		goto process_inline;
 	}
 	return false;
-- 
2.1.4


------------------------------------------------------------------------------
