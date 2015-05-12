From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: do not issue next dnode discard
	redundantly
Date: Mon, 11 May 2015 20:48:47 -0700
Message-ID: <1431402528-24156-2-git-send-email-jaegeuk@kernel.org>
References: <1431402528-24156-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ys1Bk-0006NR-HK
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 03:49:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ys1Bj-0005zC-QD for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 03:49:00 +0000
In-Reply-To: <1431402528-24156-1-git-send-email-jaegeuk@kernel.org>
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

We have a discard map, so that we can avoid redundant discard issues.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2c40ce1..342e0f7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -486,7 +486,20 @@ static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 
 void discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-	if (f2fs_issue_discard(sbi, blkaddr, 1)) {
+	int err = -ENOTSUPP;
+
+	if (test_opt(sbi, DISCARD)) {
+		struct seg_entry *se = get_seg_entry(sbi,
+				GET_SEGNO(sbi, blkaddr));
+		unsigned int offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
+
+		if (f2fs_test_bit(offset, se->discard_map))
+			return;
+
+		err = f2fs_issue_discard(sbi, blkaddr, 1);
+	}
+
+	if (err) {
 		struct page *page = grab_meta_page(sbi, blkaddr);
 		/* zero-filled page */
 		set_page_dirty(page);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
