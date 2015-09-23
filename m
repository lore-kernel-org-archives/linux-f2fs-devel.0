From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix incorrect bimodal calculation
Date: Wed, 23 Sep 2015 09:25:43 +0800
Message-ID: <010701d0f59e$dcc573b0$96505b10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZeYpP-0002u1-9v
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 01:26:35 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZeYpN-0002Hn-E6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 01:26:35 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NV300LASVXE3TC0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 10:26:25 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In update_sit_info, we use div_u64 to handle 'u64 divide u64' case, but
div_u64 can only handle 32-bits divisor, so our divisor with u64 type
passed to div_u64 will overflow, result in the wrong calculation when
show debug info of f2fs as below:

BDF: 464, avg. vblocks: 23509
(BDF should never exceed 100)

So change to use div64_u64 to handle this case correctly.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ebfcc40..615a307 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -118,7 +118,7 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 		}
 	}
 	dist = div_u64(MAIN_SECS(sbi) * hblks_per_sec * hblks_per_sec, 100);
-	si->bimodal = div_u64(bimodal, dist);
+	si->bimodal = div64_u64(bimodal, dist);
 	if (si->dirty_count)
 		si->avg_vblocks = div_u64(total_vblocks, ndirty);
 	else
-- 
2.5.2



------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
