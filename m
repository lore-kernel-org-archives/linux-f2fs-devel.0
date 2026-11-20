Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070960A2600
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YxLzCy4n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gh9aYf1R;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jNOjK3OM;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z67BRIpI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zfhDYJS2gfzrvvM28Yh6iI5CZCRdp4FmkFKqMvhnOKA=; b=YxLzCy4n+1UdlyZ+yaTrwoMAn7
	/QvJM1SsiBMPlDCyL9WB/FQ7LXxgg4ZiRVTR4pOn5U75P9dFCXjlOlz141b8ywSI2y0hSugP7lGxC
	AaoKXK9zzdE2YPprjFBmdh7Sgfvkrz2AM+fhUXxGOgjf2lQE0Xe/TrGLIWvvi9j4nhpc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUQwE-000000008Lr-3VcK;
	Fri, 20 Nov 2026 15:54:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUQwE-000000008Lj-0Nsa
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d64oy+cTLXmeYoVqPxnHx95FYIWBNAnJoC4BVDuan+U=; b=Gh9aYf1RXLLfVomn5JcijNOda8
 rvhV33JTZ8Kg/LAK1QiM22KLHj0mJJ+inXzeqfqNcPUwuJXUwagZ2r8WsS2RCIpD1woemek0MpqNX
 2qqiv4yZujZ9HMhP/7+m2HNotiSbXMRvNnjl4qMlM6KEVgGnm+t7HtnDf3Mw43Be74fU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d64oy+cTLXmeYoVqPxnHx95FYIWBNAnJoC4BVDuan+U=; b=jNOjK3OMTvt5TsUQiPgkdp5xT9
 Yp8wkFeyBCRWTw1wmIO11kdKOb13rMbH6S2leZT3cQWscS0hwmTFtluAs15cJRoFR/y7ELhyJTS2B
 +DrRuWCk4iQb0kmpo0Gyr3XRD0ocqGW8RNljzYcw1qoTqT0UF6E6E+bLWUp6tCp6PizQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUQwD-00000000242-2wu2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A47F462D9;
 Fri, 20 Nov 2026 15:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A581F000E1;
 Fri, 20 Nov 2026 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190044;
 bh=d64oy+cTLXmeYoVqPxnHx95FYIWBNAnJoC4BVDuan+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z67BRIpIOVAM0LHS7fHGKmS5m2/l5JJqzXdbkyXd2XkWDGuFUOGdpxWlyWA2FNVTa
 x/LAqJqHMSru5710+GExPrz4v17uGZMGuLODrcL3MRYowsVCgeEgq3rpRKeTwCiTBJ
 O7eOdE2ccLiZhUMBCJF2xBZORxMn5bQygFv3fMMBikRRl6EukeA6nAc/NJ8O+pV80L
 InwrJhbpK4urgQVLC8emFR6Dl1xoY0ToXZZuxT2DZqlMPikif2IMmSS95Y5oZ4V/Mb
 JcKF4vx82iI4k3uH9CVWzXOozq/wMR2yeLaYM3J5/lQWDIbvcRNqxkmVzqZBWv09+k
 kAVD1evrBv31A==
To: "fsdevel" <linux-fsdevel@vger.kernel.org>,
 "fsverity" <fsverity@lists.linux.dev>,
 "linux-ext4" <linux-ext4@vger.kernel.org>,
 "linux-btrfs" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs" <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs" <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Date: Fri, 20 Nov 2026 16:50:26 +0100
Message-ID: <20261120155032.187246-5-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120155032.187246-1-aalbersh@kernel.org>
References: <20261120155032.187246-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUQwD-00000000242-2wu2
Subject: [f2fs-dev] [PATCH v3 4/7] iomap: use fsverity_is_building() to
 check for fsverity IO
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: tytso@mit.edu, Andrey Albershteyn <aalbersh@kernel.org>,
 viro@zeniv.linux.org.uk, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Recently, inode gained new I_VERITY_BUILDING flag. This flag indicates
that inode is undergoing fsverity metadata construction. Previously, it
was indicated by stale iomap flag on the IO, now we can check the inode
instead. As fsverity inodes are read-only, the only write IO happening
during I_VERITY_BUILDING is fsverity metadata.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6d843b168d5f..0a176741e7b0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1930,7 +1930,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio,
 	struct inode *inode = wpc->inode;
 	u64 isize = i_size_read(inode);
 
-	if (wpc->iomap.flags & IOMAP_F_FSVERITY) {
+	if (fsverity_is_building(inode)) {
 		WARN_ON_ONCE(folio_pos(folio) < isize);
 		return true;
 	}
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
