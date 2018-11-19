From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 2/2] f2fs: Set CP_ERROR_FLAG in case of
 inconsistent node page entries
Date: Mon, 19 Nov 2018 11:32:57 +0530
Message-ID: <1542607377-25446-2-git-send-email-riteshh@codeaurora.org>
References: <1542607377-25446-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <riteshh@codeaurora.org>) id 1gOcea-0000Lr-U9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:03:24 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gOceY-00Dfhi-Q6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 06:03:24 +0000
In-Reply-To: <1542607377-25446-1-git-send-email-riteshh@codeaurora.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com

In case of any inconsistent node page entries found,
call f2fs_stop_checkpoint to further avoid any corruption.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 fs/f2fs/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d338740..29b56ef 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1369,6 +1369,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 			ofs_of_node(page), cpver_of_node(page),
 			next_blkaddr_of_node(page));
 		err = -EINVAL;
+		f2fs_stop_checkpoint(sbi, false);
 out_err:
 		ClearPageUptodate(page);
 		f2fs_put_page(page, 1);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
