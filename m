From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: inject fault in inc_valid_node_count
Date: Mon, 13 Nov 2017 17:32:40 +0800
Message-ID: <20171113093240.47560-2-yuchao0@huawei.com>
References: <20171113093240.47560-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eEB7k-0005oe-PA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Nov 2017 09:33:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eEB7g-0004WB-U1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Nov 2017 09:33:48 +0000
In-Reply-To: <20171113093240.47560-1-yuchao0@huawei.com>
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

This patch adds missing fault injection in inc_valid_node_count.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5c379a8ea075..22b81bbb056f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1765,6 +1765,13 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 			return ret;
 	}
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(sbi, FAULT_BLOCK)) {
+		f2fs_show_injection_info(FAULT_BLOCK);
+		goto enospc;
+	}
+#endif
+
 	spin_lock(&sbi->stat_lock);
 
 	valid_block_count = sbi->total_valid_block_count + 1;
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
