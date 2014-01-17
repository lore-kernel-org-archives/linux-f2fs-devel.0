From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: avoid f2fs_balance_fs call during pageout
Date: Fri, 17 Jan 2014 16:22:04 +0900
Message-ID: <1389943324-25582-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W43mG-0006Pg-Cg
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Jan 2014 07:23:40 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W43mE-00076o-Dk
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Jan 2014 07:23:40 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZJ007RZB74SAA0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Jan 2014 16:23:28 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch should resolve the following bug.

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
3.13.0-rc5.f2fs+ #6 Not tainted
---------------------------------------------------------
kswapd0/41 just changed the state of lock:
 (&sbi->gc_mutex){+.+.-.}, at: [<ffffffffa030503e>] f2fs_balance_fs+0xae/0xd0 [f2fs]
but this lock took another, RECLAIM_FS-READ-unsafe lock in the past:
 (&sbi->cp_rwsem){++++.?}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
Chain exists of:
  &sbi->gc_mutex --> &sbi->cp_mutex --> &sbi->cp_rwsem

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->cp_rwsem);
                               local_irq_disable();
                               lock(&sbi->gc_mutex);
                               lock(&sbi->cp_mutex);
  <Interrupt>
    lock(&sbi->gc_mutex);

 *** DEADLOCK ***

This bug is due to the f2fs_balance_fs call in f2fs_write_data_page.
If f2fs_write_data_page is triggered by wbc->for_reclaim via kswapd, it should
not call f2fs_balance_fs which tries to get a mutex grabbed by original syscall
flow.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 19ad066..e57bde0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -842,8 +842,10 @@ write:
 	else if (err)
 		goto redirty_out;
 
-	if (wbc->for_reclaim)
+	if (wbc->for_reclaim) {
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		need_balance_fs = false;
+	}
 
 	clear_cold_data(page);
 out:
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
