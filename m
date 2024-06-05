Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46B9C27C53
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:54:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sEpDo-00084W-VB;
	Wed, 05 Jun 2024 11:54:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1sEpDo-00084N-9G
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jun 2024 11:54:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xRGUAOUUTWByjjdz7uStNK7zU5qu8v19QCrxcaXEyRU=; b=Qv0F7VrzKj0U/ZR9sj6IqkIuQ9
 8KP+Q2OTEpiMk2+CT/gZDAUlVg6SZ5CfUvM8X261XSlCcsjugwm4sZESS2LFQv015iZAQg8q5unM8
 /hCzjswqiAYwocV/K7hlTnKXeoKK6RgUh8T/u54pacqeIGKrgsg7x2VVsdWJML+/VIAk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xRGUAOUUTWByjjdz7uStNK7zU5qu8v19QCrxcaXEyRU=; b=B
 8NwGzgaZNYky+/OsBjzBS1Y6zBD4YfombFzv1SMLHlW6/vRZap3RrUHjXqiL5kDZaPfQOwA1OVbyx
 3YGYDIeOQJGkgX+Dss930FBbNlSWJF6JeQB7CSMRBjFE+JdbFRXh/yjcGKt+CUKoajTVDufOBdmXI
 m6eC1Z11pgUgfX4c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sEpDo-0000CG-Q4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jun 2024 11:54:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AE795617FE;
 Wed,  5 Jun 2024 11:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E04C3277B;
 Wed,  5 Jun 2024 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717588457;
 bh=a/4zziXLEH7ScUQ841dFu6fDUaravSz8cdlQEliR3Pc=;
 h=From:To:Cc:Subject:Date:From;
 b=kcHBSNIDSCLOarWPvFPw/55kP515WYoAGr5zEI+03pGnZZaNWjbBmRTaAckx5QMN7
 zf2DAI+4hVfLk/bUU9wNVgEjp+J5vYG1pJNror/xXgxyHPfMhR7SVTg2R+O4wPQU60
 xPj2u3dG7YeaLPo+MsUxSX9E3EgzkeH3Ide+eJrj2b7Ku/ZSn9gxQ8tEG/CPMjCiQM
 z8mg4qqX8tcA2QrLBnfV7L2c7SoC/2xF2GubW1CY1YADo9GJrkQ5TxjLdaXf0VN/1I
 GzQDnQ+EzLV225TKUAGQOUcI5rnAp8ki72pZlixNBWE3v+F/tSfANtJkYFZFsWihkW
 XlKfihSkSYilg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed,  5 Jun 2024 07:53:59 -0400
Message-ID: <20240605115415.2964165-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
X-Headers-End: 1sEpDo-0000CG-Q4
Subject: [f2fs-dev] [PATCH AUTOSEL 5.15 1/9] f2fs: remove clear
 SB_INLINECRYPT flag in default_options
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yunlei He <heyunlei@oppo.com>

[ Upstream commit ac5eecf481c29942eb9a862e758c0c8b68090c33 ]

In f2fs_remount, SB_INLINECRYPT flag will be clear and re-set.
If create new file or open file during this gap, these files
will not use inlinecrypt. Worse case, it may lead to data
corruption if wrappedkey_v0 is enable.

Thread A:                               Thread B:

-f2fs_remount				-f2fs_file_open or f2fs_new_inode
  -default_options
	<- clear SB_INLINECRYPT flag

                                          -fscrypt_select_encryption_impl

  -parse_options
	<- set SB_INLINECRYPT again

Signed-off-by: Yunlei He <heyunlei@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index df1e5496352c2..706d7adda3b22 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2068,8 +2068,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
-	sbi->sb->s_flags &= ~SB_INLINECRYPT;
-
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
