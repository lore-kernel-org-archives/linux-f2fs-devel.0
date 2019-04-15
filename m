From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH] f2fs: avoid retrying quota flushes while the
 device is congested
Date: Mon, 15 Apr 2019 22:07:03 +0900
Message-ID: <20190415130703.23983-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hG1Kb-0008Dm-Pu
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 13:07:29 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hG1KN-006QfC-6t
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 13:07:29 +0000
Received: by mail-pl1-f194.google.com with SMTP id f36so8552656plb.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Apr 2019 06:07:14 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

While experimenting with ICE/FBE + f2fs on an Android device,
I was able to reliably reproduce quota corruption during
initial setup wizard.

During 10 times of factory resets, quota flushes failed 5 times each
in average.

Add a wait for uncongestion on quota flush retries to resolve the issue.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/f2fs/checkpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a98e1b02279e..e63cfab6be5d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1130,6 +1130,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	f2fs_lock_all(sbi);
 	if (__need_flush_quota(sbi)) {
 		f2fs_unlock_all(sbi);
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
 		cond_resched();
 		goto retry_flush_quotas;
 	}
-- 
2.21.0
