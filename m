From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: avoid stat_inc_atomic_write for non-atomic
	file
Date: Sat, 18 Mar 2017 09:20:55 +0800
Message-ID: <1ef1a5ac-5198-16bd-4bdc-c2b21f232ea1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cp33N-0002rw-5w
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:21:09 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cp33L-0005Ap-BG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:21:09 +0000
Received: by mail-it0-f65.google.com with SMTP id y18so7177374itc.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 18:21:07 -0700 (PDT)
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

After filemap_write_and_wait_range fail, the FI_ATOMIC_FILE flags is removed,
so that f2fs should not increase the stat of atomic_write.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d486e02..54cfcaa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1533,17 +1533,21 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!get_dirty_pages(inode))
-		goto out;
+		goto inc_stat;
 
 	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
 		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
-	if (ret)
+	if (ret) {
 		clear_inode_flag(inode, FI_ATOMIC_FILE);
-out:
+		goto out;
+	}
+
+inc_stat:
 	stat_inc_atomic_write(inode);
 	stat_update_max_atomic_write(inode);
+out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
