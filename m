From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: avoid hungtask problem caused by losing
	wake_up
Date: Tue, 23 Feb 2016 12:07:56 +0800
Message-ID: <1456200476-9811-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aY4Ec-0008Ov-OI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 04:06:02 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aY4EY-0000XS-TA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 04:06:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Biao He <hebiao6@huawei.com>

The D state of wait_on_all_pages_writeback should be waken by
function f2fs_write_end_io when all writeback pages have been
succesfully written to device. It's possible that wake_up comes
between get_pages and io_schedule. Maybe in this case it will
lost wake_up and still in D state even if all pages have been
write back to device, and finally, the whole system will be into
the hungtask state.

                if (!get_pages(sbi, F2FS_WRITEBACK))
                         break;
					<---------  wake_up
                io_schedule();

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Biao He <hebiao6@huawei.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2bac8a1..f55355d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -920,7 +920,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 		if (!get_pages(sbi, F2FS_WRITEBACK))
 			break;
 
-		io_schedule();
+		io_schedule_timeout(5*HZ);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
 }
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
