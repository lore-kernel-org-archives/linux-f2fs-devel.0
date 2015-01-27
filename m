From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: should fail mount when trying to
	recover data on read-only dev
Date: Tue, 27 Jan 2015 15:31:42 -0800
Message-ID: <1422401503-4769-4-git-send-email-jaegeuk@kernel.org>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YGFc7-0003pU-78
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Jan 2015 23:32:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGFc6-0007RD-D4 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Jan 2015 23:32:07 +0000
In-Reply-To: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
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

If device is read-only, we should not proceed data recovery.
But, if the previous checkpoint was done by normal clean shutdown, it's safe to
proceed the recovery, since there will be no data to be recovered.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0ca1fb2..7039969 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1149,6 +1149,15 @@ try_onemore:
 
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
+		/*
+		 * mount should be failed, when device has readonly mode, and
+		 * previous checkpoint was not done by clean system shutdown.
+		 */
+		if (bdev_read_only(sb->s_bdev) &&
+				!is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG)) {
+			err = -EROFS;
+			goto free_kobj;
+		}
 		err = recover_fsync_data(sbi);
 		if (err) {
 			f2fs_msg(sb, KERN_ERR,
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
