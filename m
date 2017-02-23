From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: much larger batched trim_fs job
Date: Wed, 22 Feb 2017 20:28:48 -0800
Message-ID: <20170223042850.43456-2-jaegeuk@kernel.org>
References: <20170223042850.43456-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cgl1Z-0008UC-GL
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 04:29:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cgl1Y-0003fi-ON
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 04:29:01 +0000
In-Reply-To: <20170223042850.43456-1-jaegeuk@kernel.org>
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

We have a kernel thread to issue discard commands, so we can increase the
number of batched discard sections. By default, now it becomes 4GB range.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5f3fe97df055..8f3171f12fa5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -128,7 +128,7 @@ enum {
 	CP_DISCARD,
 };
 
-#define DEF_BATCHED_TRIM_SECTIONS	2
+#define DEF_BATCHED_TRIM_SECTIONS	2048
 #define BATCHED_TRIM_SEGMENTS(sbi)	\
 		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
 #define BATCHED_TRIM_BLOCKS(sbi)	\
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
