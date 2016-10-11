From: Chao Yu <chao@kernel.org>
Subject: [PATCH 7/7] f2fs: avoid casted negative value as shrink
	count
Date: Tue, 11 Oct 2016 22:31:36 +0800
Message-ID: <20161011143136.2107-7-chao@kernel.org>
References: <20161011143136.2107-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyA6-0006qq-LC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:36:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyA5-00034W-T7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:36:10 +0000
In-Reply-To: <20161011143136.2107-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch makes sure it returns a positive value instead of a probable
casted negative value as shrink count.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/shrinker.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 8b0a112..e1220f2 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -21,14 +21,16 @@ static unsigned int shrinker_run_no;
 
 static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 {
-	return NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+
+	return count > 0 ? count : 0;
 }
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	if (NM_I(sbi)->free_nid_cnt > MAX_FREE_NIDS)
-		return NM_I(sbi)->free_nid_cnt - MAX_FREE_NIDS;
-	return 0;
+	long count = NM_I(sbi)->free_nid_cnt - MAX_FREE_NIDS;
+
+	return count > 0 ? count : 0;
 }
 
 static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
