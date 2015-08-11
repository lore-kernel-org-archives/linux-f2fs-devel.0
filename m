From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: skip checkpoint if there is no dirty
	segments
Date: Mon, 10 Aug 2015 18:23:25 -0700
Message-ID: <1439256205-8906-2-git-send-email-jaegeuk@kernel.org>
References: <1439256205-8906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZOyHx-0005AT-B1
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:23:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZOyHw-0003jl-Mg for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:23:37 +0000
In-Reply-To: <1439256205-8906-1-git-send-email-jaegeuk@kernel.org>
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

We should avoid wrong checkpoints when there is no dirty segments.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fcb263a..c4ed116 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -809,13 +809,14 @@ gc_more:
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto stop;
 
+	if (!__get_victim(sbi, &segno, gc_type))
+		goto stop;
+
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, nfree)) {
 		gc_type = FG_GC;
 		write_checkpoint(sbi, &cpc);
 	}
 
-	if (!__get_victim(sbi, &segno, gc_type))
-		goto stop;
 	ret = 0;
 
 	/* readahead multi ssa blocks those have contiguous address */
-- 
2.1.1


------------------------------------------------------------------------------
