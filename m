From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix incorrect range->len in
 f2fs_trim_fs()
Date: Sun,  5 Aug 2018 23:09:00 +0800
Message-ID: <20180805150900.9941-2-chao@kernel.org>
References: <20180805150900.9941-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fmKfR-0004Xd-Pt
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Aug 2018 15:10:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fmKfQ-00ACJI-DV
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Aug 2018 15:10:01 +0000
In-Reply-To: <20180805150900.9941-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
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

generic/260 reported below error:

     [+] Default length with start set (should succeed)
     [+] Length beyond the end of fs (should succeed)
     [+] Length beyond the end of fs with start set (should succeed)
    +./tests/generic/260: line 94: [: 18446744073709551615: integer expression expected
    +./tests/generic/260: line 104: [: 18446744073709551615: integer expression expected
     Test done
    ...

In f2fs_trim_fs(), if there is no discard being trimmed, we need to correct
range->len before return.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 24b7147456e9..7b470a1fe92b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2626,8 +2626,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 	trimmed += __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
-	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
+	if (!err)
+		range->len = F2FS_BLK_TO_BYTES(trimmed);
 	return err;
 }
 
-- 
2.18.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
