Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1FFD3EE89
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYvTlfC9NkODvTIHJj0x6B+IzdTpuB0bXSQl4Radpjs=; b=bwkpERf+K+560YUJD8r6W3EBMQ
	rutXuzvlYtUmJQwdP2foQcs/fDMeAZepJ5HyC4madO3lUxFfTrImJkpJXQjvbafSJvG/rERRWTB04
	g/8C/3qZt6kKi24cwmih9SIARnFhrsof7TNRs+IV1ZnWhsA33tpxJlJMwXKjTu2gSa4M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vix9z-0000PW-SM;
	Thu, 22 Jan 2026 16:03:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vix9x-0000PG-Vj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 16:03:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NQrI/+7WeQaJB596FTi2DAhbHcMUZQhfUrqaUbvlSM4=; b=mKE5gZdXKPX8ZKGRJI/du6ztSQ
 XQ+zRB/rwWdkHB48vd5XDJRhm9px7FxV4w6G2ETZBCaNvU47NvcDnaBnPR0ukU+AgiHa6EvmBMerQ
 vX3bIUXVwNfBaclnMGxTkqTd21qoIT8GDrDNq4EhTqmK2GldJ3MJC6cSq4+p7a7MOqsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NQrI/+7WeQaJB596FTi2DAhbHcMUZQhfUrqaUbvlSM4=; b=Z7bc3UWbs4nja0QlGtCoxuEgxA
 PbDf52PR9THAHlw1W8RjQBRGEREn+d8rNiMxRNiSYcD3Gco72/ZV9H+OUr3g1/e0QqqW/wkuCccCQ
 +WasT2LZVY/nUXOrREm0ipn5ltQ8b1GMc6FIlagsxjiWGUMQg8S4OLgGm9yXVFH1vBXc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vix9x-0000WM-Im for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 16:03:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D2BE660130;
 Thu, 22 Jan 2026 16:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E6DC116D0;
 Thu, 22 Jan 2026 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769097823;
 bh=YDDyyYB+YVCQQ3bOYUSgoPwx7V5Jm2aE0B8Vt/Q0AHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g/sLXrEly993FahgZPwCWJLYU6V+16O3RjK9dfQBPO5qkuryI+Sukw7w3Gukpme47
 Cc9dmFFMuvOQoakWSCiGslFdzmW9RxTFN2SdYZrINv0tMVCaQUsmmn+X0yRCwBu6Pq
 OdLmrxmJGAJCF9JBDaZL2b83T/7IsVqbFvCvXG1snKIpJ0jE9sX4kVwHFj5Hj1914x
 5H1gOP3LaQEpBnnNMc+xtyaMP2A61YUBZ0zI3/5x9R7lu9cJz36GgZL4+e1oSJPHYM
 +7z25L9Wdkp685O4WLv2zj5M9Bzq4I4r5ZbJtmd9yYp1OtmROzyKj2RNzvtsZhLaZF
 LC5BIjYMitvpw==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Thu, 22 Jan 2026 11:03:06 -0500
Message-ID: <20260122160311.1117669-12-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122160311.1117669-1-cel@kernel.org>
References: <20260122160311.1117669-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vix9x-0000WM-Im
Subject: [f2fs-dev] [PATCH v7 11/16] f2fs: Add case sensitivity reporting to
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
index d7047ca6b98d..91c255bbbf48 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3439,6 +3439,13 @@ int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
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
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
