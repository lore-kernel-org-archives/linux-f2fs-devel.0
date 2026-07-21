Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC5CC4452D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNpuYk7aNDetsFAWr3j6Er60iDY41aE4liJmMvO7r0M=; b=QFNVqKS1n2vfwrpjvGs8RiObCP
	C2VoLefBEvEVa67+rrcOxdO92eu4IY+i5X2gFGvtXyC/eS/xCijBzznGgYPHXXjZHwbIn40iMl2pv
	KKbOSdUkHOVw+/ukElMF6sKtl+cztv9RRtAmuKaV3wbrovxPc/D/s4hUmjuLYgm9/SFE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFS8-0003Jc-Ci;
	Tue, 21 Jul 2026 18:44:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFS6-0003JQ-H2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fmzb25jhZDNq4cfG2tBZE1WMkvl/GQ14vrzOhert9WY=; b=DoLptF+XmvG/T2hiLBn1bmwcuk
 YvDDruiV6ZfUI718hCiynVTdlzzj3qTvaVPFLZ4p3TZU+z5xz4hDoFD1X/szJocu+jGFr2jJlvEU1
 JGY37m5GBth8laxs0El9g74vQ3HenvPgHHib6VQjj4TBuLzUJ1TbdB/7NeucAj2+KxCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fmzb25jhZDNq4cfG2tBZE1WMkvl/GQ14vrzOhert9WY=; b=fPw8Nz/WitIQeDpo4fP34o3g+3
 ZKwxaXHqCVp6ATqMzt9ErhCuCrVn0yTVaWNJeUkpUq8nd70KAbuzv4ncVNjfps6up5kEHdvIQ8jco
 XTraFKdxFDg8z3VtIyem2gVorG/6rEgwBMQZFboTSkEjJbmYHgvkJzxKjPXcaraVOAIA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFS1-00030b-9S for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E85EE43B02;
 Tue, 21 Jul 2026 18:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A68A1F00A3D;
 Tue, 21 Jul 2026 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659455;
 bh=fmzb25jhZDNq4cfG2tBZE1WMkvl/GQ14vrzOhert9WY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MLQlBmiPCAKL5xe2t/n7HpcDOcLcgJwlpHxf4sTI6VxBgIvHsR70OO8uHlSHQUGYy
 mEsy+hk4m92M0PDm89kHugj+4Ao1Hxgd5DKDYcelZ1KBac9k6GegVm0eTaKlbwCvII
 svVjfJB7Mc/+QmhS/4vroeRbGnnoBgaDsXckoeIOrJ8KgXQt0/ChPQvmhEIaQvWdvX
 sRUImd4hme+VN8+QP8xQ9iqcvHQYpBz9vHrtoldSURXDXBml6DRzPo4nKXQprF14PT
 7GLRdsbpNB6h9oi/vGPZIZ1RpM7c5FJ/UEAyIp9pGji/B4Gbnkghc1batSR9eQf9X2
 22UWt867AzNbQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:44 +0200
Message-ID: <20260721184346.416657-8-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFS1-00030b-9S
Subject: [f2fs-dev] [PATCH v13 07/23] fs,
 fsverity: remove check for fsverity being enabled in
 setattr_prepare()
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The check that fs-verity is available in the kernel is not necessary
here. Filesystems could have fsverity files even without fs-verity
module, then truncate will succeed. Previously, this would return
EOPNOTSUPP if verity is missing, but if it's not EPERM was returned
anyway.

Fixes: e9734653c523 ("fs,fsverity: reject size changes on fsverity files in setattr_prepare")
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index 4f437fabb7f0..71888ac903c2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -176,7 +176,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * covered by the open-time check because sys_truncate() takes a
 		 * path, not an open file.
 		 */
-		if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		if (IS_VERITY(inode))
 			return -EPERM;
 
 		error = inode_newsize_ok(inode, attr->ia_size);
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
