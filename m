From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 2/4] f2fs-tools: fix endianness of on-disk
	check_sum in summary_footer
Date: Sat, 30 Jan 2016 09:16:37 +0000
Message-ID: <1454145399-30713-3-git-send-email-shengyong1@huawei.com>
References: <1454145399-30713-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1aPKQN-0002uf-NG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:34:03 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aPKQJ-0002OE-EB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:34:03 +0000
In-Reply-To: <1454145399-30713-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao2.yu@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 include/f2fs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 2ab9f49..1b02d16 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -677,7 +677,7 @@ struct f2fs_summary {
 
 struct summary_footer {
 	unsigned char entry_type;	/* SUM_TYPE_XXX */
-	__u32 check_sum;		/* summary checksum */
+	__le32 check_sum;		/* summary checksum */
 } __attribute__((packed));
 
 #define SUM_JOURNAL_SIZE	(F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
