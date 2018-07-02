From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: show the fsync_mode=nobarrier mount option
Date: Mon,  2 Jul 2018 11:37:40 +0530
Message-ID: <1530511660-31323-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1fZs0K-0001ZX-Eg
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 06:08:04 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fZs0I-00B7zO-An
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 06:08:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

This patch shows the fsync_mode=nobarrier mount option in
f2fs_show_options().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3995e92..12e3d2d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1343,6 +1343,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
 		seq_printf(seq, ",fsync_mode=%s", "strict");
+	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
+		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
 	return 0;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
