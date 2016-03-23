From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/7] fsck.f2fs: set fix_on if error is detected
Date: Wed, 23 Mar 2016 13:41:19 -0700
Message-ID: <1458765681-24123-5-git-send-email-jaegeuk@kernel.org>
References: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aipax-0002XS-E6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aipaw-0007Ok-J7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:35 +0000
In-Reply-To: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

From: Sheng Yong <shengyong1@huawei.com>

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 93008a5..6058c4d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -244,6 +244,18 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 				config.fix_on = 1;
 			break;
 		}
+	} else {
+		/*
+		 * we can hit this in 3 situations:
+		 *  1. fsck -f, fix_on has already been set to 1 when
+		 *     parsing options;
+		 *  2. fsck -a && CP_FSCK_FLAG is set, fix_on has already
+		 *     been set to 1 when checking CP_FSCK_FLAG;
+		 *  3. fsck -p 1 && error is detected, then bug_on is set,
+		 *     we set fix_on = 1 here, so that fsck can fix errors
+		 *     automatically
+		*/
+		config.fix_on = 1;
 	}
 
 	fsck_chk_orphan_node(sbi);
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
