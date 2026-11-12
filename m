Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D2606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a7pqZoLr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y6EOf71j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LRhoyF9b;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cMyIH00u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=seW2T/QFufSTR4X09FyST/KHChyrOOgAVykiy7ZxLpc=; b=a7pqZoLrm5kVG7f9fb2RifV5g9
	ZeTfyBDFjrgOaxCsyKXS02z+FS1M55iL6pqAcUUvn2Kb2oR1coQnwGLI7kiFvWCOdySQsw7Nu+fh2
	4V3tNkF6ui7uGSUdgZ0pITOh6vco8+Zn+dj/E2r2fjfiNjg6ixz63tKsGXyKYPHAP2K8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVxC-000000001g0-3MJV;
	Thu, 12 Nov 2026 14:39:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3Zs_1agwKADsgmorpXhltphfdlldib.Zlj@flex--jprusakowski.bounces.google.com>)
 id 1xRVwk-000000001eT-1Ry2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aU65DXWpgUDuu4YacradlXYGME3zl5bqQYFhid78PgE=; b=Y
 6EOf71jnj0fuAFghMLi81xAK3uDGIC5duCtaPCmYiDcEi2LuKctD6bcmWXkIHJksL7ocKyEHqDzOX
 u0KWC9DcdnfKoGmqld7RbYVXyJkovwSFvFj1LLhjVfMwpBCGKtWDaBUHX4X/avwk9HV9YrOOHaFll
 4qgGdP8tgNkeIMXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aU65DXWpgUDuu4YacradlXYGME3zl5bqQYFhid78PgE=; b=LRhoyF9b4QWILC2nxtxpt5ry7t
 nroaMwwc23gu+Qh5ybyP0sCnKrjQbCpYPHvqVpynBXL/TtXWFU29G4n1ZwrD9P/AEVtCggmfHbyNC
 B5HzI2Qr4RjFMIRflTRE2Lx7e3obp9N1Vfbz1uVK95l92btTM63Dm3BClJ70gERGrejU=;
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwj-000000007rv-04sZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:38 +0000
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6b6ed7a9ffaso4351303a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494310; x=1795099110;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aU65DXWpgUDuu4YacradlXYGME3zl5bqQYFhid78PgE=;
 b=cMyIH00u5gmLmoPHMlzXMRSLO2wepESKmOIeBIDPU/+68lvRMffa8SXZE03XCZ4N6+
 BtWkRpkWl5tP3n+U1tEs4p41WuaD6IxV8kUIw1e+Bm1K9vsf3+9C2BjxG5vkkGUK1FoA
 OKF9oeCmQu/k6WlkE9lHjHHw+rbrGsnBnBBYxEz1qsDmq2FWPoZFIeMe+O/snQ0GjhuZ
 orz0Gz2xRp25HIfIBl1Kiml5tufHxGhpXryPsuEn09E8C5mMEawuxr1izVH4iM+vibjZ
 W3RH0YYi2c4d31JaipnDFHexFQDJoF2aVZ9waJC+KEgXkNGtsxPEi0A6Wx2StDqIDDlp
 76Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494310; x=1795099110;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aU65DXWpgUDuu4YacradlXYGME3zl5bqQYFhid78PgE=;
 b=Q08NdbkCFLbb/L+ivUS9ne7+uv9nxiJRJuCcQKZpI8Sep6dIS6zwkeHYo5k13d0C3H
 LkDxFEGgngc26+xg9ygkmsM10KGktZ5souwgQfJ4Esz9r9xxscikSUF5MNoZqLVnUqcd
 H9VOaM06xobZW2R+JqLMo8Mub1SPWuMhnwXgtidC5bjDseaTUkFCTAXCmeXEYKzO/lSI
 MinVsDbKmVtUzPsnY7Gss/0nAL8r3KBIOkeuTgzOII/eF3FfDh4ex7mhVOkKNthfvbCs
 lMynQjdjagK2cUe5y/DX4Zp6EaLF3XNFoF0pXHLyou7uuxABzcHMIL9gLJbUecuzAdge
 OrOQ==
X-Gm-Message-State: APuU4Z+2gZ+L6PhWGRKfNs13nErdqyZJKIO3ukM9ilb2VJisc+YEhNJt
 TURpcO3lbpx4mGf9oN5q3qujymsuw/X3nnvuRd5gGNwS1e+eIQb2SSvAH3p6lom4qX1p14VDuP1
 hgrQWV142kh/8Ocf0VfIr8K9rM/MPPw==
X-Received: from edqv19.prod.google.com ([2002:aa7:d813:0:b0:6b7:7ca4:bcbf])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1f03:b0:6b5:767e:f030 with SMTP id
 4fb4d7f45d1cf-6b77733a4b5mr4305876a12.2.1794494310336; 
 Thu, 12 Nov 2026 06:38:30 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:51 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-6-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwj-000000007rv-04sZ
Subject: [f2fs-dev] [PATCH RESEND 5/9] f2fs: truncate blocks allocated past
 EOF by a failed direct write
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a direct write extends a file, f2fs_map_blocks() allocates the
blocks past EOF and maps them into the dnode before the bio is
submitted. If the write then fails, i_size is not updated, but the
blocks stay mapped past EOF with whatever the disk contained before.
A later extending write or truncate can make them visible.

f2fs_preallocate_blocks() already handles this for blocks it
preallocates with F2FS_GET_BLOCK_PRE_DIO: it marks the inode with
file_need_truncate() and f2fs_file_write_iter() truncates everything
past i_size after a short write. But the preallocation is skipped in
LFS mode and when the user buffer can't be faulted in, and then the
blocks are allocated by F2FS_GET_BLOCK_DIO from f2fs_iomap_begin() and
nothing truncates them.

Mark the inode with file_need_truncate() also when F2FS_GET_BLOCK_DIO
allocates a block past EOF, and truncate after the write if the flag is
set and the file is shorter than intended. Skip KEEP_SIZE files, where
the truncation would also drop the blocks reserved by fallocate().

The extending direct write is always synchronous (IOMAP_DIO_FORCE_WAIT),
so the result is known before f2fs_file_write_iter() returns.

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/data.c | 10 +++++++++-
 fs/f2fs/file.c |  8 ++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4ae61138a003..e978b6b18c26 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2171,7 +2171,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 			err = __allocate_data_block(&dn, map->m_seg_type);
 			if (err)
 				goto sync_out;
-			if (flag == F2FS_GET_BLOCK_PRE_DIO)
+			/*
+			 * Blocks allocated past EOF must be truncated if the
+			 * write fails. Don't do it for KEEP_SIZE files, where
+			 * truncation would also drop the fallocated blocks.
+			 */
+			if (flag == F2FS_GET_BLOCK_PRE_DIO ||
+			    (flag == F2FS_GET_BLOCK_DIO &&
+			     !file_keep_isize(inode) &&
+			     pgofs >= F2FS_BLK_ALIGN(sbi, i_size_read(inode))))
 				file_need_truncate(inode);
 			set_inode_flag(inode, FI_APPEND_WRITE);
 			break;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b67782043396..3fcea85c36a2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5896,8 +5896,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		}
 	}
 
-	/* Don't leave any preallocated blocks around past i_size. */
-	if (preallocated && i_size_read(inode) < target_size) {
+	/*
+	 * Don't leave any preallocated blocks, or blocks allocated by a failed
+	 * direct write, around past i_size.
+	 */
+	if ((preallocated || file_should_truncate(inode)) &&
+	    i_size_read(inode) < target_size) {
 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 		if (!f2fs_truncate(inode))
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
