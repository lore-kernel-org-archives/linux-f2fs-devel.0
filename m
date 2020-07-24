Return-Path: <SRS0=sdIt=BD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33505C433F8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:12:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060F32065E;
	Fri, 24 Jul 2020 12:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="JmN3W/xL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dm9I6ihT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QGnYL2fD";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="CIOYCqTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060F32065E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fGt0UU6L2FxV9NgdqE8ZO5BqP9ce7HiQGXGZF2h8yFc=; b=JmN3W/xLLJkGTtS3osB/xCi52
	3onWSgfnjBG+1o/RccpXvAowzHjYxmS6x6wjT8PQi/Slf+j2N973TS9cKwQi7gjK4kIAmxcmgKWTA
	49WUIPpyypJk0vdIfig8TFOTQG3DW2kz/E/GZCXHDkODsOfdE3P4i9kwjtsdETyscFXHM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jywYh-0002jh-He; Fri, 24 Jul 2020 12:12:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3DNAaXwYKABcFxGLxG3BB381.zB9@flex--satyat.bounces.google.com>)
 id 1jywYf-0002it-O3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 12:12:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r8Pg6JmNaFN8fVBskJ954zlZvlkSSoV1f+xmIU4eJ8Y=; b=dm9I6ihTo8i4QK0eVIqSq/hTc
 8Yq/d8cli9GG9SjzcMR2KytTV6JDo8McGR3jwhQptGsNeTUr/HP0deEFUxuvkU5FEYaAwJFTlpQyC
 dAF+sZMYjTxemZuI5eDjZI18dOc3Prdm2PXtINHaUhMyrL5xlbptx48F31FKNit+QHoiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r8Pg6JmNaFN8fVBskJ954zlZvlkSSoV1f+xmIU4eJ8Y=; b=QGnYL2fDzAMLwaiRx0Kte9Dr7o
 kcaLEIPFtgIqBPkh+xLrQZs2A57QRPl+SZAjYg9DrUk00sIEKPHXYV8tct0V9eTSzeDfEgLCU1ywT
 MLOP5FJGUF/Tr7rNncbb56j31z2SrzG5Or0trEo87aIlBKfizWaeery/hoFe3r9JbnI4=;
Received: from mail-yb1-f202.google.com ([209.85.219.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jywYb-007Vba-8m
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 12:12:10 +0000
Received: by mail-yb1-f202.google.com with SMTP id w35so10165791ybi.16
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2020 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=r8Pg6JmNaFN8fVBskJ954zlZvlkSSoV1f+xmIU4eJ8Y=;
 b=CIOYCqTme+TnWuKD+xZRysHr8oJo78rie88iaMhNzTS0t45MoVE4RsI/vEVkYotMFZ
 JtjeVNk6dL7xq1AR4PQA6w+exLdpvxRctrNJ2l6hVGYJMGeMH8HU4Izlxs39K4/L9Csg
 iaeQxhWNQr4udHFUBEXYDh0it42hv4TuuYRMH3NvOqxfOT5YQZZhuwdUvMZocLeHtm1+
 wWhBEQsXnDrUzdith9nAVMQtoO0aXYKyWzoqdOJxpf17R/DHVuV6ojo2ym2rZkevTwWN
 dbBmJIWEZR4a7YLOBF2DNCau1fKoD6S7dcgLT2jQsSAOFbzYgqxPmojFzvDL5GEfdwZp
 Xzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=r8Pg6JmNaFN8fVBskJ954zlZvlkSSoV1f+xmIU4eJ8Y=;
 b=cytymhUf662AYX/Nfa+QzWkdj5gftFEzXE6zTfbrqig49xJx5Kqf1BSyH0ysAg4p48
 pONEwgoTxL7U9IO9o3aA6vYqqIBkQgXkFRfGtqUQrnrxyrbQr02EuJNbmG5X68SjD+kR
 Mwc9UCb8Ys55jhZVt/irtsC4vx9b8fFzxqHGO1aayFhBD4jDSzrKaMGuOUFvqdma8CWi
 jaMUaHPe9DXyduV6tPt4m4YaDka4WbU4ddP9fKFx0GlV37htAWf0ykj14U5T8cWkCgS8
 emXjxxH9t2hZIWMMvWA2iyf+TSLoDGE5mrpl+z3MZaQtUZLK9T03E/kQiQWK7lB8sXLr
 MOcQ==
X-Gm-Message-State: AOAM530nfGy0qmPsHzGehbZDPEe825o2mMgUSZ6nrTbIOVuo/tLYQApX
 xMz0xqhNEKOhxtpHmfhCUbiK8p1iE5I=
X-Google-Smtp-Source: ABdhPJx/KO6QnXMM0Pc1pM0nRqEcHHdAJJmtmE+sSNw66/LnMCl7LqpQ2/7JJlu071k/LdTupwpYQ4l/YFY=
X-Received: by 2002:a5b:74a:: with SMTP id s10mr15292910ybq.101.1595592716305; 
 Fri, 24 Jul 2020 05:11:56 -0700 (PDT)
Date: Fri, 24 Jul 2020 12:11:40 +0000
In-Reply-To: <20200724121143.1589121-1-satyat@google.com>
Message-Id: <20200724121143.1589121-5-satyat@google.com>
Mime-Version: 1.0
References: <20200724121143.1589121-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jywYb-007Vba-8m
Subject: [f2fs-dev] [PATCH v5 4/7] ext4: support direct I/O with fscrypt
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
Cc: linux-xfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Satya Tangirala <satyat@google.com>, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Wire up ext4 with fscrypt direct I/O support. Direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

fscrypt_limit_io_blocks() is called before setting up the iomap to ensure
that the blocks of each bio that iomap will submit will have contiguous
DUNs. Note that fscrypt_limit_io_blocks() is normally a no-op, as normally
the DUNs simply increment along with the logical blocks. But it's needed
to handle an edge case in one of the fscrypt IV generation methods.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/ext4/file.c  | 10 ++++++----
 fs/ext4/inode.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

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
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 44bad4bb8831..6725116ea348 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3445,6 +3445,13 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * When inline encryption is enabled, sometimes I/O to an encrypted file
+	 * has to be broken up to guarantee DUN contiguity. Handle this by
+	 * limiting the length of the mapping returned.
+	 */
+	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
+
 	ext4_set_iomap(inode, iomap, &map, offset, length);
 
 	return 0;
-- 
2.28.0.rc0.142.g3c755180ce-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
