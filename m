Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51603C982DC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7NAlGhbtR1H/UyaaHoQLYVBdJ1xTa0t6k9QuPsH5AQ=; b=fmYCkwF0MZwPkemzRzVub/Jm+l
	ssu7oKam5BCr7paYbXmqJmidyrGZcFfAtWmRJIQOMGIe3IBqFf57TwzJtJfTfpvtZk2+Mv3tDn7Bx
	RYeOpw/jqOo2jRq7TglRNLHOA/XwrKDbxjJZjfINcnl2tfXr2dalXzdAYaqH5vbvxs7Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7WZj-0005W2-Rt;
	Fri, 18 Sep 2026 11:16:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x7WZi-0005Vw-Uc
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B6LynSTm43VxBrGeNfUSbV9r/RlWcb4DP+IF4QhqBeY=; b=B26l9ZJPgM8kWmFttWKgpDrqLS
 gOHMclfQbAELdQ/ZpGGGHtXKYCDnyCZdmCI28ioR0JcNB/As8c6bh3mQw0L2Fy29mONtZ/c5KIO6m
 7h2bdw1A9FhUuth3MuzKvMoBYY/u4+gtKryoprjiIgr8EfxpzAwU/y7flSFUJAT25IFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B6LynSTm43VxBrGeNfUSbV9r/RlWcb4DP+IF4QhqBeY=; b=lPJuD11J9OiqT0VhPhodzqtFd6
 o1Ld4wXlBd0M8o5FIXI6RP8K0y+vAfkO7xHK20XoBnigxiDpZt9Wer6zc/Ls68/JcUDBqsnb8rmxB
 STiM/pSi3r5XaZx1gUv4qEsaqiq+Lu2JVYBvcD9xDuli7eSbt0b7COB1cjfyWc+6vv+M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7WZe-0007qk-QS for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41FA760A8C;
 Fri, 18 Sep 2026 11:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CB71F000FF;
 Fri, 18 Sep 2026 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730165;
 bh=B6LynSTm43VxBrGeNfUSbV9r/RlWcb4DP+IF4QhqBeY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EXSiXWCbShihhYqQ3vawQ93po8jHB5w6aqmJrCpTz6GXEyuaBS3CRWMh4mH0REjTJ
 5Wra4f0cBtb4sYpL4hzv068eB7vT3nzmargEtXBQ5Zff2C0xh2bgaZGU4DEe30EOiE
 5wgfklWLG0k1cUeODkreOJ4XWERUccDr1mu248jgm63GkwktQsB+rn7MrrqayP0xvw
 260VkiJDO8pKck0GAc3hDRYEsgT9U04PXYkDZvFWZBb4tXHvomsXl+ns709wDh/iRy
 vdNcuVXqe4NnBmijXERo3du+KfjudvmUzZPPXMLZZXDXIYdU1mWyIWE4Vro2VxdXF7
 AWz5OS+VKw2vQ==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Fri, 18 Sep 2026 13:15:17 +0200
Message-ID: <20260918111539.1003439-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x7WZe-0007qk-QS
Subject: [f2fs-dev] [PATCH v16 05/21] fsverity: don't allow setting DAX file
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
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
it checks if file has DAX enabled and fails if that's true. However, the
opposite case is not checked.

Note, that the only other filesystem supporting DAX and fsverity is
ext4, and ext4 does check for this case.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/file_attr.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index bfb00d256dd5..391edd1d0ce3 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -235,10 +235,15 @@ static int fileattr_set_prepare(struct inode *inode,
 	/*
 	 * It is only valid to set the DAX flag on regular files and
 	 * directories on filesystems.
+	 *
+	 * DAX and fsverity are incompatible.
 	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
-	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-		return -EINVAL;
+	if (fa->fsx_xflags & FS_XFLAG_DAX) {
+		if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+			return -EINVAL;
+		if (old_ma->fsx_xflags & FS_XFLAG_VERITY)
+			return -EINVAL;
+	}
 
 	/* Extent size hints of zero turn off the flags. */
 	if (fa->fsx_extsize == 0)
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
