From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to convert inline inode in ->setattr
Date: Tue, 01 Dec 2015 11:36:16 +0800
Message-ID: <000001d12be9$87054960$950fdc20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a3bkY-00031V-6a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Dec 2015 03:37:06 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a3bkW-0003oy-F7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Dec 2015 03:37:06 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NYN019Q8U17RW30@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Dec 2015 12:36:56 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In commit 3c4541452748 ("f2fs: do not trim preallocated blocks when
truncating after i_size"), in order to follow the regulation: "truncate(x)
where x > i_size will not trim all blocks past i_size." like other file
systems, in ->setattr we invoked truncate_setsize instead of f2fs_truncate
to avoid unneeded block trimming in such case, but forgot to call
f2fs_convert_inline_inode keep consistency of inline data conversion rule.

This patch fixes to convert inline data if necessary.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 96e4e04..a018ed3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -686,6 +686,14 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			 * larger than i_size.
 			 */
 			truncate_setsize(inode, attr->ia_size);
+
+			/* should convert inline inode here */
+			if (f2fs_has_inline_data(inode) &&
+					!f2fs_may_inline_data(inode)) {
+				err = f2fs_convert_inline_inode(inode);
+				if (err)
+					return err;
+			}
 			inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		}
 	}
-- 
2.6.3



------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
