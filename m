From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/4] f2fs-tools: fix missing function declaration
Date: Tue, 30 Jul 2013 16:39:03 +0900
Message-ID: <1375169946-2887-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1V44YJ-0005pE-Bz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:03 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V44YH-0001R5-8g for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:03 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQQ00FQUO04FOQ0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 16:40:52 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Explicitly declare function name.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/fsck.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/fsck.h b/fsck/fsck.h
index a8f440c..94808b8 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -160,5 +160,6 @@ struct dump_option {
 extern void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit);
 extern void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa);
 extern int dump_node(struct f2fs_sb_info *sbi, nid_t nid);
+extern int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr);
 
 #endif /* _FSCK_H_ */
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
