From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: deny accessing encryption policy if
 encryption is off
Date: Tue, 14 Nov 2017 19:28:42 +0800
Message-ID: <20171114112842.97152-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eEZOy-0004zG-TP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Nov 2017 11:29:12 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eEZOx-0005GM-21
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Nov 2017 11:29:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds missing feature check in encryption ioctl interface.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 41a6f1f70416..25038cfc9217 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1928,6 +1928,9 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
+	if (!f2fs_sb_has_crypto(inode->i_sb))
+		return -EOPNOTSUPP;
+
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	return fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
@@ -1935,6 +1938,8 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 
 static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
 {
+	if (!f2fs_sb_has_crypto(file_inode(filp)->i_sb))
+		return -EOPNOTSUPP;
 	return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
 }
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
