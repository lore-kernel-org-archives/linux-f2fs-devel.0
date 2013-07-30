From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 3/4] f2fs-tools: use either hex or decimal options
Date: Tue, 30 Jul 2013 16:39:05 +0900
Message-ID: <1375169946-2887-3-git-send-email-cm224.lee@samsung.com>
References: <1375169946-2887-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1V44YM-0006Fi-JA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:06 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V44YL-0001R5-Kn for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 07:41:06 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQQ00KKHO05G2N0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jul 2013 16:40:54 +0900 (KST)
In-reply-to: <1375169946-2887-1-git-send-email-cm224.lee@samsung.com>
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

This patch supports both hex and decimal when using nid as option.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/main.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index d72533d..60bebc2 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -76,7 +76,10 @@ void f2fs_parse_options(int argc, char *argv[])
 					MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
 					break;
 				case 'i':
-					sscanf(optarg, "%x", &dump_opt.nid);
+					if (strncmp(optarg, "0x", 2))
+						sscanf(optarg, "%d", &dump_opt.nid);
+					else
+						sscanf(optarg, "%x", &dump_opt.nid);
 					break;
 				case 's':
 					sscanf(optarg, "%d~%d", &dump_opt.start_sit, &dump_opt.end_sit);
@@ -85,7 +88,10 @@ void f2fs_parse_options(int argc, char *argv[])
 					sscanf(optarg, "%d~%d", &dump_opt.start_ssa, &dump_opt.end_ssa);
 					break;
 				case 'b':
-					sscanf(optarg, "%d", &dump_opt.blk_addr);
+					if (strncmp(optarg, "0x", 2))
+						sscanf(optarg, "%d", &dump_opt.blk_addr);
+					else
+						sscanf(optarg, "%x", &dump_opt.blk_addr);
 					break;
 				default:
 					MSG(0, "\tError: Unknown option %c\n", option);
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
