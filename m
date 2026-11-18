Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEA606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F3I+0NYK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mOfIrztk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SqyKOedy;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuEw1cbt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8304BOyw5E1aULJ8chtklku0MDY9Okeopv+eRTwmBnA=; b=F3I+0NYKQHRgmq0gD5R4UWUrwQ
	R7jRwEshkYETFJMNIE76r38hPa1LDNMW5Uh0ynqxNSvGnpZ6ah1B2pljNIZMI+yQ6gdQxOLUmzOnf
	soTEsy2KeobL9233ti/sxuyH0poDR4XHgdl8RB4+GMwc3Lef+/wR0VVnS9pvZjvduhCQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTTYm-000000002cn-3290;
	Wed, 18 Nov 2026 00:30:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <blum@kernel.org>) id 1xTTYl-000000002cX-2f3z
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XgXrwef3GSdcgoeGpprzCP9+LfeU52zOGFONlLtqopU=; b=mOfIrztkXVcgWX85PaPACkVqR/
 Ocy4YS1+B+RcLXwRLuQBsgu5A1kCOZxOFGH2SSNNCJ+6LzzuHqzRzGlQ9Zz0voGAKZrBZvD7w/Cu6
 ZK1vULCScu47uoRC3LX10m0ozh7Iw1C5aRF2hXGjmMB2SaVJehwApbxJ3osli5KfaEdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XgXrwef3GSdcgoeGpprzCP9+LfeU52zOGFONlLtqopU=; b=SqyKOedymf6FYouarFjwWdF5NF
 j9euNbLWz0T6rrSNJ4KEvm+yfDZTY4XIpre8JpzQGA1w9352mwW+S7PISEORYUfkv3e52TaKBdGQI
 ysYEFcJ8lMHa9oRVyIeqBjdfab7uiEV7xuJKo0HW1vH3xGbSnXn5qWKZj0Wr2l90oITA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTTYk-000000000jf-1455
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE542618FD;
 Wed, 18 Nov 2026 00:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270F41F000CC;
 Wed, 18 Nov 2026 00:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794961792;
 bh=XgXrwef3GSdcgoeGpprzCP9+LfeU52zOGFONlLtqopU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UuEw1cbtOFp4TZZlU/lzFOH+uJKcG6CGL/dfukobmupQG0yY0iLuhvoQ1vXICETNR
 huuTvtM41iyL42N95j/ndGletCBCyM+71NEYMobYA6J7/OPxVSzLyOhqTtQ/2NDFAf
 T6difwT78ibb3hHwyqX0+VGrFM24wltdIQBBDx+5r/ze70jFJkLM/o19zhIWH52B/t
 rfWG5izVuLLEA6eQEYVpZxu0VjX4XCeWGuQ7Zre1OkeSPsN8L9k/Vt9Hj3nl0SNTrO
 F5uMdm0Lib2MG25zvXue8MJTopqXYdFwzI2n16+laauBVKG1syMvA7SxevwJLcfzIi
 4YHbDl/scnfUA==
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Wed, 18 Nov 2026 01:28:50 +0100
Message-ID: <20261118002845.574426-10-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118002845.574426-6-blum@kernel.org>
References: <20261118002845.574426-6-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; i=blum@kernel.org;
 h=from:subject; bh=WDBVonVI9poJWjMd/98XRPyVKKRQHMEiFwUXmeGohbE=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl/PtpzGvoq1YpZXE1nFdg5d6r69nbd31K6j/fFReVcE
 D379qVqRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExkbg/DP9ub5Yd2J+94fCW0
 24VFvituzp1C0eIpyftfha255JrFr8nI8Le94ZLGTtPky04bWC0Ui/6bTvNMPFQwUVuHdd+ZGd9
 O8wMA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTTYk-000000000jf-1455
Subject: [f2fs-dev] [PATCH 4/4] ubifs: Use FSTR() in ubifs_xattr_{set, get,
 remove}()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Thorsten Blum via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Thorsten Blum <blum@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace FSTR_INIT() with FSTR() and drop the explicit length argument.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 fs/ubifs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 3b0e8a270f59..036eb7e2be0b 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -252,7 +252,7 @@ int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
 {
 	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
-	struct fscrypt_name nm = { .disk_name = FSTR_INIT((char *)name, strlen(name))};
+	struct fscrypt_name nm = { .disk_name = FSTR((char *)name) };
 	struct ubifs_dent_node *xent;
 	union ubifs_key key;
 	int err;
@@ -315,7 +315,7 @@ ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 {
 	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
-	struct fscrypt_name nm = { .disk_name = FSTR_INIT((char *)name, strlen(name))};
+	struct fscrypt_name nm = { .disk_name = FSTR((char *)name) };
 	struct ubifs_inode *ui;
 	struct ubifs_dent_node *xent;
 	union ubifs_key key;
@@ -557,7 +557,7 @@ static int ubifs_xattr_remove(struct inode *host, const char *name)
 {
 	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
-	struct fscrypt_name nm = { .disk_name = FSTR_INIT((char *)name, strlen(name))};
+	struct fscrypt_name nm = { .disk_name = FSTR((char *)name) };
 	struct ubifs_dent_node *xent;
 	union ubifs_key key;
 	int err;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
