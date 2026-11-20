Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE64160A2600
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X2t37bAY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lZfS/Ohc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DTfyTAgv;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik3ISORV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oMyXf17p+MLBw/OdnpRxdoT3LMD2XNuq2J11+2Upns0=; b=X2t37bAYDCJQ8ABywBeXtP+a/Y
	MftRvFdFQPhn2nSb8HCNl73YORzT6oYcPS/biR1R7n0UGpA3KIcNJ4OHybRKng6kp0waMagxtlU+d
	YRBQ1FmRpKAHf+0GipM6qGhov+IIks8NHjuGGcyu503LDeX0avVpUfM5xGVn4HlRWvz0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUQw6-000000008Ki-2abR;
	Fri, 20 Nov 2026 15:54:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUQw5-000000008KS-3BJ0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ETEjCRJqTj2rcNQGoOiUFzLxZ0618BE5SBDlsxU9kIQ=; b=lZfS/OhcNAbVP1D52Coiv6uLJG
 HGfFcO3VRxZ3GjuU4UxnmOcKIesUU8whD23ba8rm1wkcYtzZ+x3pCthGnllHZ/zwkVotw4sNoS27X
 SO6frLjTvcNDROJEDruIZOFy15XnN7dQY6bIMCrvb964NjMIDjpl1lHy0bz2q+SPdq48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ETEjCRJqTj2rcNQGoOiUFzLxZ0618BE5SBDlsxU9kIQ=; b=DTfyTAgveSrypSd0S01oOJKgnc
 Rc5hoX9hSRNzVf2Aoc89cDHh1/pXWI+Co5UCE8Ej6U0HO19/fJOGtjyNOXX69dGdbQuzCkq2Ewx94
 8CXzXgvVA4EYqo8+Kk4zhGoVSUp+GigeY2m8wfR+FGn+FKBxKCT5vgoKEQsVCsLnZgFw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUQw5-000000003xl-1KZk
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CB9745F55;
 Fri, 20 Nov 2026 15:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1FA1F000C4;
 Fri, 20 Nov 2026 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190035;
 bh=ETEjCRJqTj2rcNQGoOiUFzLxZ0618BE5SBDlsxU9kIQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ik3ISORVw1eoMJOwfI0KgGK5y31QoAyanFb4Y3ShFXUYimJxc2d+lHdECp6wbpq/X
 +bGCs1jwb/rlqfI6/FUiKQbdeEyHzVLGB1b7X+86YfAF6dajtzPI2BMboiez0JfozO
 im55TIYLktdcPKj/QB6YFAlC8Q8P/h6+bXLM5OM2/67VAeOuhCxwszEC8j1A1nvGqD
 LwkNma1hLPoNfH93m71sTQOQ1oGZyjsAsdJkop1aYgGr3A1/9LKPQfihMLfF0S8kVN
 n+FfHX2l1SB7cu1rcBxaf8vbzQM526/l/njvCIDv3GSodQeQ+BFsxtjgelGFaSGEgH
 JqeRlGV7msHZA==
To: "fsdevel" <linux-fsdevel@vger.kernel.org>,
 "fsverity" <fsverity@lists.linux.dev>,
 "linux-ext4" <linux-ext4@vger.kernel.org>,
 "linux-btrfs" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs" <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs" <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Date: Fri, 20 Nov 2026 16:50:24 +0100
Message-ID: <20261120155032.187246-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120155032.187246-1-aalbersh@kernel.org>
References: <20261120155032.187246-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUQw5-000000003xl-1KZk
Subject: [f2fs-dev] [PATCH v3 2/7] fs: strip FS_VERITY_FL from
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
Cc: tytso@mit.edu, viro@zeniv.linux.org.uk, jaegeuk@kernel.org,
 Boris Burkov <boris@bur.io>, Andrey Albershteyn <aalbersh@kernel.org>,
 Christoph Hellwig <hch@lst.de>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/file_attr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 833e03810b24..81bf55f9b255 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -199,6 +199,16 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (err)
 		return err;
 
+	/*
+	 * FS_VERITY_FL is settable only via FS_IOC_ENABLE_VERITY; never through
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
