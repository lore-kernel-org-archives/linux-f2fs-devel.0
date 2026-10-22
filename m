Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168E606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Anfwvn+d;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kWS67+Sd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V6lCEV4k;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nwB6epaL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=8SRpxaTJoS6CPyPY8GpQuLM4iaxM+yrkPdbUOP9HEPg=; b=Anfwvn+dw9l92i4Hl37i/RryF0
	iKMv4Gcb4R6T+EgRgLPLOaMUvHdEaz4ur77Kg8+q7unV638aOHF1oZ+rUHBweJlkNYBnWRM4+7sNs
	szUgMT+/0TlyyXUwldV+SS7KRjxDW808Rka+W0tlfqLl1WgoJc8rlRRfXcyzgxdl/1/A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndi-00000000768-3Vu0;
	Thu, 22 Oct 2026 07:55:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndh-0000000075w-357b
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5432w1B/mY1BOzeKsXE8/FBXgJKiRjyy818qnwTTaU=; b=kWS67+SdoLIfxFo25myNjVE325
 +hLahTArX9mIFs1gzO/eCDyM3vSid508FyylFJZthz/errLWFXN7u+D3LWJPFBVPdSukrxi7pRRiz
 qz6IIeWgn0fRrQFjxvMRfhLIHESWZhCJXIbMmdcYy3jJxhje3jR+8Nur7jRyHILdxNbU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5432w1B/mY1BOzeKsXE8/FBXgJKiRjyy818qnwTTaU=; b=V6lCEV4kMa+GgSdN3yoQrWSNL5
 XSl9612xWyP917FWI252T6jjDxI2pdVTxPaL2khVMm/kWimVkZ54qlIlS64IZCnezHOZCEy6e3tlT
 FqG6KJ5ULvS+aLY6SUVTsyY63zsekixHrTFKywlTN9Vo7rBcI1W0fswsSPxUSq0Q0oOc=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJndb-0000000052F-1miW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:55:05 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4fb64d2so757555a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655694; x=1793260494; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E5432w1B/mY1BOzeKsXE8/FBXgJKiRjyy818qnwTTaU=;
 b=nwB6epaL2Z80Z1pL/BVEfeccYqcoRgB/bE1k4J+bmqvMf9eiyoeASLBvHghHoYyCbz
 IEsBUiUq+ERtrcG0B4zhaBPtbkB6nPAHE1KBUF/rsZBXB4JVYbQsxP8l/U3Cg0AYbkUa
 NbmLMeIt4GyuoJhk4Pq4vhM3ZR5vIDWGdWyxARZW1NcRBGjSp+hQCX539D3JvcJ7Cyaw
 VBFiela61l2+gSvdctd7qVDuiRTr3Q3PRPCO4elzjdmhUmZOv9I9TuteeykLz3J9dIVJ
 5OQj63lYxkMNqUK2wUvu3FI9Zh8K0fYgQiN8IGVudK+z6O1kz934BOJITIU5B6h0PODI
 w7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655694; x=1793260494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E5432w1B/mY1BOzeKsXE8/FBXgJKiRjyy818qnwTTaU=;
 b=2VdTZC6W1XmGLi8lc8MV43sJc/shmrAopp/qp0Zyvg7bP/aGDjvnhu51gOsw9yidtr
 XPb67f7Ef6fjN8wWs43HddQjYSvWXr72+094KIJvX2jBGQKuzJCUvE+vk8r/A3SNu76v
 kW9FMIWO6VWMMWLxirWXAhJ3XN5QSqpP6T29DQ0rgxvZvzMogklfBproEQ6HWlZ5K7l/
 XPKjVRWR1YisEnJ3NSaxvCqWLKGx5JhdRnkpHJI3TeIo5Qm/ipx/ScsjpK9B26o+kYWV
 bT1ah6IHMpLDcpZmUslUW7DYD/T+MOt561kIgVncuHYs8HEhtAJzqNohPIWmwYtQzyK1
 UC3A==
X-Gm-Message-State: AFq9FYK9UIBBtmiz6Cu1wfbg3fwuJbaz8bAkrUQkS1fINy2e9Ntqrtmv
 79HigP8QJubZ8hTExT/PaaCZ6KZEyXfjT5GEDE8KPhZL8O6c3aVqa/w5R9icS4RN
X-Gm-Gg: AYBFou0TO+StzpnSL0grXLl1q4JhS8r5kX05mmeRcPCZidXSYQp01cO8Q6QeSozSpFs
 mabPs5o9M8JtSMGH6m+agMgEzO5AWWeX+ZEk/6V3/L0W/I+zUMFW4gqFMTINio67lCSrMbyyLFp
 yo54j+RhH90tOxVNcq6PYO8dHRuGx6Uk1gL5gM2UXiOMrTVfh9BpWunq+meRx/6lb6fXvyxjEAT
 oYwfD8cqwRqNVS7/bRIinlmsuOQ+5n8CcbASZGr4j0nh1QN3JkhEjuhOcI51OQzQDhYG736M96K
 N3oDKF3Si4/XSt97PhOHPHUqB9vUAk3uTvvhInvNsgxqocVuK84UMKCfIQjLkgw6P4nUeNpdSl/
 sHkWZWS62PdiPLsXTYtMCTlvPbJ1QOeh26vwCX1NdLYtJYXcQagm0RWZORbmU8P137EsejPv4PV
 7/YtbjhqFc8/fLPPf3vGF2IiruH8UUrbivfH5U9rsKrayn3bnClkAjuCFU/q6hqc3Y/K6K8EXzS
 /amLVG8k/Jys9o59wWxQ8Tocz/csmEHVNJK8Bu2AfhILH6dVIGRd8XH7H2m74uub58DqNoaKiKL
 I7PUNod7/upN0MmNbw==
X-Received: by 2002:a17:90b:2886:b0:3ac:7556:8eda with SMTP id
 98e67ed59e1d1-3ad86ed22e0mr3406691a91.26.1792655693695; 
 Thu, 22 Oct 2026 00:54:53 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:53 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:42 +0800
Message-ID: <20261022075343.3043003-16-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJndb-0000000052F-1miW
Subject: [f2fs-dev] [PATCH v6 15/15] f2fs: make compressed files compatible
 with large folio
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

The compression flag is the hint indicates that the inode can be
compressed, when the inode is using large folio, we expected it keeps
using the large folio read/write paths and its data stays uncompressed
on disk until the inode is evicted and re-read

Let f2fs_write_begin() skip the compression overwrite preparation for
such inodes and remove the compressed-file gate in
f2fs_read_data_large_folio() so the data is simply read/written as
regular blocks.

For the same reason, reject F2FS_IOC_COMPRESS_FILE with -EOPNOTSUPP
once the inode mapping is switched to large folios.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 Documentation/filesystems/f2fs.rst | 10 ++++++++++
 fs/f2fs/compress.c                 |  2 ++
 fs/f2fs/data.c                     |  9 ++-------
 fs/f2fs/file.c                     |  7 +++++++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 55798421f2c4..b79bb67ee78e 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -942,6 +942,16 @@ Compression implementation
   reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is
   truncated to zero.
 
+- Compression and large folios are not effective at the same time on a file:
+  a compressed inode does not use large folios, while an inode which is
+  using large folios keeps its data uncompressed on disk.  If the compression
+  flag is set on an inode that is already using large folios, the flag works
+  as a hint until the inode is evicted: the inode keeps using the large folio
+  read/write paths, f2fs_write_begin() skips the compression overwrite
+  preparation, and ioctl(F2FS_IOC_COMPRESS_FILE) fails with -EOPNOTSUPP.
+  Once the inode is evicted and read back, it uses order-0 folios again and
+  compression is applied as usual.
+
 Compress metadata layout::
 
 				[Dnode Structure]
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 162bd8ef822a..721b01dd0d24 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -78,6 +78,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
 		return false;
 	if (folio_test_f2fs_nonpointer(folio))
 		return false;
+	if (f2fs_folio_has_ffs(folio))
+		return false;
 
 	f2fs_bug_on(F2FS_F_SB(folio),
 		*((u32 *)folio->private) != F2FS_COMPRESSED_PAGE_MAGIC);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2338450ce031..c5728fe28370 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3266,12 +3266,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (f2fs_compressed_file(inode)) {
-		if (folio)
-			folio_unlock(folio);
-		return -EOPNOTSUPP;
-	}
-
 	map.m_seg_type = NO_CHECK_TYPE;
 
 	if (rac)
@@ -5286,7 +5280,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode) &&
+	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
 		struct page *page;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3d621a20766d..e61c80ae7537 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5021,6 +5021,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
+	/*
+	 * The mapping is already using large folios, where the data is kept
+	 * uncompressed, so refuse to start compressing the file.
+	 */
+	if (mapping_large_folio_support(inode->i_mapping))
+		return -EOPNOTSUPP;
+
 	f2fs_balance_fs(sbi, true);
 
 	ret = mnt_want_write_file(filp);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
