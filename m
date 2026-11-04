Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049B60CBCC8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iFi3CzZE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rhu3FNCt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TsrUWjot;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvREwzu0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o8oaWEIuVtZiJ0llkiyZFXKzNUaiMjguXqs5GBOfoss=; b=iFi3CzZEaNwd+P0sRpdh4QlYvk
	gpLaIJzmH4AGL+pFz7x1VlrLm0gzqsjOR7sK8UZxTeoiY3PwbJe9HAmLMGLpEt6WoBRJ9VAWOfCGc
	m3x9wGf46yGPdpIGVbRJCT6A//aLeVak6010cZe/RA4ark3O1H3edY1TNkVTt3EAsT5o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOgwd-000000001f1-1stv;
	Wed, 04 Nov 2026 19:46:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOgwb-000000001ep-2zc8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9Elr35owCGoWrbIbOfwaKZniSZ+EtPctIpo1HzYHSY=; b=Rhu3FNCtMO7cih/L62wMsmOEgQ
 n4iqIZ9E1gpGXWjzYRxdrCqQNZc+cyFCjHeICwZPO+zsAUhZRCSoTlDJewgxf0Qm8BoH49hXMycbc
 Q1PDBYD3nHrsrGEAdrom/e+lIfn/PH+rbtid4VOIHBGBvZBxNAMwwY7N5TrFgEbi3PTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9Elr35owCGoWrbIbOfwaKZniSZ+EtPctIpo1HzYHSY=; b=TsrUWjotB5kQOtUifz0Z3LMqdM
 eDJ6DTDTf7XxWyyLw41q8Je52SbOW8V/d82vgldEXs52X5v7ZNDVwH/8hLSuXlj763ekCdHwB8fyq
 Zk+c2ZSrkZQl5lnvCzh+ZPUnKPkjsNiRe6WrbH7ta8PAMoXRv6ZZyAkqC+X+c0X7DLL8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOgwV-000000006se-0rty
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E124F41E56;
 Wed,  4 Nov 2026 19:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727AD1F0093A;
 Wed,  4 Nov 2026 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821597;
 bh=S9Elr35owCGoWrbIbOfwaKZniSZ+EtPctIpo1HzYHSY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RvREwzu0R6whKyoXu71qOhrFoLqmcBF2t8nvu0kWwP+K2N2TjZvJbX6VaVkaiNyb9
 QbGlR1+G09aGLijkLguxbBf/0pnUpx3UH+KVSnDBFZmFd7ToRJw1ZvStv3iMstHHkI
 Im9Wd2HVXOsAuWnx6RKofYsXYTajly9BXL9EcoVBeHwJ0zk3oghgHGJPZFLhk+aqyX
 oysqXl1FVZ9Q5zvJlZBS5Oa0/skwEiqpFRYNvf+CcsWNxsLYTFwcFibp+xwwx2Syec
 FaN4H+Cxa3OQYiXj/gvhorF2+GV4Dk0NyLRqOwVa0hIQito/h1z4NHDf/p+DNKwg+E
 XAr4pmTRpbiiQ==
To: ebiggers@kernel.org,
	hch@lst.de,
	fsverity@lists.linux.dev
Date: Wed,  4 Nov 2026 20:46:10 +0100
Message-ID: <20261104194618.103332-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104194618.103332-1-aalbersh@kernel.org>
References: <20261104194618.103332-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOgwV-000000006se-0rty
Subject: [f2fs-dev] [PATCH 1/5] fsverity: strip FS_VERITY_FL from
 FS_IOC_SETFLAGS
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
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The common use of FS_IOC_GETFLAGS/SETFLAGS is get-modify-set loop.
Filesystems could return verity status with GETFLAGS, attempting to then
pass FS_VERITY_FL to SETFLAGS is not allowed.

The ext4 and f2fs already treat FS_VERITY_FL in the set path as no-op,
however, BTRFS returns -EOPNOTSUPP. So, the modification of other flags
doesn't work on BTRFS for fsverity inodes.

Fix it for BTRFS and anyone else, the ext4 and f2fs masking becomes
no-op. The file_get/setattr() path is fine here as this flag is cleared
right before fileattr_set_prepare(). The future fsverity support in XFS
would also need it.

Cc: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>
Fixes: 146054090b08 ("btrfs: initial fsverity support")
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 833e03810b24..b43977d5f8e0 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -199,6 +199,16 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (err)
 		return err;
 
+	/*
+	 * verity is settable only via FS_IOC_ENABLE_VERITY; never through
+	 * fileattr
+	 *
+	 * Treat it as a no-op so the FS_IOC_GETFLAGS/SETFLAGS round-trip
+	 * doesn't break for other flags
+	 */
+	fa->flags &= ~FS_VERITY_FL;
+	fa->fsx_xflags &= ~FS_XFLAG_VERITY;
+
 	/*
 	 * Project Quota ID state is only allowed to change from within the init
 	 * namespace. Enforce that restriction only if we are trying to change
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
