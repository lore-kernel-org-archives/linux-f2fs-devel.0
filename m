From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/12] f2fs: remove wrong f2fs_bug_on when
	merging extents
Date: Mon, 29 Jun 2015 11:39:28 -0700
Message-ID: <1435603176-63219-4-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyW-0004Ci-1l
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dyV-0005Hj-Al for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:12 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
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

In f2fs_update_extent_tree, if there is existing extent, f2fs tries to split
it with two parts.
In each trial, __insert_extent_tree checks __is_front/back_mergeable, and then
if it hits to go, there is f2fs_bug_on(!den), which triggers a kernel panic.

Actually, we don't need to check this. Instead, we can do __try_back_merge only
when there exists a den pointer.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9bedfa8..7817167 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -519,19 +519,19 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 
 		if (ei->fofs < en->ei.fofs) {
 			if (__is_front_mergeable(ei, &en->ei)) {
-				f2fs_bug_on(sbi, !den);
 				en->ei.fofs = ei->fofs;
 				en->ei.blk = ei->blk;
 				en->ei.len += ei->len;
-				*den = __try_back_merge(sbi, et, en);
+				if (den)
+					*den = __try_back_merge(sbi, et, en);
 				return en;
 			}
 			p = &(*p)->rb_left;
 		} else if (ei->fofs >= en->ei.fofs + en->ei.len) {
 			if (__is_back_mergeable(ei, &en->ei)) {
-				f2fs_bug_on(sbi, !den);
 				en->ei.len += ei->len;
-				*den = __try_front_merge(sbi, et, en);
+				if (den)
+					*den = __try_front_merge(sbi, et, en);
 				return en;
 			}
 			p = &(*p)->rb_right;
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
