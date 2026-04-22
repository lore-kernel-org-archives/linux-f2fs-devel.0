Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4097FAD3E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HK7rX8vSE8Wy9uRboT62LvrHbnSd4dFe1yrwFh3BMaE=; b=W2vH5kfB6VeVTRE3euWfSvWR8P
	hyLCUKjy4QTxpvYYalhKU9QOkpdoyX1mcJDXeUIKg9lqhdBD/20KyT4RsdG8n39bf1n5qkkhBvM/Z
	blA9E7NehvsJ1OiqsSc8zkttmpiLnUYjY1+bBRLU8HOyvpqjzKO9kr2GYDYaI2slDEn0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh1r-00048i-Dr;
	Wed, 22 Apr 2026 23:30:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh1p-00048Y-My
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JhxbOvG2k4fgYgI60mGqDgkb8IOcCWtA7jQRHRmgKwM=; b=gYHzXITQxH96mLICJ/uEIbFRmq
 PILh4i2B+/NXpW4CanE1Hyi2wwRu8OrOERT1V3/U3FgIyCCR1m5sRXjwwv7jBfeQtEIn8sVskQVdD
 Q0+L4qy8OJ0hAsiWdQOJ9BL2YrCYgIFI9CGXqjKWdVLiyuuSqkJRyCaRlZXlFXuAEScw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JhxbOvG2k4fgYgI60mGqDgkb8IOcCWtA7jQRHRmgKwM=; b=h6VtqyKIX/YzYOkkg7U/DoJ257
 UYRmioJmdxAuvxPTGAMirsmrK34CvPN1v6oUnlAHqx4ECmbqfmXULrZFfKeIQQZvKVCU1EV7OYj84
 XYtFVGDiX8Y8jxstTuRGkEJRmznlsG2UDH+7PJ4wYpINWeX5oi+/VkAmzYK6YhBZM7+c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh1o-0006dz-OB for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E07961863;
 Wed, 22 Apr 2026 23:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716FC19425;
 Wed, 22 Apr 2026 23:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900633;
 bh=PcroO5CweiTdfrAbvYqaLqKDeO9OE61yEag4vDGPG8Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=a3XdQt3Gn+AWljtg1JgKHnMFskrXRQkdifjAYtRnz3vVeVZq+OzHdNBzDPQmSd07t
 owTjiQgraE8bS26TcX2l1URUgEGWan2h6QFEIDXf1eSMIlulMsTE2MKWfBw7Gko6Ic
 OUq7QWVLi7rDV4OWz/UqvEyfR4upp76XBTUI+H5MweZ8DxmUMlrp9beGuSvQLpyXGD
 3qAgnhkys6dz7xmsqUlGWgREOf5SLeO9PGxZhj7ySoKDpKpe9xTJ/e22Swei4MxtNZ
 Gu88sQMedIr/++xFZj9gfbAkfbRtp2XqRmE+LdDyXbIHReBU6eMcCgpvXUzApcZlrS
 NzUrMNAaeJbsw==
Date: Wed, 22 Apr 2026 19:30:01 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-7-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=DsH9Ul/eRW+1BLm1emwHx7xWw9r+GnxZnlKzlLXX6Ts=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoF9zDZc9sCCBTCQGhgFXZOUxhLZqkiabRzh
 m2Dce5ZLVCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l7QQD/9NPdB+1IIja3d/pborFSqA2NE3c/tzM3HQaZsVQelKHPaLICOeBWaW4M1L7qVwHb+pR9C
 lDudkaTgbZ8PTRzTtCB47xQwT4WoeuaVyoHy3aAYytqPo2JYe/8ZkMib9uMNg8brK6L8qCZRlUt
 X6zWuNycOEJAkfNGyHRn0frVkzsKT5TY+rqxRP1vvLljxGysVsi7GN9wAXDYFtiE7rSH0imu+VU
 qG+9YSAwe9yiomEAoRcHwXfn3sYARNaKqVbWyNqbjyUVoICozcOvAzrYCbOc3posJTLN/JilYH+
 wWC6aLVqG9y5gMTYD4DqVhxiq/VaIUyGjMnFp8cWPd7MR+zx8YnVEXgqLkgBHTgbzOOvo8FrFHm
 Xn1vI8PQNHBT0MOTh0Xw40YO1cUG4Q3Qllu0Neo/mB6Wdaf52/z2AdCQiUsrIFVz91oTx0XLtql
 D3PYQJDJRrwNTWo7pRgxEMhVCDakfO59yt5aXSjdHPOiqW32a420yu6PRZKRkdi6s7LjaJguA/G
 YWxS8wZwyZcycHO/nagVb27/jJxJmueeeQicDaA2ynQfyh2WzcRpW5XDMbBUQU6B4QoxmJwAqIc
 Guqq0pW88+GuBS8FhBNXtr6tDk0xeIVb0qOafK6JQ2sJIlQkz/YVXo5FYrL2lAF8Zxt3aaY29bb
 BPOiedPDny3snbA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh1o-0006dz-OB
Subject: [f2fs-dev] [PATCH v9 07/17] hfsplus: Report case sensitivity in
 fileattr_get
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function via the FS_XFLAG_CASEFOLD flag. HFS+ always preserves case
at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d05891ec492e..ffbb57493d7b 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -740,6 +740,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -751,6 +752,15 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	/*
+	 * HFS+ always preserves case at rest. Standard HFS+ volumes
+	 * are case-insensitive; HFSX volumes may be either
+	 * case-sensitive or case-insensitive depending on how they
+	 * were formatted. HFSPLUS_SB_CASEFOLD is set in both
+	 * case-insensitive variants.
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
