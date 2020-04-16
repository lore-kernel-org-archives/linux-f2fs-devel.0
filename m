Return-Path: <SRS0=lWv/=6A=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA7C2BA2B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:39:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84256221F9;
	Thu, 16 Apr 2020 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="k/6dpzn6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="M/3feKnT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="04gKc2Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84256221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jPCEl-0004i1-Gl; Thu, 16 Apr 2020 21:39:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jPCEk-0004hp-6M
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Apr 2020 21:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OwlSj9NOLBz3ZRf95OZ7GN8J2B/TqXRBgwl8jPcRUvo=; b=k/6dpzn66xSDKZWiAltZDhaqCG
 b2zM8X0B8ZHlqQEscuVoepep9QeHKgCbIKXPBmKedFKI/Jod0HnVxzyiReTsjUKChbF0+nwveXMJW
 rqeziHG1FYzc5bF52vpXVDogRhJaHgum/JbI0iY6/6H/n0evpEYQZ1xoYPjQlRdbimmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OwlSj9NOLBz3ZRf95OZ7GN8J2B/TqXRBgwl8jPcRUvo=; b=M/3feKnTLYNba+rhV3QpKVlle8
 M5DWcGcTPnprdORPmuNHj0mTObXfBJQkjIr+saCh+A/DGY1nEMIILkNMoSIZ1Z9vk4X8yrhM8hIu3
 G81CnOMXsuGazhmvYEVSh2jKew1ZPjkY+ByUFjbRcNPnGB6PzvaxbvKg28soXDsD39w8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jPCEj-002MUK-2U
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Apr 2020 21:39:54 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9129A221F9;
 Thu, 16 Apr 2020 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587073186;
 bh=bAJ7IG5/b71ZJq7XUCtP+ZsmvedloImlFcwjFfbRD3I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=04gKc2LhfSMOyvKmKZq0SLEhPmPuEVxpwNkVjb1PKj/NKhrZHVMz//6eT5Ku9DZ/5
 DW5vSNZJFMMLiGOV8TZIDP7gwJR04xe73MuobgQE2DHQChQ5fKNwJ3yQwHsHpntTb+
 oSUrbcVDny+B15Ypf99H+KdTMJteynxzBR2w/mcY=
Date: Thu, 16 Apr 2020 14:39:46 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200416213946.GA196168@google.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
X-Headers-End: 1jPCEj-002MUK-2U
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
f2fs_write_data_page() returns EAGAIN.
Likewise dentry blocks, we can just bypass getting the lock, since quota
blocks are also maintained by checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 - fix multipage write case

 fs/f2fs/compress.c | 2 +-
 fs/f2fs/data.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df7b2d15eacde..faaa358289010 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -985,7 +985,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	if (!f2fs_trylock_op(sbi))
+	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
 		return -EAGAIN;
 
 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index accd28728642a..5c8d3823d7593 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2656,8 +2656,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 			f2fs_available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
-	/* Dentry blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode)) {
+	/* Dentry/quota blocks are controlled by checkpoint */
+	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 		goto done;
-- 
2.26.1.301.g55bc3eb7cb9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
