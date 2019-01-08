From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: don't ask anything on dry-run
Date: Tue,  8 Jan 2019 14:02:55 -0800
Message-ID: <20190108220255.46531-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1ggzSi-0002BI-F8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Jan 2019 22:03:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ggzSg-006XP1-Iv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Jan 2019 22:03:04 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

It doesn't need to ask recovering corruption on dry-run mode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 65bdb5d..d3f0c0d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -822,7 +822,7 @@ fsck_again:
 	f2fs_do_umount(sbi);
 
 	if (c.func == FSCK && c.bug_on) {
-		if (!c.ro && c.fix_on == 0 && c.auto_fix == 0) {
+		if (!c.ro && c.fix_on == 0 && c.auto_fix == 0 && !c.dry_run) {
 			char ans[255] = {0};
 retry:
 			printf("Do you want to fix this partition? [Y/N] ");
-- 
2.19.0.605.g01d371f741-goog
