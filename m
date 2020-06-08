Return-Path: <SRS0=UwVw=7V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF4C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A6C2072F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="A9Ak189/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Vb4px1/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A6C2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jiGT7-000724-Qz; Mon, 08 Jun 2020 12:01:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jiGT6-00071a-6i
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 12:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xtQYCImvDP8v2YdxGcUD8i8NMvDQ8UUiyRviLPjUwIM=; b=A9Ak189/dO+WvpMTj+vFYdxZvp
 ZJXZMBHTEwbddV1nnXLIC/9kE9+g9I0ZLAdlniGtnT066ko4ychSLjj4dvLOURjG+SiSckLrL7e7X
 kREQP0Xvht+koqEQsP5HuFQiJhg14W7cj4RP3WLA5Wtq5WAPTVbv2Snzj0TjCebO0NJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xtQYCImvDP8v2YdxGcUD8i8NMvDQ8UUiyRviLPjUwIM=; b=V
 b4px1/Oalv8RuQRCzlx8AE6dFLf9oF0U1LsY/JBDWkLGfvNFwHq3Jy51iCVSiU9uDQ/nsY4WN6KLQ
 X8gv8wZ+cDvKEzAHKWVLuyhOFhsow1rtMkDLtCWwLdeJrs5VL5SL13OYMIIQTN/IjkBZxQJPRHwbl
 ukpg6D6p9Czv5e1k=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jiGT2-00GOcm-Ob
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 12:01:32 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E392661657CC450BC7D6;
 Mon,  8 Jun 2020 20:01:15 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 8 Jun 2020 20:01:09 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Mon, 8 Jun 2020 20:01:07 +0800
Message-ID: <20200608120107.6336-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jiGT2-00GOcm-Ob
Subject: [f2fs-dev] [PATCH v2] f2fs: allow writeback on error status
 filesystem
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

    71.07%     0.01%  kworker/u256:1+  [kernel.kallsyms]  [k] wb_writeback
            |
             --71.06%--wb_writeback
                       |
                       |--68.96%--__writeback_inodes_wb
                       |          |
                       |           --68.95%--writeback_sb_inodes
                       |                     |
                       |                     |--65.08%--__writeback_single_inode
                       |                     |          |
                       |                     |           --64.35%--do_writepages
                       |                     |                     |
                       |                     |                     |--59.83%--f2fs_write_node_pages
                       |                     |                     |          |
                       |                     |                     |           --59.74%--f2fs_sync_node_pages
                       |                     |                     |                     |
                       |                     |                     |                     |--27.91%--pagevec_lookup_range_tag
                       |                     |                     |                     |          |
                       |                     |                     |                     |           --27.90%--find_get_pages_range_tag

If filesystem was injected checkpoint errror, before umount, kworker will
always hold one core in order to writeback a large number of node pages,
that looks not reasonable, to avoid that, we can allow data/node write in
such case, since we can force all data/node writes with OPU mode, and
clear recovery flag on node, and checkpoint is not allowed as well, so we
don't need to worry about writeback's effect on data/node in previous
checkpoint, then with this way, it can decrease memory footprint cost by
node/data pages and avoid looping into data/node writeback process.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  7 +++++++
 fs/f2fs/data.c       | 22 +++++++++++++++-------
 fs/f2fs/node.c       |  7 +++++--
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 236064930251..1bb8278a1c4a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1238,6 +1238,13 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		goto retry_flush_nodes;
 	}
 
+	if (unlikely(f2fs_cp_error(sbi))) {
+		up_write(&sbi->node_write);
+		up_write(&sbi->node_change);
+		f2fs_unlock_all(sbi);
+		return -EIO;
+	}
+
 	/*
 	 * sbi->node_change is used only for AIO write_begin path which produces
 	 * dirty node blocks and some checkpoint values by block allocation.
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 267b5e76a02b..808e7734db19 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2508,6 +2508,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
+	if (unlikely(f2fs_cp_error(sbi)))
+		return true;
 	if (f2fs_lfs_mode(sbi))
 		return true;
 	if (S_ISDIR(inode->i_mode))
@@ -2691,13 +2693,19 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
-		/*
-		 * don't drop any dirty dentry pages for keeping lastest
-		 * directory structure.
-		 */
-		if (S_ISDIR(inode->i_mode))
-			goto redirty_out;
-		goto out;
+
+		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE))
+			goto out;
+
+		if (has_not_enough_free_secs(sbi, 0, 0)) {
+			/*
+			 * don't drop any dirty dentry pages for keeping lastest
+			 * directory structure.
+			 */
+			if (S_ISDIR(inode->i_mode))
+				goto redirty_out;
+			goto out;
+		}
 	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 03e24df1c84f..372c04efad38 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1527,7 +1527,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 			unlock_page(page);
 			return 0;
 		}
-		goto redirty_out;
+		if (has_not_enough_free_secs(sbi, 0, 0))
+			goto redirty_out;
+		set_fsync_mark(page, 0);
+		set_dentry_mark(page, 0);
 	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
@@ -1568,7 +1571,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		goto redirty_out;
 	}
 
-	if (atomic && !test_opt(sbi, NOBARRIER))
+	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_cp_error(sbi))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
 	/* should add to global list before clearing PAGECACHE status */
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
