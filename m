Return-Path: <SRS0=U0XC=WK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD475C0650F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Aug 2019 08:44:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CE32083B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Aug 2019 08:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TL1/fIwq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="h2A5Qn0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CE32083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hxotr-0000UX-51; Wed, 14 Aug 2019 08:44:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hxoto-0000Tj-OO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Aug 2019 08:44:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/lKh9WqKrjaVcBPQUVPr2WspG4qK9EtPHTL36rwqRh0=; b=TL1/fIwqz0JtOQkjPKMOkKXMjm
 nlEp8b0d6hFnhjos3DvCzloMkZLmseqTPuns8CaYlrZvz6s0yFSF1L8mEb/sCXJ1V4FywmSSrqzCx
 cxJw5L7cEiM+In4eB1PdOU0cEp4OU8UGCMw72ILb5i5c/Yg4rvtZ6wz+6Ki8XQc3djAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/lKh9WqKrjaVcBPQUVPr2WspG4qK9EtPHTL36rwqRh0=; b=h
 2A5Qn0CvhjhGn+91d1Vo2SydAIhj7hd9U1qviXuz/S3NKCXMm7tpTZce130ueYNHz1AEnzCwQO4xU
 tAS3waarVsRxgcviUim0RQ86v+0/WFdGbvXTSXPa65abEUh2QkAoQ+OaSn9cBadb7U8J3psoPVMPs
 LNHa7Lo/SVUXIWw4=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hxotm-003htP-VH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Aug 2019 08:44:52 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0546BE46BB395198017F;
 Wed, 14 Aug 2019 16:44:44 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 16:44:35 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Wed, 14 Aug 2019 16:44:26 +0800
Message-ID: <20190814084426.68522-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1hxotm-003htP-VH
Subject: [f2fs-dev] [PATCH v2 1/4] fsck.f2fs: fix to recover out-of-border
 inline size
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It tries to let fsck be noticed wrong inline size, and do the fix.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- skip normal case if i_size equals to zero.
 fsck/fsck.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index d53317c..baeca88 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -771,6 +771,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	ofs = get_extra_isize(node_blk);
 
 	if ((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
+		unsigned int inline_size = MAX_INLINE_DATA(node_blk);
+
 		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
 			/* should fix this bug all the time */
 			FIX_MSG("inline_data has wrong 0'th block = %x",
@@ -779,6 +781,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
 			need_fix = 1;
 		}
+		if (i_size > inline_size) {
+			node_blk->i.i_size = cpu_to_le64(inline_size);
+			FIX_MSG("inline_data has wrong i_size %lu",
+						(unsigned long)i_size);
+			need_fix = 1;
+		}
 		if (!(node_blk->i.i_inline & F2FS_DATA_EXIST)) {
 			char buf[MAX_INLINE_DATA(node_blk)];
 			memset(buf, 0, MAX_INLINE_DATA(node_blk));
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
