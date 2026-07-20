Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487F8C44528
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4RnHRJr4JtXHMq1c6SKWvWOwngl+nYG1i2sFcboZHk=; b=kbmbH5cwq+l9ye8uPaU/J5p1C+
	X2RJJYhxqEkE8OZmv18lUYGNe62SzC2vaznaT8268mmxLsSr1G6x78yJ9CarIdg2UIlTchTLL1BBc
	dicMlojIDxvg5y5hf9RCzAnJBB7Tcmtajaka0LttBkp7o/9kTqkV1fzV/LNL198gUZrw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljwD-0006go-9X;
	Mon, 20 Jul 2026 09:05:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljwA-0006gU-Ip
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=; b=Ke94pikMgi5ph4xTWVyYLS6x42
 Vi85mvkdcbuKnD2RXWxekMqQWqiPXN3UduKWwLuE6gF8Dq7fvgjuHKW1PVrrgxT10v9K98auTMur6
 gOz8D7E7cDsJcI3bcXTheWtSKdT/19lYIgyQnp6qqHdX/yxSQvZhbx/emDWgbgVlUW0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=; b=EUqXDTzVUnpLeO3OZlarGo1CXG
 i3rP1ieZgoa2S7wvAUd1Vuv+NAYygRsReRFye3xE3jJJFdhZY7T7WMpDqQSqIlYjkY5wPlEtG3K+B
 NBPn31C8xxbUuj9sZg4LKIRbuHe5T0xa8a4UOZ4ItOKe2L8hbe9H4kdNZTh3Fj4RFy3w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljwA-000873-Qi for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89C0A43A64;
 Mon, 20 Jul 2026 09:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19731F000E9;
 Mon, 20 Jul 2026 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538312;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AVW1dtxShDB7yvxNE2U1Xk8Tx8XDX8xkJi7Wvpt5y8Dstpsy50aKDpEI4+xRAReaj
 Z+fXJqPvkfF25zDXimvrFQK8mVX8oyxQEHnFa8JPyHRpdgMh57TlaMkSL3rAhNdh12
 XZHDp/EHkoDmWkE6dBcAZH9JRGX3sVJIfUbYCbZzwbkG4PR93JgCqWNWepe5piKDcm
 SG7nmtLxPdTHhOs0+D+KMdE66mu3BeLZgq59ast5siiF6P1zBwy/DRlsnCUExNeo/q
 kY/AM9aFxxVxAtdCBy3H6jea5mbvVgCmpVOScQxO+y8ZBIRFnl7kzFKsT4HSkwEqg/
 TlKuCh+znfTfw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:34 +0200
Message-ID: <20260720090410.3487990-7-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljwA-000873-Qi
Subject: [f2fs-dev] [PATCH v12 06/21] fsverity: don't allow setting DAX file
 attribute on fsverity files
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

When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
it checks if file has DAX enabled and fails if that's true. However, the
opposite case is not checked.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index bfb00d256dd5..5424ec4e3949 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -246,6 +246,11 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (fa->fsx_cowextsize == 0)
 		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
 
+	/* Can not enable DAX on fsverity file */
+	if ((old_ma->fsx_xflags & FS_XFLAG_VERITY) &&
+			fa->fsx_xflags & FS_XFLAG_DAX)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
