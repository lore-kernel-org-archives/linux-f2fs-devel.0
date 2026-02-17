Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570D6E9A03E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bFlDACdCjzhg0ctzwsNHm7j+I0ntRpiSUqKQJrw+xkQ=; b=fYARFHJYZX4ZaUKUVE+xAaQioq
	kGIF9BJ9oqZc+2e6DrL2sH27YNpgnXoEtCHnwbj9J7nEg0UR1jtd+X2IR6DZeJHzsVfJrn53SLWSN
	ztG7ZrMHPI0axUUN1H+QIF7oJq0fmkwIVpSq/a4corcTktGTfzBI7zsugi8iRk2RVtrQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSvX-0007j7-7l;
	Tue, 17 Feb 2026 21:48:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vsSvV-0007io-R7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=76sKeFAln8zVWVkEFMZa0P1jqbKZnq1zXsN/tPiBmsU=; b=ApotRNBC12fEsZHVYRTePEhk8p
 O0VdZ7pfc3sw6VIAfWNlV9cBmp9fPrkc+DVSeLecdzmsp6YDrHdpTKMBm8IIIdDsTyyqaKSEMbHgN
 PI+ps0cv4QBx3plNGXMqY7E0OJqa43o4f5cK2ZTj43SSuvbAnVORGCZcKycjUHjczA+k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=76sKeFAln8zVWVkEFMZa0P1jqbKZnq1zXsN/tPiBmsU=; b=Fio1DdAO5RX0rMladgBUhoBMwj
 0hWK6pKvJ5ROMt8O+YuN3P/vndHFUnMjs08BpvFhY9Jq9IIZ1rxVpHg0tR5UrcbfCTXNySVRrEP5j
 HFbZle4udVVjjsixm7xzu+azzEo0uat7o1CemwTq8o3RJFmVjVmLa4U4W0zEqegHbyJM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSvW-0002sn-8Q for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:48:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F009D405FD;
 Tue, 17 Feb 2026 21:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEA7C2BC87;
 Tue, 17 Feb 2026 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771364888;
 bh=fYGZPGOvWWHJ29HyCpYpZWY5Spu1N7gwM+/38CEuEEk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S/Ai+S96uG/Gfz7HATywK5Hdnt8vlyZtWhDrlsWq4+HHhqloU2FqnQCAUunQ+j2+S
 CDkoGtknNKSJ9d7s0NeTIWe1e52obwCxwbH7zpZ+yKOspWldxxhnElIJDNkXxvKWov
 XYuXCW1yVlmz2jI2JL0FOF6EYG4ieCR7GpxwWJU+XbE5n6tQvUEibFHmHgxySgNUPT
 HkjR5pf3qNY/RNRescro07eKCGuHm2wqmybZ2Mz2dDVIFTfZ4dhIP5PU4aVMzh/+xu
 W1azjC78aQfLp7Dp57Alvp0WlZ7Pk5Pp7qQx8VlUKR8uNTgdWVRSVm6CzOjjpYQ+uD
 Axwj1rjBey6Aw==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Tue, 17 Feb 2026 16:47:33 -0500
Message-ID: <20260217214741.1928576-10-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
References: <20260217214741.1928576-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vsSvW-0002sn-8Q
Subject: [f2fs-dev] [PATCH v8 09/17] xfs: Report case sensitivity in
 fileattr_get
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, sprasad@microsoft.com, frank.li@vivo.com,
 ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem is
case-sensitive. Report case sensitivity via the FS_XFLAG_CASEFOLD
flag in xfs_fileattr_get(). XFS always preserves case. XFS is
case-sensitive by default, but supports ASCII case-insensitive
lookups when formatted with the ASCIICI feature flag.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/xfs_ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 369555275140..41c6b4cd8ac2 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -518,6 +518,13 @@ xfs_fileattr_get(
 	xfs_fill_fsxattr(ip, XFS_DATA_FORK, fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
+	/*
+	 * FS_XFLAG_CASEFOLD indicates case-insensitive lookups with
+	 * case preservation. This matches ASCIICI behavior: lookups
+	 * fold ASCII case while filenames remain stored verbatim.
+	 */
+	if (xfs_has_asciici(ip->i_mount))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
