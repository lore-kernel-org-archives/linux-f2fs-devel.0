From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/3] f2fs: return errors right after checking them
Date: Wed, 23 Apr 2014 14:23:32 +0900
Message-ID: <1398230612-7062-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1398230612-7062-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wcph4-0000b4-H1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Apr 2014 05:26:02 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wcph3-0008Ge-8f
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Apr 2014 05:26:02 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4G00BABXQW9U20@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Apr 2014 14:25:44 +0900 (KST)
In-reply-to: <1398230612-7062-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch adds two error conditions early in the setxattr operations.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/xattr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index bbe9c2b..6073f9f 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -509,8 +509,16 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	here = __find_xattr(base_addr, index, len, name);
 
 	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
-	last = here;
 
+	if ((flags & XATTR_REPLACE) && !found) {
+		error = -ENODATA;
+		goto exit;
+	} else if ((flags & XATTR_CREATE) && found) {
+		error = -EEXIST;
+		goto exit;
+	}
+
+	last = here;
 	while (!IS_XATTR_LAST_ENTRY(last))
 		last = XATTR_NEXT_ENTRY(last);
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
