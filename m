Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84FFC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7NAlGhbtR1H/UyaaHoQLYVBdJ1xTa0t6k9QuPsH5AQ=; b=i+rfz5JTxuAjZRuNJA+jBE599D
	EPCP9aKYkgZXyywYUziAsG8OJkkOwyVzAGJ3w8iSf9lxOuckowUUrb3PNgXW7dkW07H9AM8ULZa8H
	kH70OBCOxn2YYoKXHg8tQjQB6ZRiCzwyI59ECf8ZlFO4TLymJSRruo4L2ilSpVsIqgLo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoAw-0001tU-7L;
	Fri, 14 Aug 2026 09:26:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoAu-0001tK-67
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B6LynSTm43VxBrGeNfUSbV9r/RlWcb4DP+IF4QhqBeY=; b=kY8IdcoH3Y8eZ5wO23IoDGr2so
 j7R9K2vF2vdAHj1VOLYabSfN9XVzH8d0KSBnDb0b2Lz+JrQiFCBHFWE3ZFD175N1j8lM+NTO7VVcy
 TmWrVvCtBCy/GQhwAdJK4U56+2GcKw79o4tlEGsUAQ1AZg7ey2Tkjzi7VfCH4SnCvsW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B6LynSTm43VxBrGeNfUSbV9r/RlWcb4DP+IF4QhqBeY=; b=F/W/BbL0kkR8kwgKvX6kgGRvy3
 bEgUtF6aVovnlogzBmquDcOoi5DmZOf/2cgZnrVNYrhfjbolEQDTFgMynt/vTQ1tVjdpIjPIOSe50
 JoRamPp0/5FB5IKfA0xlFuLTqsKGLGfXsobL7Hok804aasOwqZf7aft78oREySrebW3k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoAw-0000mv-T6 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13C7F412E0;
 Fri, 14 Aug 2026 09:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4491F00A3A;
 Fri, 14 Aug 2026 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699558;
 bh=B6LynSTm43VxBrGeNfUSbV9r/RlWcb4DP+IF4QhqBeY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BNjxHWA52N9hZ6iVbTtZ01/VdOyRio0Tjvz9UzDSlYmhvKstAcDxpv3Tvb0xuwI10
 SPF2NorRGvfD7qVwvQ39a7Tv1SL7+TbRDDnD1ladFfcsPF/HEFA7zb7a54183FSybD
 gt4XLp+4GnfShvD5ndr6EtX/19B+TRZYePtfUBK+iezPia7cwYfjhJM6sOOCyeDrIZ
 cYzb3Ix+Sh57gdCyDf6klHe8fJMIqZNOxPyrmIqI52kjkwnkIX4/6xn6U91yc/S+Aq
 h9VHJ0K6YETHg7nZ9FOGLZj4UmILA3ihxhFx9RNLsbyNH43DFVrRNAMfKCjMc4Ri1m
 AC8gwnC1YvTug==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:22 +0200
Message-ID: <20260814092448.1818082-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoAw-0000mv-T6
Subject: [f2fs-dev] [PATCH v15 05/25] fsverity: don't allow setting DAX file
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-ext4@vger.kernel.org,
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
