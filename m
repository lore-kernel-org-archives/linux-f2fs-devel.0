From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH] f2fs: don't need to collect dirty sit entries
	and flush journal when there's no dirty sit entries
Date: Fri, 27 Feb 2015 16:52:50 +0800
Message-ID: <1425027170-21093-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YRGxB-0001s8-7t
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 09:11:25 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YRGx6-0005MH-2J for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Feb 2015 09:11:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

 Don't need to collect dirty sit entries and flush sit journal to sit 
 entries when there's no dirty sit entries. This patch check dirty_sentries 
 earlier just like flush_nat_entries.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/segment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index daee4ab..e7b83b6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1730,6 +1730,9 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	mutex_lock(&curseg->curseg_mutex);
 	mutex_lock(&sit_i->sentry_lock);
 
+	if (!sit_i->dirty_sentries)
+		goto out;
+
 	/*
 	 * add and account sit entries of dirty bitmap in sit entry
 	 * set temporarily
@@ -1744,9 +1747,6 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (!__has_cursum_space(sum, sit_i->dirty_sentries, SIT_JOURNAL))
 		remove_sits_in_journal(sbi);
 
-	if (!sit_i->dirty_sentries)
-		goto out;
-
 	/*
 	 * there are two steps to flush sit entries:
 	 * #1, flush sit entries to journal in current cold data summary block.
-- 
1.9.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
