From: Yaowei Bai <bywxiaobai@163.com>
Subject: [PATCH 08/17] fs/f2fs: remove unnecessary new_valid_dev
	check
Date: Mon, 28 Sep 2015 21:55:02 +0800
Message-ID: <1443448502-5331-1-git-send-email-bywxiaobai@163.com>
References: <1443446807-4838-1-git-send-email-bywxiaobai@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bywxiaobai@163.com>) id 1ZgYvr-00061d-Nd
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 13:57:31 +0000
Received: from m12-18.163.com ([220.181.12.18])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZgYvn-0002c3-Af for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 13:57:31 +0000
In-Reply-To: <1443446807-4838-1-git-send-email-bywxiaobai@163.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, cm224.lee@samsung.com, chao2.yu@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

As new_valid_dev always returns 1, so !new_valid_dev check is not
needed, remove it.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 fs/f2fs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a680bf3..c87ec52 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -478,9 +478,6 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int err = 0;
 
-	if (!new_valid_dev(rdev))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi);
 
 	inode = f2fs_new_inode(dir, mode);
-- 
1.9.1



------------------------------------------------------------------------------
