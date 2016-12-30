From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/10] f2fs: avoid needless checkpoint in
	f2fs_trim_fs
Date: Fri, 30 Dec 2016 10:51:16 -0800
Message-ID: <20161230185117.3832-9-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cN2HC-0004Ef-CJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cN2HB-0006gC-Kv
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:38 +0000
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
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

The f2fs_trim_fs() doesn't need to do checkpoint if there are newly allocated
data blocks only which didn't change the critical checkpoint data such as nat
and sit entries.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1a9ba69a22ba..917b5c5053ae 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1248,14 +1248,15 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	f2fs_flush_merged_bios(sbi);
 
 	/* this is the case of multiple fstrims without any changes */
-	if (cpc->reason == CP_DISCARD && !is_sbi_flag_set(sbi, SBI_IS_DIRTY)) {
-		f2fs_bug_on(sbi, NM_I(sbi)->dirty_nat_cnt);
-		f2fs_bug_on(sbi, SIT_I(sbi)->dirty_sentries);
-		f2fs_bug_on(sbi, prefree_segments(sbi));
-		flush_sit_entries(sbi, cpc);
-		clear_prefree_segments(sbi, cpc);
-		unblock_operations(sbi);
-		goto out;
+	if (cpc->reason == CP_DISCARD) {
+		if (NM_I(sbi)->dirty_nat_cnt == 0 &&
+				SIT_I(sbi)->dirty_sentries == 0 &&
+				prefree_segments(sbi) == 0) {
+			flush_sit_entries(sbi, cpc);
+			clear_prefree_segments(sbi, cpc);
+			unblock_operations(sbi);
+			goto out;
+		}
 	}
 
 	/*
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
