Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8590606D817
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hEHg7IUV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Mw7QhYVE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L6ztZe7g;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgBGr1nZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o8oaWEIuVtZiJ0llkiyZFXKzNUaiMjguXqs5GBOfoss=; b=hEHg7IUVVcjamcsD94tYdg81qW
	4n7iIeJRf8IhNrgrlphw1hdz+m67pnzfwdFOVDsBepBAhMT7GyXEP98mEtOJ1WvkJtkyZ+Q5IJ5As
	hBObewumeKB9qXygS4gQeFN8LBTGU+Z/2jLFEWOQ/SETKHc3HUZE9THa3pyKSYrHKe48=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOw5i-000000007ow-46Qr;
	Thu, 05 Nov 2026 11:57:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOw5N-000000007oP-1Qk7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:56:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9Elr35owCGoWrbIbOfwaKZniSZ+EtPctIpo1HzYHSY=; b=Mw7QhYVEW9f16m7dGGwp8trNhO
 UH11lZhUlxDkUF4YOLolqoMkipHKzkgW8IXprGLXOiCPsD4e1b6hlCDWj0j4p+dCfYqV/jbLbtuUq
 JLATGES+OjC/qUTB+RALfVeqko6YfH8BCKGHeVeay8XT83tusGRJtZxqFUwfqV4aUcvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9Elr35owCGoWrbIbOfwaKZniSZ+EtPctIpo1HzYHSY=; b=L6ztZe7gt/hs7MH1DFM5uYKw0M
 Z+/xFvZHdlMJ1CPf/mtf3XCASlJS/UJOj2vVDaJojEhXu9eZYVF//hsOshEiXBau3yhhqNQJgYhLh
 zjN62s1Hfrq3VOLh0Grqzn3dUtZxAJsz0qE9b8a5nDq6KiYU9hdnF+IILVi8cBtCUXPA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOw5K-000000007in-3LjV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:56:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CC6142B13;
 Thu,  5 Nov 2026 11:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6CC1F000C1;
 Thu,  5 Nov 2026 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793879805;
 bh=S9Elr35owCGoWrbIbOfwaKZniSZ+EtPctIpo1HzYHSY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DgBGr1nZDAETi124q1hztIbhXV6KtPoh9zp8Kr1LzjPn5+GbCdwbl6JBBxqprK/nL
 KJr5Gvt5nNxIUrG9+7GyDhCjrCFkGGTUDcnSwU/xJc/nJ3S+qjSMYp2DfB7SzP7+WM
 lR3RxxVf5C/KduUopuvlnjE9tm2f6zVpmzbGaoMYL7TTAtLyqLGf0b0QbeGQja4ZaX
 qeZcTF3eb8UWxGQbqqQt4FIAMPKIdmXwSBputI1wBx0D3XQWUCqF7L0DGnFQ2iaEgl
 la51mVTz2YciPEh0TEggsXfjJcEQ+4+TRICemIp9QK/kMTfIRZbpYCAwK0WJepNQci
 mSBNyan/kY/Bw==
To: ebiggers@kernel.org, hch@lst.de, fsverity@lists.linux.dev, dsterba@suse.com
Date: Thu,  5 Nov 2026 12:55:26 +0100
Message-ID: <20261105115532.613467-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105115532.613467-1-aalbersh@kernel.org>
References: <20261105115532.613467-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOw5K-000000007in-3LjV
Subject: [f2fs-dev] [PATCH v2 1/5] fsverity: strip FS_VERITY_FL from
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
Cc: tytso@mit.edu, brauner@kernel.org, Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Boris Burkov <boris@bur.io>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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
