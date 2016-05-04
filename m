From: Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: shrink size of struct seg_entry
Date: Wed,  4 May 2016 23:19:48 +0800
Message-ID: <1462375188-6493-3-git-send-email-chao@kernel.org>
References: <1462375188-6493-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1axycr-0000BA-AK
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 May 2016 15:22:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axycp-0007bP-Hq
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 May 2016 15:22:09 +0000
In-Reply-To: <1462375188-6493-1-git-send-email-chao@kernel.org>
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

Restructure struct seg_entry to eliminate holes in it, after that,
in 32-bits machine, it reduces size from 32 bytes to 24 bytes; in
64-bits machine, it reduces size from 56 bytes to 40 bytes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 975c33d..7a756ff 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -158,16 +158,17 @@ struct victim_sel_policy {
 };
 
 struct seg_entry {
-	unsigned short valid_blocks;	/* # of valid blocks */
+	unsigned int type:6;		/* segment type like CURSEG_XXX_TYPE */
+	unsigned int valid_blocks:10;	/* # of valid blocks */
+	unsigned int ckpt_valid_blocks:10;	/* # of valid blocks last cp */
+	unsigned int padding:6;		/* padding */
 	unsigned char *cur_valid_map;	/* validity bitmap of blocks */
 	/*
 	 * # of valid blocks and the validity bitmap stored in the the last
 	 * checkpoint pack. This information is used by the SSR mode.
 	 */
-	unsigned short ckpt_valid_blocks;
-	unsigned char *ckpt_valid_map;
+	unsigned char *ckpt_valid_map;	/* validity bitmap of blocks last cp */
 	unsigned char *discard_map;
-	unsigned char type;		/* segment type like CURSEG_XXX_TYPE */
 	unsigned long long mtime;	/* modification time of the segment */
 };
 
-- 
2.7.2


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
