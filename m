Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809F1F589CF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrfwgtO23JKKUmb3c7r5RK5Q1vCobt3/mlHWUjhCl28=; b=ahQ2oiN/KnynmfFEECeEIsw8qS
	EhXBnPB9iOFYL5iZVB4Xp+m6KVjfkBNvwvHqCw0ZLY59qQQPU2fbYM5Qc7xeCfkCKBN3rTfeG0zGB
	SwTz4uQ18A/OpitIyK/jYe3eNMpa9r4Ut0vCAIsI56R1NJeXhBwXNz/J3/ntzWZUSRys=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtrX-0002fN-6n;
	Thu, 23 Apr 2026 13:12:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtrV-0002fE-58
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7v+otcaBL2NbxAVbHrGKVdmX0qwZr0j/RiEQngkqNZ0=; b=Bl1EmueOjCg3bUIGfAwbO11XQZ
 ZeZDpa0SVRQ2Se3s2K3iFo9mLJSilOKaH9pCqPyZDp9YEVo/kdOvxNtVJwRdtCdqqCthfycs1TZTF
 MU0DQOrs3aIMRG2aRtDtDyIkEKIRCBQTqYUYl252ojWYmFw/mUeBgPlgzbry2+WjgkQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7v+otcaBL2NbxAVbHrGKVdmX0qwZr0j/RiEQngkqNZ0=; b=gNFNK/SxUgkwetVprfoSUOfkwa
 X3FyLA9NpnhtdDzm8H9yutMY1h9jJJ6JGcHg7EAS+ynds/7gID/x1a0LPCdSQXKEF8z5w54mqcGSV
 Hiv/IYzX3QHdrhphgqtyqXWk1dcelcRwY3kPpGpJALPvzoOiyHp0r/Mv+dyJy/KmGgQE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtrQ-0006oz-Oh for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 71BA4438AC;
 Thu, 23 Apr 2026 13:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3111DC2BCB4;
 Thu, 23 Apr 2026 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949962;
 bh=jXYqYekRjpF07wlPDKgx2XWDNqQtTHKbLiod79qFffg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XC3zMZ8GXEPAPGuVPkpcEGJW/IWUfO9lT5X+da8jeEzG30DrtLhAa90rUVt9Gnx3h
 Yh7AnsqQoxVGIIhqTnnZbWpcjwN3ItAVSTFp8tiMrIJUWfD4R9OStiy0ZNAyId4XMw
 d2Z2L5hccCmf7zAV3nqUUdvoQprKmbcKdlOAgW40hdZuQX5OaPfH+A6rab0OZGvDox
 aDv0P/ZQd9E8C+/Pwl8FA05S6P2NtFlWHsLB8dFv7bB7fMTkseIbph+4Tjrtxq6euV
 wCsCmNbnex9K3PvwvS3S8q9VkGxuvMVnUOLmsezHOVvd1EDzUUpalew7yOLN8BACBt
 IegZt8Hz3IuLA==
Date: Thu, 23 Apr 2026 09:12:11 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-8-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=TxMd9+19zfe1kcd7z7IWDwky99GfiXSk/tT0Rl2ZM5c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq01cfRhNAJt0xx2EbnMwGvHTygaBYN6aRTE
 GINZfCUwkSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l+4aD/9AIIDkYsuxGwkaHb0alyjM31f5P4xoH9QnzDFp8NL/UVKvxCdSvFeMeyBHwVa7Fy9ruea
 zMwrMXaFVq2XZWeNySOA0xiFd4HT0xd854+HjYrlIEdnnKtj5zrn3FrAvE3n7mSq5YxhGF9pwhw
 5RavDMmtW/5nOr3HYz1Gp7xrk3hPZOJ2uPXpSOVw9GMxNiotmNg0ZDwjDxSEMkM7+ScHLDGzMFR
 wLhw5l9Rs0mhNYWejSb2IQhDijmYO1Ym35ZiJjNu5ft4ChBGAuoxGL0m5/f8650C7D2PP+Uet9i
 r4Q+ALt7QWYX3HAPWpT2pMx8cFGUD25yODaeNdLKH5AiBlu8KtHiArKHxGo6nIDcxzr5RYhvmYp
 w5CIQChTJ12zqUt2vNfuYzcuNFQxah0Oy3lAmGkW7ZL+juq6mxvkPTy8PJDQvH8wLKBlWDHCpul
 7a2TrzylW2pvpGiW96qRr6ZMwLsQLoWdZl+m5tbuBxniV9qHk/2Qw6yE/bwTx0MySJpVkZZgnZ4
 ty+BBTmKui8m5aOah8Uf621+mouo4Ve7WFdy1i4zWhVUDQgbHt5cn182HB0L7hN8xQrYTHqTyM2
 OKrOHQ/XIP5hQ1O6r2WRIOscUUUEfDJNxwOPDa/Lunw+phN71xW9DR540IhKBRXhREigJfqA7wH
 jFNwOPn3bVc/EfQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtrQ-0006oz-Oh
Subject: [f2fs-dev] [PATCH v10 08/17] ext4: Report case sensitivity in
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
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1d0c3d4bdf47..d1d597a13eeb 100644
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
