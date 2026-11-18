Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61F606A32F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ksv7GIJ5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TyrjTPwr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=C8Z3DLjy;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lP3GMpvF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XgJKKuUt1M4YcHbF8ZrF0bbpnibBFa2yUfeK3j2zZe8=; b=Ksv7GIJ56goWUJtRYRXRFkK50O
	SSMawhj62jDZhfB+2swBbRdqHsGqx8U2kBzaOVABFNbeNg8Rr+waFVcG2rWC+2WDT5P3CkgPemSMo
	crt70GI9UT/LombkiLJSTf9bqFvKxMvPx8lfORRN9lGc+WTfp8z4geaMBJmdEaQSwkEM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTTYi-000000003Ay-0TmF;
	Wed, 18 Nov 2026 00:29:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <blum@kernel.org>) id 1xTTYg-000000003Aq-2P7t
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7p8hzQulzm2sdT6ljl53TR4xqlIGw1FUKTCUNJv0MWM=; b=TyrjTPwrqVHoXTVAC3rB8GbGee
 kvZTXq1TsFvUZv+aZ+m10BguuwBj75DYpmtQ9aUcgK9sJE0pDYHO+En6cwzKps1eRwZND7I9YEV3Y
 3VKdDMK5sAtaCLHaPBPVed7jCoQLvre5HsmUH7Yadd52n9amJCdUJnFn0Qv5z3mlid60=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7p8hzQulzm2sdT6ljl53TR4xqlIGw1FUKTCUNJv0MWM=; b=C8Z3DLjysJv9frL3TPJhQNPt2W
 SwLHiVRbkq6e+yC7BVFTOHPPn8ICWSQp+lHmz5ogSeCDOFPYpthqxrUJIHeaT96J0iG5mGiSDixaE
 H7RLw9iG2aJlp8itP+UDQvSIaW6U2wOqrQ77Ll37BTa8rA+fce+VUb102Vubdae3EAWc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTTYg-000000005hx-0l7X
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DA2E61EE4;
 Wed, 18 Nov 2026 00:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7411F000C4;
 Wed, 18 Nov 2026 00:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794961788;
 bh=7p8hzQulzm2sdT6ljl53TR4xqlIGw1FUKTCUNJv0MWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lP3GMpvFvIEPM7v98/UaUS54HWXwJpqZEQTCiBzDHxv72y1Q5Hg/7gI59uQ8+G2rU
 wbCh+AFvdJ6fdXjpEhgrDLxOu552gaoMCfkXw9ZO7mGtKfG0zH075ffsllhlYYaJnZ
 siJEsDxgx0HtMFa1D6H2AXaCdAdLgobMe19vpXgC2CSAYPImdBNAYxfHyGy6vJ2Sq2
 +1NmhPrUMwKjHWXduX8i/oAJ2URl3dfBOrj3gT/B9dX+QG56gF+tL7emg1tvHDMVl+
 pZ/Ko3CglaLOm2d2CdAeQpNN/THkB/gi9FBCAMTaQOKe7eZzCgf9ePjUjX2NuHgHFf
 4fQ0Brrss7xVA==
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Wed, 18 Nov 2026 01:28:49 +0100
Message-ID: <20261118002845.574426-9-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118002845.574426-6-blum@kernel.org>
References: <20261118002845.574426-6-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=blum@kernel.org;
 h=from:subject; bh=grfMiZcoagjGMDC9TYISjWneu7iyoRjVgpowfER1HnI=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl/PtrvevJS83nhl+U99vkmJ9OD2jemKS6ey25/41md5
 iWNvB9fOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAie/gZ/lcYZ7kVtX8pmD7l
 AjfbDl2fx3ciG1d9KN655ZnnfR3eTFtGhgMpL/f6HXcpsFg+ybi2vOhk5Iqz5hyf9+5Q2SdUuZf
 XiAEA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTTYg-000000005hx-0l7X
Subject: [f2fs-dev] [PATCH 3/4] f2fs: Use FSTR() in f2fs_do_make_empty_dir()
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

Replace FSTR_INIT() with FSTR() and drop the hard-coded length argument.

Use FSTR() directly and remove the temporary variables.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 fs/f2fs/dir.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 97f7fef6b068..469c4cc7a3b7 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -515,14 +515,11 @@ static void init_dent_inode(struct inode *dir, struct inode *inode,
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
 					struct f2fs_dentry_ptr *d)
 {
-	struct fscrypt_str dot = FSTR_INIT(".", 1);
-	struct fscrypt_str dotdot = FSTR_INIT("..", 2);
-
 	/* update dirent of "." */
-	f2fs_update_dentry(inode->i_ino, inode->i_mode, d, &dot, 0, 0);
+	f2fs_update_dentry(inode->i_ino, inode->i_mode, d, &FSTR("."), 0, 0);
 
 	/* update dirent of ".." */
-	f2fs_update_dentry(parent->i_ino, parent->i_mode, d, &dotdot, 0, 1);
+	f2fs_update_dentry(parent->i_ino, parent->i_mode, d, &FSTR(".."), 0, 1);
 }
 
 static int make_empty_dir(struct inode *inode,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
