From: Gao Xiang <gaoxiang25@huawei.com>
Subject: [RESEND PATCH] f2fs: no need to take the address of the
 array of sb->s_uuid
Date: Thu, 5 Apr 2018 11:58:21 +0800
Message-ID: <94ebbd85-1b8d-927a-ae94-93aa6ded4e23@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gaoxiang25@huawei.com>) id 1f3w3l-0005Vr-Kh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 03:59:37 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3w3j-009W6J-G7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 03:59:37 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>
Cc: Gao Xiang <hsiangkao@aol.com>, hutj <hutj@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Keep in line with the common case since it is some weird
to take the address of an array again.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
fix auto-wrapping of email client

 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9587ca0..4d467c7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2565,7 +2565,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_time_gran = 1;
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
-	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
+	memcpy(sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	/* init f2fs-specific super block info */
-- 
2.1.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
