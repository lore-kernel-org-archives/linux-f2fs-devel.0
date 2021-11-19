Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C99C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Nov 2021 21:12:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1moBBY-0006CD-FP; Fri, 19 Nov 2021 21:12:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1moBBX-0006C4-8H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Nov 2021 21:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TsfUS7m7p/ecfuz+C+euPRI9cUiXViyjo46SDmrtvUQ=; b=lNiWVAxuYNL8WsPw0Yar051XTA
 wA80IGDa8554br4Nu6dSZih7iNeBjN+/QN407mCpCbshB6K047yoUKh3YRK7UNw1M5HcYWcp/PCWb
 n+RW4Hb4k9fI8rzikb9Ip7XFZG810z8a77+K3WQ9zlVn7KOTuLm72kf8Ul2zgZLj/D78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TsfUS7m7p/ecfuz+C+euPRI9cUiXViyjo46SDmrtvUQ=; b=G
 5T3fDptOLLHIkaRED4oAtGspiViK62ozsjlpoCzEHD1x9WUgBck78SjjVSYfDEbCkOe7rXlBkMYiz
 9W6bFn4qkDyK9EXPEpkAZ5viQq+S5BCGZCNVE+y906MRls8Ru5tT86wtNNooCKYpMphhRXkikIjkw
 0QjSnjm7J6a/vm68=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1moBBU-001VfY-F6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Nov 2021 21:12:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB3A361B1B;
 Fri, 19 Nov 2021 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637356346;
 bh=LT+lqR3AQkrtDrRSXeYsgAM9P7hk53heimIWAO7p44g=;
 h=From:To:Cc:Subject:Date:From;
 b=Hkli9/J+HHM5FZ1ph8baMZyAT5cf1WKfAag3gVQVJXHFQRbQuXa/8x2iVrYegoqzA
 nLAzz3/hz4bE5Gsz/5CbcMKhwNKiuKeWYskZJ7dDJdso8/wUQZXSHLEA4FGkSjAxsz
 DohCOdsN60B4GIQnovw9X5M34qf9gMvFUU/lhhBK3l20EFeGsnUsw+apM3yVyCOzxg
 f0z9DIGkuFVP0YldG10IP19PNgmVM0Te9OfVA1y1feHmhsGydQwF6S4INFWyZPB20e
 VMIg6iOTWVuPAXdePwjAX85pfrxFZyJ75Y4fmo3rmASKJwBqk9N+imDeWuHf34wOUJ
 JpKXWVBhpoIaQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 19 Nov 2021 13:12:22 -0800
Message-Id: <20211119211222.3114368-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
X-Headers-End: 1moBBU-001VfY-F6
Subject: [f2fs-dev] [PATCH] f2fs: show more DIO information in tracepoint
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This prints more information of DIO in tracepoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c              |  4 ++--
 include/trace/events/f2fs.h | 15 +++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 32c0bd545c5c..a0d605db6b96 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4295,7 +4295,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (count == 0)
 		return 0; /* skip atime update */
 
-	trace_f2fs_direct_IO_enter(inode, pos, count, READ);
+	trace_f2fs_direct_IO_enter(inode, iocb, count, READ);
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!down_read_trylock(&fi->i_gc_rwsem[READ])) {
@@ -4494,7 +4494,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct iomap_dio *dio;
 	ssize_t ret;
 
-	trace_f2fs_direct_IO_enter(inode, pos, count, WRITE);
+	trace_f2fs_direct_IO_enter(inode, iocb, count, WRITE);
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/* f2fs_convert_inline_inode() and block allocation can block */
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index dcb94d740e12..f701bb23f83c 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -936,14 +936,14 @@ TRACE_EVENT(f2fs_fallocate,
 
 TRACE_EVENT(f2fs_direct_IO_enter,
 
-	TP_PROTO(struct inode *inode, loff_t offset, unsigned long len, int rw),
+	TP_PROTO(struct inode *inode, struct kiocb *iocb, long len, int rw),
 
-	TP_ARGS(inode, offset, len, rw),
+	TP_ARGS(inode, iocb, len, rw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(loff_t,	pos)
+		__field(struct kiocb *,	iocb)
 		__field(unsigned long,	len)
 		__field(int,	rw)
 	),
@@ -951,15 +951,18 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->pos	= offset;
+		__entry->iocb	= iocb;
 		__entry->len	= len;
 		__entry->rw	= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu rw = %d",
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_hint = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
-		__entry->pos,
+		__entry->iocb->ki_pos,
 		__entry->len,
+		__entry->iocb->ki_flags,
+		__entry->iocb->ki_hint,
+		__entry->iocb->ki_ioprio,
 		__entry->rw)
 );
 
-- 
2.34.0.rc2.393.gf8c9666880-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
