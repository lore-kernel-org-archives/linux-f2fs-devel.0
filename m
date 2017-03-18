From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: calculate the f2fs_stat_info into base_mem
Date: Sat, 18 Mar 2017 09:25:05 +0800
Message-ID: <7f9edb57-f452-1ee2-5e64-750517231325@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cp37M-0004Cz-1Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:25:16 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cp37L-0004i6-CX
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 01:25:16 +0000
Received: by mail-it0-f67.google.com with SMTP id u69so7128552ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 18:25:15 -0700 (PDT)
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

The memory size of f2fs_stat_info also should be calculated.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ee2d0a4..cf102d1 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -156,7 +156,11 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	if (si->base_mem)
 		goto get_cache;
 
-	si->base_mem = sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
+	/* build stat */
+	si->base_mem = sizeof(struct f2fs_stat_info);
+
+	/* build superb lock*/
+	si->base_mem += sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
 	si->base_mem += 2 * sizeof(struct f2fs_inode_info);
 	si->base_mem += sizeof(*sbi->ckpt);
 	si->base_mem += sizeof(struct percpu_counter) * NR_COUNT_TYPE;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
