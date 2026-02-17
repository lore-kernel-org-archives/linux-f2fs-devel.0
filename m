Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4427E9A03E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+O3ci2HFYwiM5XiH4kYVyIMjJs43pbzE9nqtJSpcVc=; b=gLl4uCi3Gv+4VaAY/xo2Nkw/ZO
	m2Wqe+JeuMQVOtkdGPLNtq8Y9fTPAHof+qdSR9Liedh4LBjROuWTn291XmMslzAjXmpUHiZHWvQ62
	WjXM0Pd892Mt0XwkIBl/d5IptLFuySFfLCVA1n0ykFdyKrawyQoZn7Rn3AZTqPLSZF8I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSva-0005el-IL;
	Tue, 17 Feb 2026 21:48:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vsSvZ-0005ed-BI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:48:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NSr2G4ClER26IEkVkIzxkYDfbAmuLF50i742VXYTTg4=; b=V98wG2AcHpQyZluC1iqRSVXug9
 0Rv2eabouj5s3ewrqViMshUXvf1qwVEHu/YusVmnNKmyxWi630RVs8j0eOzMRJ4QXnFBA/t/njvuo
 rVFWl5/OV+a+HSbA5hpdYaTV8Qel9+15ZR3YRN1aKA1kVZbZWTS9VHUN1chlG/bYl1HU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NSr2G4ClER26IEkVkIzxkYDfbAmuLF50i742VXYTTg4=; b=FhgWTzXz9nz492Boe+GKRiwbop
 0BQgtoM7dziHChRDyyGPG2BXjFeP7YgtcGh84o2cyvBTDAeL/aBMsCjx38h6UpzJoYAkcA42ChFkQ
 CM664Pj73ehMO1k8uWNT4J09ofNqa6XTBl00wojgbMhKue5PeWSn8W9qmCEvytXoqufc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSvY-0002sp-RE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:48:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 96CC36185E;
 Tue, 17 Feb 2026 21:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A2AC4CEF7;
 Tue, 17 Feb 2026 21:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771364896;
 bh=n04q8a+p6qCVMgSwNlacj9uu+Q/c+XUajaXJJwvQJWE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KSXHmwqMTL34fPCG5ePu5E9GIfqCfBXJyVffUYXD43ZGkvYtnbZTcb+CNdyeMfuEK
 sk58JKp93fHQYOC8rhEx9jp0/UBnUstvcs6i6jCx70hqqMrB5e6k+Tq93bBopYm/cf
 F1XP3+a2pL4sUquo8aEysgFOKhWCG8piwp9Jr6pB8Ll8xjEEYf8QeB+j8QNEkoTut7
 qQfaWdcJd0snnBdKfbFzv2DUTcff8YPWT8hRQEtnAsC7GlXWiwixliQVs98FtpRy7R
 YUgrZZPJ3IV3amJjKzwKdL3aF0GfX5NP/NWcAh1wvYf2/YWHBsC3jWi9vrAoKrQKHX
 ZQHYUR5bmZk4w==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Tue, 17 Feb 2026 16:47:36 -0500
Message-ID: <20260217214741.1928576-13-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
References: <20260217214741.1928576-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vsSvY-0002sp-RE
Subject: [f2fs-dev] [PATCH v8 12/17] f2fs: Add case sensitivity reporting to
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

NFS and other remote filesystem protocols need to determine
whether a local filesystem performs case-insensitive lookups
so they can provide correct semantics to clients. Without
this information, f2fs exports cannot properly advertise
their filename case behavior.

Report f2fs case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. Like ext4, f2fs supports per-directory case folding via
the casefold flag (IS_CASEFOLDED). Files are always case-preserving.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/f2fs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c8a2f17a8f11..f7f616e041dc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3453,6 +3453,13 @@ int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
 
+	/*
+	 * f2fs preserves case (the default). If this inode is a
+	 * casefolded directory, report case-insensitive; otherwise
+	 * report case-sensitive (standard POSIX behavior).
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
