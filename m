Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA13FC4452B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4RnHRJr4JtXHMq1c6SKWvWOwngl+nYG1i2sFcboZHk=; b=UjTz+mZ9DJEba05Z8dnlMxjVl3
	BPstRzxu64Sg2xZfRj27dOZJd1yf3zwHUKrwGPL5JpvLAxQhJPwbVTdBSNPF5UZOSsdxt+5o1Gh4+
	tKntkZc3H1onX8whxthbQgAv+ym6GRZf8OSOTZV9FubjcsLOwwbHTNVIaLJ9fN3KU91c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFS5-0005Ws-PF;
	Tue, 21 Jul 2026 18:44:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFS3-0005Wi-RI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=; b=mzlNvet+5vY+BFZdYUOaBXTgQX
 IR+MV3Hgc0OJV7VzOLN+9eqcc33tjrQ4+GwcDWsdYujonmOoEKsoO5diDaondVqIwcHOHw0jB6c0R
 m2dif8GPgJXKiRLITIJopS315EUBDqUDOEyri4hz2Ze0rtQSOOxEDKd/Sv1hOjnm4Xg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=; b=BBFx+9Z6MXw7tboqg2vnlwxJzt
 3scne5fyiyYX6D2xbmyrvi0am4INtD0xQLU2pYsWtpaQCTDV//a2EA1xzGUe0RvmRho6lM/Hg/r3/
 xD0Ywu6boKn+FKFb+dWKVQrjrsnuOKC0xVaUpjmYwKFTCoBjNahcYX5GEn9N5TMtRIHk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFS3-00030g-6U for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D73EC40926;
 Tue, 21 Jul 2026 18:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5627A1F00A3A;
 Tue, 21 Jul 2026 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659452;
 bh=VICvrkHJ76P3bbcz027VoiEo6h6DpXS/23ki+zkvasE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WataG6voOGeBKkFGA2WCgtoq5VWldwW+e3KlGLrdtyzqGIypmGHbIShpKTtuaRzXk
 oxsyviofCAduJLlvtlHY6WOx4Lgqwcj4I/1jQnZz+lletXBJrkYPL9xGSe7DTPeO3A
 NSgLL8G6yYrTSdgEMz5b210tKyCnot4yfLUAKrxMNg2pogrLKd/Zj1g6WcjzBQAd6N
 5aUfHcSMN6rMtyB3qwNG+HHZ7dCDZixpgXdtrNYG7g6+8tdwQSWH8XWe/XCTOzSWUR
 u4JHj/IXvSF9VIqwBei3uoTBp77fnpW2EoFbgZ0z+PjqEh/1aS140wsOQ+25MDViyk
 shSR2wZSocb2A==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:43 +0200
Message-ID: <20260721184346.416657-7-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFS3-00030g-6U
Subject: [f2fs-dev] [PATCH v13 06/23] fsverity: don't allow setting DAX file
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
