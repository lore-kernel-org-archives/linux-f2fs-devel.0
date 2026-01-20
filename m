Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D0D2ED0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYvTlfC9NkODvTIHJj0x6B+IzdTpuB0bXSQl4Radpjs=; b=SWErwqlh4l2FrzdmCGxCvb8o6Q
	kaP+VqV3QDBQMUBO58nV1kswAT5WAdDeSzpJCFsHChOnKSWmJ2kMnNg8NAUs+jKcHFcXLxQNjGU6x
	qP/x5CYIi+1FaTT84/JZmXTS6X/SHPrjUp8oAXMlUKFcMyd2M1HteV4CPqNu7JVGbALE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viCfZ-0001pk-MO;
	Tue, 20 Jan 2026 14:25:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1viCfZ-0001pd-6Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 14:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NQrI/+7WeQaJB596FTi2DAhbHcMUZQhfUrqaUbvlSM4=; b=bMakFJtNG5TAuf+l7sPHMWVhvN
 MrTffGDuVlelweucjmJOwFr+6RYclC/9JRqVS5cn2j+GsiTHfOLtaA9uZ5qgHrq1pJlSsJ2IAPoUF
 VflIDg13DW6qoStWBj6QRKAslcl7QxZ10EGZdhPX/+QOu4kuRm/MN+GlWYe5edGeskcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NQrI/+7WeQaJB596FTi2DAhbHcMUZQhfUrqaUbvlSM4=; b=A9t2ueJZLmYUXxDh2Xk4WI3mnB
 xkpmkyASMz95xlq+UpmV7i9Q4fgFRUNFFYkkVPOtzRCsvYRhv+zP3DoetDeeDIQ8vo5SR1Mid2gLV
 Xx1h38MQfqQn7lPKT7k59/VA9pAQs6phAFjTAflcPXuGCyDjJjHVjduiLqmT3ro06hAY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viCfY-00086k-PA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 14:25:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 344E06011E;
 Tue, 20 Jan 2026 14:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFADC19423;
 Tue, 20 Jan 2026 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768919109;
 bh=YDDyyYB+YVCQQ3bOYUSgoPwx7V5Jm2aE0B8Vt/Q0AHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SY6i7aN+d9WOHv1eU7hTAHMOFXQ1yC4K6sV0MhiCE0y2LFGnxAYRZWUar+q1ekMgl
 sIhwIW+Rc977By+4dnmA/mmN/1CeTt66ZMIeFsA6P85HkRP2KmjcaGzBKtd74o4g72
 XjX6iE0us1CYsNa0ieWfeV/AQiBVuWSuQseQ6yG3FArxQmmQGDo2idoZqnfIxePKLs
 BnffXXPVeC2BDkVKgyeh8OG5H8sS2E6eIakG6pgYIB+eQpeKNXnDgycg6Qyk7NIfcs
 p7XfYnOSDlfuFYlyqAQSWsbXe2MnZkpjraFNUORS2u28WBkvB3T/2jpM+FWJZ0570p
 etqskw12yQVfA==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Tue, 20 Jan 2026 09:24:34 -0500
Message-ID: <20260120142439.1821554-12-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120142439.1821554-1-cel@kernel.org>
References: <20260120142439.1821554-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1viCfY-00086k-PA
Subject: [f2fs-dev] [PATCH v6 11/16] f2fs: Add case sensitivity reporting to
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
 tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
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
