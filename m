Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE5510F9307
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ihXTvLKyo6Wb1Ang8QGQKwAsJl0xkpP7D0mcd98cDo=; b=Ig0Vvkc35B1foB4RSM5mn+UTGx
	4cU7UZy9gxMXExwhlS/ERzvbA3zRVnkTjs1GqZ131VxdWpY/QqhgDomKIOm+bHVhXJsNrc2g5p5Tj
	oNmCm2PqazpDVh48PbDzUd92Q9A73RXYQQSaUoNT2fhRz7wGH2NscneVndjC9F4OfCUU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7geH-0002SS-0K;
	Tue, 31 Mar 2026 21:29:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1w7geF-0002SH-GW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9o+o/e+0nWVDHKM3SRYN/4oZtN8PnlF2wMfvwmAPe4o=; b=W6nGKnyqr/OWBwtTQw5kG30Hej
 lk6gMkxXSGPJBGdZVy7W6Mm6VFLBQVj7fw5+d73j9yN+DT0lMRjeDUVJmXIQiwODyMd0EHnfUtx+V
 ODNhz8JPsqF9j/rpA4b/xc4cjTBK/9A04cHv8M0SvD0zqCarRp/YvUyQ+46mRL2ZChNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9o+o/e+0nWVDHKM3SRYN/4oZtN8PnlF2wMfvwmAPe4o=; b=WXFzllah/mQoze7mzcJxc9+qxc
 AjKAPT0MWjUUEGJl5Blfjr/mSDrRKq4iu1Kl+ejxfObGbIEf68NUmHk8AglwefzwG7wZxwfl/mIPF
 FpUFI3W/eLw3ubq6n3uqMrOBfwa+bLADO09QrbVUqCHvj/zvuiUA5Wir0BHph7cp3Py8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7geF-00076D-4R for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:29:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CF4F60132;
 Tue, 31 Mar 2026 21:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FC5C2BCB0;
 Tue, 31 Mar 2026 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774992548;
 bh=60UpzLwPFsE/OH5uzd9+hLYE021xyutp1l0GCWgkWzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xw+EUWPPKqXI5Y3+7jz37C8gOKzOu5zBRsL9J8Dn0tzhpzQNZwK4qJvpwrakcOhQl
 SIQ6xvN7CIl+VXGRUtE2fy6rQmaAfaSR0JQF8eYGz8rvPMi8X8GxZfDjtvOIaAGtx5
 4UzFYtA3iQWQr/sHePMarvGqB0s72i4h/t3S52GVaxjIbpBC25+YHxcBBL7ASHr/FB
 59AaUCJoqNkTJ1ddFUBMRbYmiwpNMDf8jY9XAMWUHAQY7QXH/+K9gK43iW6wRP3B0K
 PrNt+DASlufXx//ztkGd8gRrZDFOz/eL7CK+l2RcGRLfYG2wjY0kHKO/YhYLxPQ9JQ
 wkj3wGWaTsb0Q==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 31 Mar 2026 23:28:12 +0200
Message-ID: <20260331212827.2631020-12-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260331212827.2631020-1-aalbersh@kernel.org>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1w7geF-00076D-4R
Subject: [f2fs-dev] [PATCH v6 11/22] xfs: don't allow to enable DAX on
 fs-verity sealed inode
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

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ca369eb96561..17efc83a86ed 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1387,6 +1387,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
