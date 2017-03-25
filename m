From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: start SSR much eariler to avoid FG_GC
Date: Sat, 25 Mar 2017 00:59:32 -0700
Message-ID: <20170325075933.21072-4-jaegeuk@kernel.org>
References: <20170325075933.21072-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1crgc4-00033J-Em
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1crgc3-0001LH-QQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:52 +0000
In-Reply-To: <20170325075933.21072-1-jaegeuk@kernel.org>
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

This patch initiates SSR much eariler, resulting in less FG_GC.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 4d0dd9f7f4ed..57e36c1ce7bd 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -495,7 +495,7 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
 		return false;
 
 	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
-						reserved_sections(sbi) + 1);
+						2 * reserved_sections(sbi));
 }
 
 static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
