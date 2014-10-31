From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: remove unnecessary macro
Date: Thu, 30 Oct 2014 23:16:15 -0700
Message-ID: <1414736176-13201-3-git-send-email-jaegeuk@kernel.org>
References: <1414736176-13201-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xk5VW-0001OK-Ae
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:16:22 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xk5VV-0004hN-In for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:16:22 +0000
In-Reply-To: <1414736176-13201-1-git-send-email-jaegeuk@kernel.org>
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

Let's remove unused macro.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/linux/f2fs_fs.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index cc1064f..87f14e9 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -177,10 +177,6 @@ struct f2fs_extent {
 #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
 						F2FS_INLINE_XATTR_ADDRS - 1))
 
-#define INLINE_DATA_OFFSET	(PAGE_CACHE_SIZE - sizeof(struct node_footer) -\
-				sizeof(__le32) * (DEF_ADDRS_PER_INODE + \
-				DEF_NIDS_PER_INODE - 1))
-
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
 	__u8 i_advise;			/* file hints */
-- 
2.1.1


------------------------------------------------------------------------------
