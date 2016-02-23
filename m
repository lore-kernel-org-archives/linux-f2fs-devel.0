From: Junling Zheng <zhengjunling@huawei.com>
Subject: [RFC PATCH 2/2] f2fs-tools: redefine MAX_SIT_BITMAP_SIZE
Date: Tue, 23 Feb 2016 21:43:42 +0800
Message-ID: <1456235022-31652-2-git-send-email-zhengjunling@huawei.com>
References: <1456235022-31652-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1aYDQv-0000VS-Ts
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 13:55:21 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aYDQr-0002ql-SB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 13:55:21 +0000
In-Reply-To: <1456235022-31652-1-git-send-email-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao2.yu@samsung.com

During mkfs, segment_count_sit is calculated using ALIGN and
SEG_ALIGN, which are both upward. Then, in some extreme scenarios,
such as 16TB, sit_ver_bitmap_bytesize got from segment_count_sit
will exceed MAX_SIT_BITMAP_SIZE, which is calculated in a downward
method.

Unify the two calculating methods and redefine MAX_SIT_BITMAP_SIZE
to prevent sit_ver_bitmap_bytesize overflowing.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 include/f2fs_fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index b58aa74..3a1d2d1 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -642,7 +642,9 @@ struct f2fs_nat_block {
  * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
  */
 #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
-#define MAX_SIT_BITMAP_SIZE    ((F2FS_MAX_SEGMENT / SIT_ENTRY_PER_BLOCK) / 8)
+#define MAX_SIT_BITMAP_SIZE    (SEG_ALIGN(ALIGN(F2FS_MAX_SEGMENT, \
+						SIT_ENTRY_PER_BLOCK)) * \
+						config.blks_per_seg / 8)
 
 /*
  * Note that f2fs_sit_entry->vblocks has the following bit-field information.
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
