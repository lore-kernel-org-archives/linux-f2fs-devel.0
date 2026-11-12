Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C0606A88D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YOvs7ccF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IcJ8jTuA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=htd4RFO7;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mz0omgMB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6c05fNVzyPgDpU2SRfCflPpjjID7IM+UyzXwhDWiWD0=; b=YOvs7ccFOXGffyk3Zcwj8cX1pw
	DrwKOxphrvpUpVfnwCK5iOOpWeW6uYcAWcsisZE+hcU94+pqMJZUC9OdgZ/sRzid1BFIki/ZHcy9x
	Tn/gIzmcbGbTbTsBIGbY6mM6JO74uPL4vFgpHHpaqItMjSjNQXo2ZJ9l8WxvYFWv/J3c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVwk-000000007TG-0J8Q;
	Thu, 12 Nov 2026 14:38:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3ZM_1agwKADkekmpnVfjrnfdbjjbgZ.Xjh@flex--jprusakowski.bounces.google.com>)
 id 1xRVwi-000000007T2-3RPz
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5tk8+SHD72HahM8IWSQnY+YLH+AP0ICkb8Kww1tFiUk=; b=I
 cJ8jTuAMr1OeyQ/GmooDfbzz37f8ZGvTr2/KUr4Ol7ivB1HN1yPIL717g1Tpmt2vjonX6wMUJA1ff
 LJ7uRmH7Z1K96vB+UOAKo/108aGUedfilNYGbAMF+f1e/nctuRmM6o1mF/c6waps5+eC7MdcCtPbP
 OElwEnBHm/CosKEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5tk8+SHD72HahM8IWSQnY+YLH+AP0ICkb8Kww1tFiUk=; b=htd4RFO7FinRflFOG800ayiMz7
 sTguQR/3olbvrHZ96/fz/wA8eCXRyDyYjAlTlU2eJZvOFMqqC8AXy109XyMiqwO9PQIspbc1pRXYZ
 edCfBEcfJxjytKrAttYkpkWO1wLosX/bMvpPN1GbPQH2dJcQcJqaAwk53hy/oQaK3/00=;
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwi-000000007rj-0JJg
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:36 +0000
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6b56a350f2aso5275628a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494309; x=1795099109;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5tk8+SHD72HahM8IWSQnY+YLH+AP0ICkb8Kww1tFiUk=;
 b=Mz0omgMBog+juSEkuOPJoj5kphl4r4ypfcbJ0pfIo7tcSasRMxe1LNapVxTFFMpSlh
 tjWOHJ5oHb0NtVoNum2gYIAs9IHIoc0L207H79g5slXJ2j4ZdfZqaq4HHH2vP61veALp
 fj/61q5STCNSBAH82he0zlGSZkr/3qzEE1fb9/0RoLMiFCvE6tWCyrhQZSZ1NSb92K+y
 MczBmLv1OqI3D89r+55EonMRWMLpyKfjjlDmxegHV4bP817g2sGde3tiMviWKPQEihme
 Cvxz8vGuEC3UelodRFJmRegNI7W+C+T5QlWJuhuP/zP+pgneXU1VxqZtErASPsf3G8Pa
 llsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494309; x=1795099109;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5tk8+SHD72HahM8IWSQnY+YLH+AP0ICkb8Kww1tFiUk=;
 b=nLn3ghw7yKDIFr/3QvHugdahYZLMZOnISa0xwaMfakBGoW1Uk0SkWRU1AawiCJyoZC
 PWC8CyInMWuW82+KxPYgLMfG14zcyXGoZ24zu9D5pM7/t+0+TlpFhOtlLEJueIyOoLAC
 +EftNcTbgiu+nRINhMgBrjB85TVkyxrMNOisVdiydc6jF1KHGgYnz6LUEr1WbOQf2rgD
 27uFatsK4Se3PllawKQU03nm/kG7ffSFGFjmXhBO4fQ+V0IsL8p7mq5MlBekOYSgpjix
 NdXrP0yuXFRu5JbntX6IDQjCzEgzXNtYHgBqiL5R/tZB6etw+GYi6sWIR37iaxdYApuE
 2f6Q==
X-Gm-Message-State: APuU4Z8gMcng5SJKe2eVkqnMpAb00/IG3oBWXs2MjfPhZXzmagaYYK9y
 tyb7Fyz0M1IRgnzmS9rthq/UeaUGLN+P6jAbEae1/FkE0RPcC5Gqt9e5gfZUFh3hQDUXCk+Ve4L
 9AUZTDUKYb2085sr0Qc7FzvvAjgmuVg==
X-Received: from edgc3.prod.google.com ([2002:a05:6402:a603:b0:6b1:df6e:46a0])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3210:b0:6b7:b0bc:f4bc with SMTP id
 4fb4d7f45d1cf-6b7b0bcf5abmr1148633a12.17.1794494308993; 
 Thu, 12 Nov 2026 06:38:28 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:50 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-5-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwi-000000007rj-0JJg
Subject: [f2fs-dev] [PATCH RESEND 4/9] f2fs: propagate errors from buffered
 fallback of O_DIRECT writes
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

f2fs falls back to buffered I/O for O_DIRECT writes in two places:
f2fs_file_write_iter() when f2fs_should_use_dio() rejects direct I/O
(e.g. compressed files or unaligned requests), and f2fs_dio_write_iter()
for the remainder of a partial direct write. In both cases the data is
then written back and dropped from the page cache by
f2fs_flush_buffered_write() to preserve O_DIRECT semantics, but errors
are lost:

- f2fs_flush_buffered_write() ignores the result of
  filemap_write_and_wait_range(), so a write that fails at writeback
  time (e.g. on compressed files with dm-error in generic/250 and
  generic/252) is reported to the user as fully successful.

- In f2fs_dio_write_iter(), if nothing was written by direct I/O and the
  buffered write fails (e.g. with -ENOSPC in generic/299), the function
  returns 0 instead of the error.

Follow direct_write_fallback(): if the buffered write fails, return the
number of bytes written by direct I/O, or the error if there were none.
If writeback fails, reset ki_pos to the start of the buffered part,
since we don't know how much of it reached the disk, and return the
direct I/O byte count or the error.

For f2fs_file_write_iter(), flush before generic_write_sync() and while
still holding the inode lock, so the error can be returned and the range
can't be re-dirtied by another writer in the meantime.

Writing a part of a compressed cluster marks the whole cluster dirty
(set_cluster_dirty()), so flush and invalidate whole clusters for
compressed files; otherwise dirty pages outside the written range stay
in the page cache.

Also don't fall back to buffered I/O in f2fs_dio_write_iter() for
IOCB_NOWAIT, where f2fs_buffered_write_iter() would just return
-EOPNOTSUPP. Return -EAGAIN instead if nothing was written, so that the
caller retries in a blocking context.

Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Fixes: 92318f20d703 ("f2fs: preserve direct write semantics when buffering is forced")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/file.c | 77 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..b67782043396 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5643,17 +5643,32 @@ static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
 	.submit_io	= f2fs_dio_write_submit_io,
 };
 
-static void f2fs_flush_buffered_write(struct address_space *mapping,
-				      loff_t start_pos, loff_t end_pos)
+/*
+ * Write back and drop the page cache of a buffered fallback of an O_DIRECT
+ * write.  Writing a part of a compressed cluster dirties the whole cluster,
+ * so extend the range to cluster boundaries for compressed files.
+ */
+static int f2fs_flush_buffered_write(struct address_space *mapping,
+				     loff_t start_pos, loff_t end_pos)
 {
+	struct inode *inode = mapping->host;
 	int ret;
 
+	if (f2fs_compressed_file(inode)) {
+		loff_t cluster_bytes =
+			(loff_t)F2FS_I(inode)->i_cluster_size << PAGE_SHIFT;
+
+		start_pos = round_down(start_pos, cluster_bytes);
+		end_pos = round_up(end_pos + 1, cluster_bytes) - 1;
+	}
+
 	ret = filemap_write_and_wait_range(mapping, start_pos, end_pos);
 	if (ret < 0)
-		return;
+		return ret;
 	invalidate_mapping_pages(mapping,
 				 start_pos >> PAGE_SHIFT,
 				 end_pos >> PAGE_SHIFT);
+	return 0;
 }
 
 static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
@@ -5740,6 +5755,13 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ssize_t ret2;
 		loff_t bufio_start_pos = iocb->ki_pos;
 
+		/* A buffered write can block, so don't fall back for NOWAIT. */
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (!ret)
+				ret = -EAGAIN;
+			goto out;
+		}
+
 		/*
 		 * The direct write was partial, so we need to fall back to a
 		 * buffered write for the remainder.
@@ -5748,8 +5770,15 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ret2 = f2fs_buffered_write_iter(iocb, from);
 		if (iov_iter_count(from))
 			f2fs_write_failed(inode, iocb->ki_pos);
-		if (ret2 < 0)
+		/*
+		 * Return the number of bytes written by direct I/O, or the
+		 * error if there were none, same as direct_write_fallback().
+		 */
+		if (ret2 < 0) {
+			if (!ret)
+				ret = ret2;
 			goto out;
+		}
 
 		/*
 		 * Ensure that the pagecache pages are written to disk and
@@ -5757,12 +5786,20 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		 */
 		if (ret2 > 0) {
 			loff_t bufio_end_pos = bufio_start_pos + ret2 - 1;
+			int err;
+
+			err = f2fs_flush_buffered_write(file->f_mapping,
+							bufio_start_pos,
+							bufio_end_pos);
+			if (err) {
+				/* We don't know how much of it was written. */
+				iocb->ki_pos = bufio_start_pos;
+				if (!ret)
+					ret = err;
+				goto out;
+			}
 
 			ret += ret2;
-
-			f2fs_flush_buffered_write(file->f_mapping,
-						  bufio_start_pos,
-						  bufio_end_pos);
 		}
 	} else {
 		/* iomap_dio_rw() already handled the generic_write_sync(). */
@@ -5841,6 +5878,22 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			f2fs_buffered_write_iter(iocb, from);
 
 		trace_f2fs_datawrite_end(inode, orig_pos, ret);
+
+		/*
+		 * If buffered IO was forced, flush and drop the data from
+		 * the page cache to preserve O_DIRECT semantics.
+		 */
+		if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT)) {
+			int err;
+
+			err = f2fs_flush_buffered_write(iocb->ki_filp->f_mapping,
+							bufio_start_pos,
+							bufio_start_pos + ret - 1);
+			if (err) {
+				iocb->ki_pos = bufio_start_pos;
+				ret = err;
+			}
+		}
 	}
 
 	/* Don't leave any preallocated blocks around past i_size. */
@@ -5864,14 +5917,6 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret > 0 && may_need_sync)
 		ret = generic_write_sync(iocb, ret);
 
-	/* If buffered IO was forced, flush and drop the data from
-	 * the page cache to preserve O_DIRECT semantics
-	 */
-	if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT))
-		f2fs_flush_buffered_write(iocb->ki_filp->f_mapping,
-					  bufio_start_pos,
-					  bufio_start_pos + ret - 1);
-
 	return ret;
 }
 
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
