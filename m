From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 1/2] f2fs: fix the fault of checking
 F2FS_LINK_MAX for rename inode
Date: Sat, 4 Mar 2017 21:48:28 +0800
Message-ID: <5aa9764c-4885-0054-9e6b-53e9b0f41691@gmail.com>
References: <02f41895-ea36-df3c-1295-46fa960b20bd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1ckA39-0003ZP-Av
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 13:48:43 +0000
Received: from mail-io0-f196.google.com ([209.85.223.196])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ckA38-0004h6-LC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 13:48:43 +0000
Received: by mail-io0-f196.google.com with SMTP id 68so10625409ioh.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 04 Mar 2017 05:48:42 -0800 (PST)
In-Reply-To: <02f41895-ea36-df3c-1295-46fa960b20bd@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>, Kinglong Mee <kinglongmee@gmail.com>

The parent directory's nlink will change, not the inode.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 0eda022..3231a0a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -908,8 +908,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		old_nlink = old_dir_entry ? -1 : 1;
 		new_nlink = -old_nlink;
 		err = -EMLINK;
-		if ((old_nlink > 0 && old_inode->i_nlink >= F2FS_LINK_MAX) ||
-			(new_nlink > 0 && new_inode->i_nlink >= F2FS_LINK_MAX))
+		if ((old_nlink > 0 && old_dir->i_nlink >= F2FS_LINK_MAX) ||
+			(new_nlink > 0 && new_dir->i_nlink >= F2FS_LINK_MAX))
 			goto out_new_dir;
 	}
 
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
