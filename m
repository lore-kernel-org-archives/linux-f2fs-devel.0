Return-Path: <SRS0=F/Dq=E7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA104C2D0E4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2020 00:25:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7354B206F7;
	Wed, 25 Nov 2020 00:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="F39IYjiB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fyLQ8WdA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJl8OkUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7354B206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1khicI-0005ag-Hm; Wed, 25 Nov 2020 00:25:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1khicH-0005aQ-2g
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Nov 2020 00:25:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NHhtqp3KgmqMWi3g0c0lrx8o2uYcVzshjaPStLB63A4=; b=F39IYjiB0of+4JMBpFM6KsqOKI
 FO0S2MmiQ2zJqrYlXApSWxc3TalnJR0clypWeszGFUpA0dqgNylfj9JgDpimwH+pAs/lh/37qh0p6
 hsHCgnRywlCN64TByyvrbiNY1z341RGZVxTJPYrDMSfLPVQxo/LhZq5W6HB1Fm/kT/7o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NHhtqp3KgmqMWi3g0c0lrx8o2uYcVzshjaPStLB63A4=; b=fyLQ8WdA5nC/gxqL/dfSCvPJvr
 e9LBOsKJyYPlo9RVd/qjNmsZZotTUF6a2VCx2t3dsrS+TrXE4Q3cJYHJVwq0hz9vPTNivomGNdU/Z
 EqSr2xQnRi+kIL9EKlqAy49iR8Bm/Ndu1U5gPIBYF8kqysm5yjb+pqJ9R94ptSjTOtlQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1khicE-002qML-Mo
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Nov 2020 00:25:01 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F2DB02151B;
 Wed, 25 Nov 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606263886;
 bh=rnYdUr37PtuJdOHsrO7sMu2HuLBhc/5UVpsjNmKp6y8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AJl8OkUGDWFwxrxlZqEpgv4PwMCU1rjl5L7p1rg/lZNBS90ofHleDkHoORna07IZH
 L4PwZP6J+7e4F/HrUuXir6oThE5TGXcT0nQplwrbj/sZESB+7UVh4fPV9Lswxl7DZb
 3Gx3DfYhqSUtcl/Z9Qd87ORSV1pWNXLhGd1ryKoM=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue, 24 Nov 2020 16:23:28 -0800
Message-Id: <20201125002336.274045-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125002336.274045-1-ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1khicE-002qML-Mo
Subject: [f2fs-dev] [PATCH 1/9] ext4: remove ext4_dir_open()
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Since encrypted directories can be opened without their encryption key
being available, and each readdir tries to set up the key, trying to set
up the key in ->open() too isn't really useful.

Just remove it so that directories don't need an ->open() method
anymore, and so that we eliminate a use of fscrypt_get_encryption_info()
(which I'd like to stop exporting to filesystems).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/dir.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ca50c90adc4c..16bfbdd5007c 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -616,13 +616,6 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 }
 
-static int ext4_dir_open(struct inode * inode, struct file * filp)
-{
-	if (IS_ENCRYPTED(inode))
-		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
-	return 0;
-}
-
 static int ext4_release_dir(struct inode *inode, struct file *filp)
 {
 	if (filp->private_data)
@@ -664,7 +657,6 @@ const struct file_operations ext4_dir_operations = {
 	.compat_ioctl	= ext4_compat_ioctl,
 #endif
 	.fsync		= ext4_sync_file,
-	.open		= ext4_dir_open,
 	.release	= ext4_release_dir,
 };
 
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
