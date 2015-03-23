From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/4] f2fs: persist system.advise into on-disk
	inode
Date: Mon, 23 Mar 2015 10:37:39 +0800
Message-ID: <002501d06512$6ebf1e60$4c3d5b20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YZsG8-00060f-St
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Mar 2015 02:38:32 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YZsG7-00023k-12
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Mar 2015 02:38:32 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NLN00B1Z8NZH690@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Mar 2015 11:38:23 +0900 (KST)
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

This patch fixes to dirty inode for persisting i_advise of f2fs inode info into
on-disk inode if user sets system.advise through setxattr. Otherwise the new
value will be lost.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 55649be..b0fd2f2 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -153,6 +153,7 @@ static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
 		return -EINVAL;
 
 	F2FS_I(inode)->i_advise |= *(char *)value;
+	mark_inode_dirty(inode);
 	return 0;
 }
 
-- 
2.3.3



------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
