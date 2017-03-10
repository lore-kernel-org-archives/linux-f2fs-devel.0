From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 4/4] f2fs: move mnt_want_write_file after
	arguments checking
Date: Fri, 10 Mar 2017 17:55:07 +0800
Message-ID: <38ebf755-3f0d-b1c0-7df6-6f38418c0b36@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cmHGY-0000Fb-S8
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:55:18 +0000
Received: from mail-io0-f194.google.com ([209.85.223.194])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cmHGY-00081q-2q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:55:18 +0000
Received: by mail-io0-f194.google.com with SMTP id f103so6489802ioi.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 10 Mar 2017 01:55:18 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

It's needless of mnt_want_write_file for arguments checking.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/file.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 08bfab3..c407fa6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2023,45 +2023,37 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	err = mnt_want_write_file(filp);
-	if (err)
-		return err;
-
-	if (f2fs_readonly(sbi->sb)) {
-		err = -EROFS;
-		goto out;
-	}
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
 
 	if (copy_from_user(&range, (struct f2fs_defragment __user *)arg,
-							sizeof(range))) {
-		err = -EFAULT;
-		goto out;
-	}
+							sizeof(range)))
+		return -EFAULT;
 
 	/* verify alignment of offset & size */
-	if (range.start & (F2FS_BLKSIZE - 1) ||
-		range.len & (F2FS_BLKSIZE - 1)) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (range.start & (F2FS_BLKSIZE - 1) || range.len & (F2FS_BLKSIZE - 1))
+		return -EINVAL;
 
 	if (unlikely((range.start + range.len) >> PAGE_SHIFT >
-					sbi->max_file_blocks)) {
-		err = -EINVAL;
-		goto out;
-	}
+					sbi->max_file_blocks))
+		return -EINVAL;
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
 
 	err = f2fs_defragment_range(sbi, filp, &range);
+	mnt_drop_write_file(filp);
+
 	f2fs_update_time(sbi, REQ_TIME);
 	if (err < 0)
-		goto out;
+		return err;
 
 	if (copy_to_user((struct f2fs_defragment __user *)arg, &range,
 							sizeof(range)))
-		err = -EFAULT;
-out:
-	mnt_drop_write_file(filp);
-	return err;
+		return -EFAULT;
+
+	return 0;
 }
 
 static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
