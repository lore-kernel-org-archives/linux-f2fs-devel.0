Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4311FE9A04B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WFeJwi//RrGnUeL1eNwWpZ0+JoF9LdaR05QRBkxy7Lw=; b=FiO4lxdQWaFY9YuXEufk3BnBri
	ugb25Fagi1IOr1SeWdVqM25AfEshniGmqcRHy+nxZTVUMOwrPObf7ywJM0/XOLXeFTMEB92nNitj0
	KChGNJ7QpP+EOPhiQ6fDmzPXJJeblIC9DRSeXtgkgcTme7OePdD76mxjD0FqNC8lnizA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSva-0000XY-Up;
	Tue, 17 Feb 2026 21:48:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vsSvZ-0000XM-7a
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:48:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gYj0JGHR507wp/kGt0ZgZFxaM7wb6KO1V52sE2w+KCA=; b=O6y+AgqVhX7UCHYYi98xynWFIW
 O65b3cWyLzFDufn1ksep2fts50qEHZfA0+YAO/N98Nr/RzJ9Jm084Qt/8LNLc8jXNh6NJFDFgpL8r
 rBCVGoXRcqgbXybySInkB8fNE+BykUxwsgJ7rqRsFFFeEDa73kq0jGHSSemUImpd0MFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gYj0JGHR507wp/kGt0ZgZFxaM7wb6KO1V52sE2w+KCA=; b=J4NbcdcxxQIE0BCK6Y4Zb4uujC
 2TVunep3kwQSsx0JaO823+2MQ8WopXZIv7S0YPPsNheqa5h/wvmp49Qy0sLCCOKvnARZDSiilR9vQ
 F/tLTu98evXKWkmf8Dx8ieoQnBdZLEDD/NfGrCqB+jZMntjx9ZyOkPYVvJQklDXVKAkk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSvY-0002sv-MO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:48:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 680BD436AA;
 Tue, 17 Feb 2026 21:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017B4C4CEF7;
 Tue, 17 Feb 2026 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771364886;
 bh=hTKaZ1DqrpDPT8D9Hsa+8JFcRjOoKkJIQ9HwVjo6HdY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Es8TacpKYI7rQxz+XweHWdzuT/zgCJVBa3OY1udo7vycYwkZ/4znBYaBURWNZ98Yp
 RaQBkNkUOE7+gcDQy72TK3tHy3S+DPEDc4/f4cD1VXk3BZlqyC+5npM3NSxCCNwepy
 UiZUNypdReMu0/4f/YwqwY/ku+wDMxEvRqooibz9MDIfkoIp9LC48t7+IawAOf3C6M
 idiefwYJQ3tc0TVrk99AVkHGvtc2M4WBG8tcLKvQ0uuhBZN/65dKUyoS0ZcdThHzzX
 UfBoiUsWeDDHpaVSQ6fwQFSPwDCe/KhijmTuVGcoeMWjpvROwpRKefnSiFS2rMBm+Z
 Q194pkU9htQ/w==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Tue, 17 Feb 2026 16:47:32 -0500
Message-ID: <20260217214741.1928576-9-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
References: <20260217214741.1928576-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vsSvY-0002sv-MO
Subject: [f2fs-dev] [PATCH v8 08/17] ext4: Report case sensitivity in
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
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report case-insensitive; otherwise
report case-sensitive (standard POSIX behavior).

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 3ae9cb50a0c0..a93017b80aa0 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -999,6 +999,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * Case folding is a directory attribute in ext4. Set FS_XFLAG_CASEFOLD
+	 * for directories with the casefold attribute; all other inodes use
+	 * standard case-sensitive semantics.
+	 */
+	if (IS_CASEFOLDED(inode))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
