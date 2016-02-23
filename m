From: Junling Zheng <zhengjunling@huawei.com>
Subject: [RFC PATCH 1/2] libf2fs: limit the total size up to 16T
Date: Tue, 23 Feb 2016 21:43:41 +0800
Message-ID: <1456235022-31652-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1aYDQv-0000VN-Q4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 13:55:21 +0000
Received: from [119.145.14.66] (helo=szxga03-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aYDQu-0003zI-04
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 13:55:21 +0000
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

F2FS can support 16T bytes at most. Limit the config.total_sectors
so that most parameters calculated according to it in sb/cp can be
limited correctly too.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 lib/libf2fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5eb5c33..a8ad324 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -640,6 +640,11 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		c->total_sectors = wanted_total_sectors;
 
 	}
+	if (c->total_sectors * c->sector_size >
+		(u_int64_t)F2FS_MAX_SEGMENT * 2 * 1024 * 1024) {
+		MSG(0, "\tError: F2FS can support 16TB at most!!!\n");
+		return -1;
+	}
 	MSG(0, "Info: sector size = %u\n", c->sector_size);
 	MSG(0, "Info: total sectors = %"PRIu64" (%"PRIu64" MB)\n",
 				c->total_sectors, (c->total_sectors *
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
