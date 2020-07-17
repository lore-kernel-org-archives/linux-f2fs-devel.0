Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC80C43446
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:45:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37B52070E;
	Fri, 17 Jul 2020 01:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="K1Xdt5zO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="gI6xk3xt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RZUs4vtl";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="rXOnRzGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37B52070E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xcLXFUUMgp7htsqf61QifpRm2vdZZEALnpwL1/U+Mi4=; b=K1Xdt5zOrEZuDyuqgPFrvwo7V
	qqSjqXDomdJhjlaQ2F01s/2lcfkWe5UdscdSEjcumpwZySSC48aTLCGTMeQvazT+gsCqrdrsKlqLT
	eMhfEcjqLZhrpKJM+PHj4gYs1AGIUdtKmXOLTCl5HsqclfgyK8jl2YK5px1lKMU1RK0/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwFRn-0002Ml-Cc; Fri, 17 Jul 2020 01:45:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3zgIRXwYKABcFxGLxG3BB381.zB9@flex--satyat.bounces.google.com>)
 id 1jwFRl-0002Me-TO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E/vVSGidxRNqfgFvT7W0V9puYBqKI9SZ+5JR8j0m+58=; b=gI6xk3xt70Q21bUCi583YrfvT
 +kDdsI7b7yai5hDoUDYPz1kJhxvDIwycJYUhiCEdo5spUzrxiJ09oQCPR8KAAQpPxH9cWij/itVOe
 XV4V49GyAS/53j6hXSX2u3+3vtdFiXao8sROXDnAko2oV7unH18dSu/8MiLW7U5sGhV7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E/vVSGidxRNqfgFvT7W0V9puYBqKI9SZ+5JR8j0m+58=; b=RZUs4vtlWwGQa8Jnt3BwL8HsMW
 VNCSLqbgPuronoaFrlWWPmfBxqQ/F8f2zdJyUTdobCroAKxXOcS5LmLKQd341AXsfdLInWHM1swNY
 RoziORR+wG8VQp0UY8wx19y42k9RedLeei+jjkLeGwAf469l9LFsHRLQSI1IaEL8V54w=;
Received: from mail-yb1-f201.google.com ([209.85.219.201])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jwFRk-003lgl-J3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:45:57 +0000
Received: by mail-yb1-f201.google.com with SMTP id m81so9523534ybf.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2020 18:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=E/vVSGidxRNqfgFvT7W0V9puYBqKI9SZ+5JR8j0m+58=;
 b=rXOnRzGGSVHFJDvjXi4FvAGiqdTyNugg4+H0mP1UFF0jhZqf9ep56wXd9XJvPMyF9T
 xoS911Id97Dol9EvPK1vd9h8gYYCgaetjB+K7vw/2qAXsNebgviKIpgSa8h1ymO/I+8I
 YIvRJ/hkbtBJWlgnuyDv5HV2cXOcz+N4IrAcNQRZxLAp4EnHNbfG5YnAhJhBgTy+Pigv
 4dn1Nyu0E43LGnaBzxcuj3jII3vy8x6cX2YbN3ZtFyf4Ma6kXhDkX1GxK6J3lUHQ4QI1
 hToBCY+cUvVQkmT2ab6aVu8YcYHCBu/i3YrB2ksRrALG3q7k+9hHw+zgqJFmE7H4rTqX
 0wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=E/vVSGidxRNqfgFvT7W0V9puYBqKI9SZ+5JR8j0m+58=;
 b=bFxDEqItC6onsxWsHJzUnjJceaA7vgi/bbs9lE7SGhldRhN+rV3S1G3HYAoQ6w6uQk
 B6HWt/8eliR+iSjuR1ufg8DzYYOk8NWMJReABIKYtxI6gdxC3fTFBEiNhGV1sJbm3tVi
 PMTR2OZa6OpGg06st9JSeYlCLO0futjKHezs/9hsaUesOlOzI3jDyxaR3cYIcHrESg+i
 k8/1KVv9s5r9N4gL4zkvSKgdOT5fcCr46JQXmDnhS3ka1f3Q2Nw+d9P7+85HQZnavpb2
 +vhr9tbw5Qmbi8iizPYQcCgV6hmo1TSk+Lq0vl9to5S6e+l25pkcljgLN2PoCDYvlM7i
 Ma0Q==
X-Gm-Message-State: AOAM530uxsNhXhDn+lzlcF53Qd7ho+Pp8wFfyl29iXJ58y70L0EH7woS
 0iynIMpGflTCEiRuyI0x90f/jnX5Cpo=
X-Google-Smtp-Source: ABdhPJz7acZLc4vxa6IsZoed6dq0Yjbsxw2KarLtYNUW50n+ZIWBzgAyIfxQtErgMIINdMcscSoivVp9TXA=
X-Received: by 2002:a25:7d41:: with SMTP id y62mr10756670ybc.95.1594950350852; 
 Thu, 16 Jul 2020 18:45:50 -0700 (PDT)
Date: Fri, 17 Jul 2020 01:45:37 +0000
In-Reply-To: <20200717014540.71515-1-satyat@google.com>
Message-Id: <20200717014540.71515-5-satyat@google.com>
Mime-Version: 1.0
References: <20200717014540.71515-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jwFRk-003lgl-J3
Subject: [f2fs-dev] [PATCH v3 4/7] ext4: support direct I/O with fscrypt
 using blk-crypto
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Wire up ext4 with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/ext4/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..d534f72675d9 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -36,9 +36,11 @@
 #include "acl.h"
 #include "truncate.h"
 
-static bool ext4_dio_supported(struct inode *inode)
+static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
 {
-	if (IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (!fscrypt_dio_supported(iocb, iter))
 		return false;
 	if (fsverity_active(inode))
 		return false;
@@ -61,7 +63,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		inode_lock_shared(inode);
 	}
 
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, to)) {
 		inode_unlock_shared(inode);
 		/*
 		 * Fallback to buffered I/O if the operation being performed on
@@ -490,7 +492,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* Fallback to buffered I/O if the inode does not support direct I/O. */
-	if (!ext4_dio_supported(inode)) {
+	if (!ext4_dio_supported(iocb, from)) {
 		if (ilock_shared)
 			inode_unlock_shared(inode);
 		else
-- 
2.28.0.rc0.105.gf9edc3c819-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
