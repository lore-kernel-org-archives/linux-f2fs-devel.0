Return-Path: <SRS0=CQ2X=4F=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACEEC35242
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:44:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867FA206E2;
	Mon, 17 Feb 2020 03:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="L4LWquLl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BlMivI03";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IrIuX18L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867FA206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j3XKS-0001ji-V8; Mon, 17 Feb 2020 03:44:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <bounce+103f7e.be9e4a-linux-f2fs-devel=lists.sourceforge.net@mg.codeaurora.org>)
 id 1j3XKR-0001ja-4l
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 Feb 2020 03:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oLwBoEwcv3fRTqQTxsGwQy5RClyVuVnp1M8eCRgAIbM=; b=L4LWquLl6+R6ddCB7DtwqVaKCN
 MiicKgWPe+mwMTe34Qp6XSwgEQH9hF+/la1IJYSzVIdbSL1zv6F1DbtehmHWZ9YQi7OdEPinYhaCf
 oKw7xfrfSYyHGxdPJNdfgt479FpMqpwSGFI/3MIlvWY1LEbX+RtndvW2ju7zcVZxalI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oLwBoEwcv3fRTqQTxsGwQy5RClyVuVnp1M8eCRgAIbM=; b=BlMivI03YNhG/5yOD/CoO4eBud
 4PdSMVkHvSRDl8/66woh/Ii5phAdK9YsdllaKCrDpOdZ2i2nLOzO1iki0YmhQMnw5+gxJjXEBT5wU
 611Y30lcMhG11/Kzxegq6NjVidhPE4ToNTeMr7LfqB/ulFtt2Gml3qrIWKZTjhjfZwfM=;
Received: from mail26.static.mailgun.info ([104.130.122.26])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1j3XKI-005lor-Iv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 Feb 2020 03:44:15 +0000
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1581911046; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oLwBoEwcv3fRTqQTxsGwQy5RClyVuVnp1M8eCRgAIbM=;
 b=IrIuX18LJH7kM5rwhgZ5tGTr+C1oxk+KcaKN8P9uRTjraGIAJItz14UhyQAZEKbNa4fmocHY
 Ws+GOHy83ealyrw6sEZhTLK+/DDWVqLbw8/GuQHJwd75A+1gClO24jYfXbKfNn+SOs31ywq6
 dIwjLawNFCFz7U0kdT3kHbyX+jU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI2M2Y4ZiIsICJsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldCIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a0bff.7fd95daab260-smtp-out-n02;
 Mon, 17 Feb 2020 03:43:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id F2428C4479C; Mon, 17 Feb 2020 03:43:58 +0000 (UTC)
Received: from codeaurora.org
 (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: stummala)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E334C43383;
 Mon, 17 Feb 2020 03:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E334C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=stummala@codeaurora.org
From: Sahitya Tummala <stummala@codeaurora.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 17 Feb 2020 09:13:44 +0530
Message-Id: <1581911024-23660-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-Headers-End: 1j3XKI-005lor-Iv
Subject: [f2fs-dev] [PATCH V2] f2fs: fix the panic in do_checkpoint()
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
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

There could be a scenario where f2fs_sync_meta_pages() will not
ensure that all F2FS_DIRTY_META pages are submitted for IO. Thus,
resulting in the below panic in do_checkpoint() -

f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
				!f2fs_cp_error(sbi));

This can happen in a low-memory condition, where shrinker could
also be doing the writepage operation (stack shown below)
at the same time when checkpoint is running on another core.

schedule
down_write
f2fs_submit_page_write -> by this time, this page in page cache is tagged
			as PAGECACHE_TAG_WRITEBACK and PAGECACHE_TAG_DIRTY
			is cleared, due to which f2fs_sync_meta_pages()
			cannot sync this page in do_checkpoint() path.
f2fs_do_write_meta_page
__f2fs_write_meta_page
f2fs_write_meta_page
shrink_page_list
shrink_inactive_list
shrink_node_memcg
shrink_node
kswapd

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
- changed the io_schedule_timeout to HZ/50.

 fs/f2fs/checkpoint.c | 18 +++++++++---------
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/super.c      |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ffdaba0..d5601cc 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1250,20 +1250,20 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
 	f2fs_unlock_all(sbi);
 }
 
-void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
+void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 {
 	DEFINE_WAIT(wait);
 
 	for (;;) {
 		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		if (!get_pages(sbi, F2FS_WB_CP_DATA))
+		if (!get_pages(sbi, type))
 			break;
 
 		if (unlikely(f2fs_cp_error(sbi)))
 			break;
 
-		io_schedule_timeout(5*HZ);
+		io_schedule_timeout(HZ/50);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
 }
@@ -1384,8 +1384,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Flush all the NAT/SIT pages */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
-	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
-					!f2fs_cp_error(sbi));
+	/* Wait for all dirty meta pages to be submitted for IO */
+	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
 
 	/*
 	 * modify checkpoint
@@ -1493,11 +1493,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
-	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
-					!f2fs_cp_error(sbi));
+	/* Wait for all dirty meta pages to be submitted for IO */
+	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
 
 	/* wait for previous submitted meta pages writeback */
-	f2fs_wait_on_all_pages_writeback(sbi);
+	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
 	/* flush all device cache */
 	err = f2fs_flush_device_cache(sbi);
@@ -1506,7 +1506,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* barrier and flush checkpoint cp pack 2 page if it can */
 	commit_checkpoint(sbi, ckpt, start_blk);
-	f2fs_wait_on_all_pages_writeback(sbi);
+	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
 	/*
 	 * invalidate intermediate page cache borrowed from meta inode
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a0..b0e0535 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3196,7 +3196,7 @@ bool f2fs_is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 void f2fs_update_dirty_page(struct inode *inode, struct page *page);
 void f2fs_remove_dirty_inode(struct inode *inode);
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
-void f2fs_wait_on_all_pages_writeback(struct f2fs_sb_info *sbi);
+void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type);
 int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi);
 int __init f2fs_create_checkpoint_caches(void);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5111e1f..084633b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1105,7 +1105,7 @@ static void f2fs_put_super(struct super_block *sb)
 	/* our cp_error case, we can wait for any writeback page */
 	f2fs_flush_merged_writes(sbi);
 
-	f2fs_wait_on_all_pages_writeback(sbi);
+	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
