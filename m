From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/13] f2fs: give a chance to mount again when
	encountering errors
Date: Tue, 12 Aug 2014 12:49:23 -0700
Message-ID: <1407872967-26423-9-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4k-00042n-6g
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:42 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4i-0001c4-Cv for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:42 +0000
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
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

This patch gives another chance to try mount process when we encounter an error.
This makes an effect on the roll-forward recovery failures as well.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 60e3554..2856020 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -899,8 +899,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	struct buffer_head *raw_super_buf;
 	struct inode *root;
 	long err = -EINVAL;
+	bool retry = true;
 	int i;
 
+try_onemore:
 	/* allocate memory for f2fs-specific super block info */
 	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -1080,9 +1082,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
 		err = recover_fsync_data(sbi);
-		if (err)
+		if (err) {
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot recover all fsync data errno=%ld", err);
+			goto free_kobj;
+		}
 	}
 
 	/*
@@ -1123,6 +1127,13 @@ free_sb_buf:
 	brelse(raw_super_buf);
 free_sbi:
 	kfree(sbi);
+
+	/* give only one another chance */
+	if (retry) {
+		retry = !retry;
+		shrink_dcache_sb(sb);
+		goto try_onemore;
+	}
 	return err;
 }
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
