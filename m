Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83BEC25B76
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:53:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sEpD6-0004JG-1P;
	Wed, 05 Jun 2024 11:53:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1sEpD2-0004J4-Q7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jun 2024 11:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GLqOGFI+f3uhDleWUoE0gqlMq96bZaIVXISN57oK7ek=; b=AlK/kLh7iCB2G1nzANoESDdben
 xZROke73CP3JCpVlQwcZiQaTbdKJBK6siePUjMFkRl76uvlPgQI9D+iXQr9aje8j9Ei0NJX4t2Vos
 5LUbqXRad0guKwi/pnu+2JFk1T1/O9e2dZEhOXvgtuayPKSCztQrqO/66mq0OsVN+z2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GLqOGFI+f3uhDleWUoE0gqlMq96bZaIVXISN57oK7ek=; b=m
 OgFHsuQRIIXJYNLCkKFLSMTws4eaoCYsd8u/vsNy4Fgp9KL/cvEZ0qk0edxQzlCmbbflfI4wHWtft
 Bvv95MrIt5z8eCmVCnD1l+wgmw908FzucwVRmOqhoxkLyqe9rs8xMjq+f+25263p5ZclmcQ6TQYzG
 HjB6srXsPG2/IkqM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sEpD4-000084-7b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jun 2024 11:53:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2298B617DF;
 Wed,  5 Jun 2024 11:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E4DC3277B;
 Wed,  5 Jun 2024 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717588415;
 bh=M4hUo4Sz5eXhFIXqPo6FLTorE27s5v5OULPRV+E2nas=;
 h=From:To:Cc:Subject:Date:From;
 b=Iqntjj3tXzsb5UX6gQEZst4eldgvzHKzusRrS03IgvxkiTyX3Yg1qIuixf64iHTth
 BAa7cbyziLitNYJnnge6wrgNR4SJWTZBDLZXOmQB1unNBASGi1wxakKOJ8cfZWFBY/
 z9kT/919ikCP7l2T/qkXcvMFYTrBD2jrJ53qPqm9zJy6YVqGnJ6JXnj5Muecf8xvEE
 IaD+yGXdsogn+u813Pi7qi31MDd910VXKIIwsiZwuZOIeaDPHKhf3YHANBcKBNC02c
 wgIc3Xjrn1CRXubKGDY2M90284k/BLQkBwpyVu6RfYv9NpeloK/wIfQZvd15uGHcWX
 4Z5cDv3vM+BFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed,  5 Jun 2024 07:53:06 -0400
Message-ID: <20240605115334.2963803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
X-Headers-End: 1sEpD4-000084-7b
Subject: [f2fs-dev] [PATCH AUTOSEL 6.1 01/12] f2fs: remove clear
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
index c529ce5d986cc..f496622921843 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2092,8 +2092,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 
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
