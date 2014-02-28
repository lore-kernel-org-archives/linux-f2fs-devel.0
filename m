From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix dirty page accounting when redirty
Date: Fri, 28 Feb 2014 10:12:05 +0800
Message-ID: <000001cf342a$95864830$c092d890$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WJCwm-0001mg-P0
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Feb 2014 02:13:08 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WJCwk-0008FS-UM
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Feb 2014 02:13:08 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N1O00NKQOTL1B20@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Feb 2014 11:12:57 +0900 (KST)
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

We should de-account dirty counters for page when redirty in ->writepage().

Wu Fengguang described in 'commit 971767caf632190f77a40b4011c19948232eed75':
"writeback: fix dirtied pages accounting on redirty
De-account the accumulative dirty counters on page redirty.

Page redirties (very common in ext4) will introduce mismatch between
counters (a) and (b)

a) NR_DIRTIED, BDI_DIRTIED, tsk->nr_dirtied
b) NR_WRITTEN, BDI_WRITTEN

This will introduce systematic errors in balanced_rate and result in
dirty page position errors (ie. the dirty pages are no longer balanced
around the global/bdi setpoints)."

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |    1 +
 fs/f2fs/data.c       |    1 +
 fs/f2fs/node.c       |    1 +
 3 files changed, 3 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c8516ee..f069249 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -178,6 +178,7 @@ no_write:
 redirty_out:
 	dec_page_count(sbi, F2FS_DIRTY_META);
 	wbc->pages_skipped++;
+	account_page_redirty(page);
 	set_page_dirty(page);
 	return AOP_WRITEPAGE_ACTIVATE;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 93d80ea..101b4cd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -839,6 +839,7 @@ out:
 
 redirty_out:
 	wbc->pages_skipped++;
+	account_page_redirty(page);
 	set_page_dirty(page);
 	return AOP_WRITEPAGE_ACTIVATE;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1f9cf21..8c14110 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1193,6 +1193,7 @@ static int f2fs_write_node_page(struct page *page,
 redirty_out:
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
 	wbc->pages_skipped++;
+	account_page_redirty(page);
 	set_page_dirty(page);
 	return AOP_WRITEPAGE_ACTIVATE;
 }
-- 
1.7.9.5


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
