Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3661AC44506
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4RnHRJr4JtXHMq1c6SKWvWOwngl+nYG1i2sFcboZHk=; b=KXOjDi7OcJb35R//m8XFzPW5qc
	f4iGGkNGsw3SFIZFCw1b/D2OcUqUhvBxqclHMgO8a/vRCFvkX2/H1dPjDb2UraDCzW7XbuhYmnzjK
	izRW57Vo29BjFXVLJYP+ej4vfCm2ljarI06hYT6RipHlgrApPg9DxCcPFQL8zlDncWGQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi6zY-0007L9-5t;
	Fri, 10 Jul 2026 08:53:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wi6zV-0007Kw-Or
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=; b=k01C1cKTY9FHSOmbDoDE68moZu
 8D8INZx5S1ItrdwXwBn6aEwbzZxk6+GMTIgbm49tIXrZburD7XMW0RKDgEKe6yxeNvLoUMFbEbE54
 VncJOJ0Wh/+iS0MSxZhrJsWBR3NeR3knvF7hJISJUjhcSTZYDuHLzk3vinVEPtRWmx5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=; b=hxzzR3RdYEDCfbvhldPmkZ9ip/
 b/0Xcoj3foMh2L55JwoAbJDskIvR4rSYYZSwvKa9x7A/zvXL9NNq19E71Fu9IvxCEyzKoKy4smcN0
 WWQ1s8gx6NRMuGNv0XxX6A14bcBI6yDRDuQLJx7ZPji7nqdmvkzB7BF55uShvmoXEhqA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi6zU-0007Tu-CW for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:53:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC9406132C;
 Fri, 10 Jul 2026 08:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C01C1F00A3A;
 Fri, 10 Jul 2026 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783673622;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pol/abMS6ySkJ4PqqvJwcwpqSGWEVT90r/FwswEBZceAtfieFJ5j/QhoLAQHHpaU5
 ufrPV0oVuJbMIbzd1F8j5yvdZ7B9pOgRXiqbQqGH8MkuaRWeQcFKq5GkGMgoUwScGj
 qoN8uJq1hQfVh0SxYUZqstF6NgpEpbxH2UzZKj42uj0skyfNs05gUgokl95NkSxC55
 xOeJiscFouAnS5zcnKZtIDXb4Obe5+0fUPbNfIVgEn3/8wp8xCM1ZqtQzIyirHpSLw
 s3g3d+YkgXr89PfQgmdqekgX5idBQHPmKTrRWyU59CBMKRuJvhnTg7eyyHdDBfxpUF
 c5ECCMOB2oTMQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Fri, 10 Jul 2026 10:52:34 +0200
Message-ID: <20260710085256.3464201-7-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710085256.3464201-1-aalbersh@kernel.org>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wi6zU-0007Tu-CW
Subject: [f2fs-dev] [PATCH v11 06/20] fsverity: don't allow setting DAX file
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
