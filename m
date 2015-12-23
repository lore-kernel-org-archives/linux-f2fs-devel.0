From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: don't convert inline inode when
 inline_data option is disable
Date: Wed, 23 Dec 2015 17:51:35 +0800
Message-ID: <010d01d13d67$9a0eebd0$ce2cc370$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aBg5w-0002VW-Br
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 09:52:32 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aBg5u-0000oW-Fx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 09:52:32 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZT009T1231T9E0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 18:52:14 +0900 (KST)
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

If inline_data option is disable, when truncating an inline inode with
size which is not exceed maxinum inline size, we should not convert
inline inode to regular one to avoid the overhead of synchronizing
conversion.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inline.c | 3 ---
 fs/f2fs/namei.c  | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index c24e5d9..5ffbd16 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -16,9 +16,6 @@
 
 bool f2fs_may_inline_data(struct inode *inode)
 {
-	if (!test_opt(F2FS_I_SB(inode), INLINE_DATA))
-		return false;
-
 	if (f2fs_is_atomic_file(inode))
 		return false;
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 8d2616f..8655dc8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -60,7 +60,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
-	if (f2fs_may_inline_data(inode))
+	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
 	if (f2fs_may_inline_dentry(inode))
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
-- 
2.6.3



------------------------------------------------------------------------------
