From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/5] f2fs: correct type of wait in struct
	bio_private
Date: Thu, 28 Nov 2013 15:41:39 +0800
Message-ID: <003201ceec0d$64b4e5f0$2e1eb1d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VlwFJ-00072M-CJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 07:42:45 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VlwFH-00021x-2K
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 07:42:45 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MWY00HG5QQXIOD0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Nov 2013 16:42:33 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b84dd23..5f733ec 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -96,7 +96,7 @@
 struct bio_private {
 	struct f2fs_sb_info *sbi;
 	bool is_sync;
-	void *wait;
+	struct completion *wait;
 };
 
 /*
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
