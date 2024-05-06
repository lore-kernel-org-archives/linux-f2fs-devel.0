Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3DCC10F16
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 May 2024 10:42:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s3vnp-0000cE-9q;
	Mon, 06 May 2024 10:42:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s3vnd-0000bZ-7O
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 May 2024 10:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bFtObBWWpAaEThNan5FYnmr0TnSmuoc3FKrd0rPupJU=; b=RU0W7X61lMMtms2NkUWhMCnO7e
 ctwnqgvpzFKHHnE8idq5QlnhnaVbqAyFGQClaoWAL4g92fCD+u/XSr0Zae5GDnd6ZBbysZXiG6LI6
 a7DOZZ4eUwmzmRen7ccE9I8TNL323Z+ElDxtfl6GRYxR7uGM/nOQMlY8yENPM1st9Zbg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bFtObBWWpAaEThNan5FYnmr0TnSmuoc3FKrd0rPupJU=; b=IgIr7f+4nY9YK4wdW082/FCun4
 WJlA3HZV4QjLELj6I469pgAPYbDAoiKWwBjNFQDraQO4hxAvOyBlCoAGs+yik3SBmeOabAdlqc+ZI
 m/BBvoSqJWew2sGzIuFbHPrSfPYa7UHh3kG4ODurhUM/ZKd44MTrbZERe8SMT9jTJtOE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s3vnc-0004o8-Sp for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 May 2024 10:42:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7DD3A6109E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  6 May 2024 10:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138FDC4AF66;
 Mon,  6 May 2024 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714992134;
 bh=h2cJ8DiDTvOHVXuqiLQoZiz/U51rJ58bz1v/ndbDMNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BiOxEnJ1khv7+Zae5sAhEAsn2ZDIc9Ye9P28fYz4pEatNLYbUaHZRWSQwOeayJsuO
 3ON/Fn6RgX2LR295sTaNE53iuE8Wxdki7jx3y/GvNzpJRvcIFDtRCG6HH+e1pcB4s3
 tOech77POBhS4mtwrZ/hU617xqruqq8zLlFwYyiXbh1V6YsT//8UuFKucEjLqgEa71
 C1JGpJs4ZXt9RHyGFZErXZAHNWpBjUcvIjNTGTNSqn/CMaKWGAYSJaYurkERH5L0vX
 WT5wBhGOi8nPKmRL2MQIHb7/F7Yv7nu7edzCPcwzCM+O7aZRoDRahlbFpK533EFzP0
 2Hj+mvEq2JVzw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon,  6 May 2024 18:41:39 +0800
Message-Id: <20240506104140.776986-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506104140.776986-1-chao@kernel.org>
References: <20240506104140.776986-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1s3vnc-0004o8-Sp
Subject: [f2fs-dev] [PATCH 4/5] f2fs: compress: fix to cover {reserve,
 release}_compress_blocks() w/ cp_rwsem lock
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

It needs to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
to avoid racing with checkpoint, otherwise, filesystem metadata including
blkaddr in dnode, inode fields and .total_valid_block_count may be
corrupted after SPO case.

Fixes: ef8d563f184e ("f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS")
Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e77e958a9f92..3f0db351e976 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3570,9 +3570,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3590,6 +3593,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -3742,9 +3747,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3762,6 +3770,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
