Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B55C44507
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jul 2026 02:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PrFtzM7qtIFfeeTCuuG0ShU00q50APoQQNIitknKrso=; b=DzvA66qeqc+0eHPW+wqWNXiBvp
	ya34Knpdk3biK/NU7H/nwgyl+CxZXrpc3Mwi+9nzRSwuAI8oLLo6PJXHoSGcc/ACp98yGHzvrhZy2
	OPZMbvee/MsjUphOaqRym3wb7HzhEe/NzoF4yI72ab6b0e3xWZMum7Dsfars3ebwpwDE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wkCJs-0002Ru-F5;
	Thu, 16 Jul 2026 02:59:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1wkCJr-0002Rm-42
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 02:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sea8lelRxE+zBLv16TImL7g/EOZ5/pZo8t/0pWuCD78=; b=dcx79/O1n3L50cEXYxeaFlQvTB
 1p00Hsm5JxiJK4IicQ0IY40CiU7ueNddJCkWUVUF6QZLyE5r+/K/XEKtOKGgX0+TwZQTxybvYojgc
 0ZCmkoOmKxBhp2OhGLHmnGsfQo+MtsQj2JVyHw3SMCfdPw802ufbtdJ5VhEjuhuMDKuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Sea8lelRxE+zBLv16TImL7g/EOZ5/pZo8t/0pWuCD78=; b=K
 tPbrsLHJB/EtzSQ6bvmbX8IkahGMSSq4Piin3k+TkcwGs87y258QCIY8Yeg96HFxZWakPibT9REdW
 pv9tjNqkurgc4iBK+OOMEbZ3eNx+irlEn+wJiQNSM2oz1esw3xQ48XMqRYJaGKNdCp38wZIyAD9di
 LbDhkkpgOyHclExw=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkCJq-0007Lv-DX for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 02:59:27 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cc891373e0so73361635ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 19:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784170756; x=1784775556; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sea8lelRxE+zBLv16TImL7g/EOZ5/pZo8t/0pWuCD78=;
 b=rPSRGOiwQWt8IEGJDNPotPAATQnaPzDmBW5Y0nHqDTiq8Q2unAaAEro13cBpb0O89b
 C99ZjaZ3jc6Cm3wNRaFEQirIeQYXDQoP/kzrmae2XojnCrblunh1poXMP9FeuGwKkpVY
 aRfYBpMgahB9ccuMrh9+yTifOdfHZ1H4zyuaCk0Aun5Jjut3sjAy8nNqxFs5cduKzBRk
 Ok5hIWPDStsDPUxx1A7wrVdZfVxKeHBQojKLhEHQk1gl3ptB1OaYEwPIREa+iy4J8pov
 OnhBYaYfXW5kZkPm0bEwOsRLJKXHdibi/0Fx9xMO34/Ix8W0OOziVbMFQMtU/ESaVF83
 5NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784170756; x=1784775556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sea8lelRxE+zBLv16TImL7g/EOZ5/pZo8t/0pWuCD78=;
 b=VYjYkLbxoBATS4qAYSECm392uYbMKn6GBKR7xMIYgtfd+2QNVS4yBmlNv/82tH1y6n
 8tTBuYHOfQxFgbcr/d0RoKwZ7H2L3AEEownTmJCTVjAHVaDsxIgug9gCHulfsvFkO050
 cpC3ENl+uP540WbyqlK3tS2N9xdi3qs94xl77w/m1ZW4d0yN+fP/HWj9kZFl05hsqU7i
 hJRbvXveT3CRuzxokTbWYoi3MDhKam9bHEtsF1Px0lt1JAjah1FxdMIC8cuKJLaHkjrB
 nzohUAKpOn9LNRlC6hKvHd75yzcxx6ODOEIzjKmh7Csye7AYl5LQH/8Wv6pS1akzc22o
 JGpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUN/+/jtruajPuC++dx4zHeYoGV7U8QHQR5fQi4q77mNrTywnehXCwQWYqCcKEpAFxrKqnIs2voK3+6wHZhqT6@lists.sourceforge.net
X-Gm-Message-State: AOJu0YycCNij/naRTUQzlx8DW4TlxUNudKudbirMhvESXBSkn9LD9BK3
 8ZKpk/DkWgBWUqZzu9SuUE4zxOmymkHuvgmS//TdFBH/5ViaNMqjTsbF
X-Gm-Gg: AfdE7clDJc8wY5P69zYDA0VIvZ3avlpZ8plGw+FDEVpaKP9/utQNnoD8cb78KfVMhSj
 KyLik3UbJXIC3dhbPCy6WNVBx6j1V5hy/uqfrK5TvNn483RSdVAaKQ65J4/qOfxUEQX4p/8eCU5
 Ykk6neAWC6rpEUZy3Go7AmV8qMHH5C5k1ak6Pv0JZVcnZig3MO6brxLMp4uMBczTRK28fON8Z55
 A1Ilqv2/uqBMAScZfF/Ma9j0oPeBs3aZbeppC1pNzVGml2MJbdLVqS8GB7f2tk1xrnOSJcFbus9
 ECfRDMYfg8JAtDe8aHsT2yOKZBZsiRWYN4oP5yVYnQKsTMpl8geQcI8CvasvjRTSZ3+pBM2Zg3T
 PrnC5z7p4gc8PbeRvmheEYyP3CGdyA0TTpjpTBWIShyoSu4bLhmhLW7MikL5B8O6f8qT+87ZNaH
 3nydXKvyipgZiwjg==
X-Received: by 2002:a17:903:1a84:b0:2c9:d8c6:1dc3 with SMTP id
 d9443c01a7336-2cf03aee8cdmr48274875ad.0.1784170755668; 
 Wed, 15 Jul 2026 19:59:15 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf10731540sm11688685ad.81.2026.07.15.19.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 19:59:14 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 16 Jul 2026 10:59:08 +0800
Message-ID: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wkCJq-0007Lv-DX
Subject: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner check in
 f2fs_xattr_advise_set()
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
Cc: Christian Brauner <brauner@kernel.org>,
 Zhan Xusheng <zhanxusheng@xiaomi.com>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_xattr_advise_set() calls inode_owner_or_capable() with &nop_mnt_idmap
before allowing the "system.advise" xattr to be set, instead of the idmap
that the VFS passes to the ->set() handler.

f2fs supports idmapped mounts, so on such a mount this checks the caller's
fsuid against the unmapped on-disk owner rather than the mapped owner: the
actual owner can be wrongly denied with -EPERM and an unrelated caller
wrongly allowed.  Pass the handler's idmap instead.

Fixes: 01beba7957a2 ("fs: port inode_owner_or_capable() to mnt_idmap")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ed33e5110f2a..6728d1488cad 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -119,7 +119,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 	unsigned char old_advise = F2FS_I(inode)->i_advise;
 	unsigned char new_advise;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
