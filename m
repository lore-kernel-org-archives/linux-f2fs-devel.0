Return-Path: <SRS0=5Sob=QD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D2C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Nov 2021 21:45:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DB863223;
	Tue, 16 Nov 2021 21:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1DB863223
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mn6Gf-0002DE-Uo; Tue, 16 Nov 2021 21:45:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1mn6Gd-0002D8-NS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Nov 2021 21:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0zWK0udguESb4q9Cd2ZCP8LHG4UU72K6jDcVXHFcZMc=; b=SwY8gdJI2o45qOjWN9vpP8bPgP
 WWTkwS8/1pVwKp+dXH0Le5f1zCSATffXJLwajE6Tz+eq/95T8n1C5wqQqMY3ZcPgQcw9o4ZLrp4VF
 ZvvbVkzOArbuQjgfD2aMyAOMG2ygj1vAN8eiRVV8lj/YfxaAFOneZtNT3tbm1jeC5i4E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0zWK0udguESb4q9Cd2ZCP8LHG4UU72K6jDcVXHFcZMc=; b=c3nY5vf7xHAJiLPgvWYz3OpFOp
 FbnnQABSgveXrocpNmA4+Vo6e1BzpqyV4SkDBSItkYWgVX7sIpMtp6RD7QWJWA0URoAoNBgiZzY4V
 1D+X5JavYXkGQw6Q9gw0hKij3NSsHVdkKxhCNJGH3qKSZPQr7PkDx5BLHr4xN43y7yOo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mn6Gb-0006S2-Vo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Nov 2021 21:45:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64DE063222;
 Tue, 16 Nov 2021 21:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637099119;
 bh=/UYDcQmJ+TIG3AnvmVkhGY0X2O0bdavDOZOMvrqCSXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u4x4PT4xaB0rZeD6u9C7YIdTMrOKK05iRGKP1d6Q9CYXNgtKHFcx4OgUJPpxG67mz
 wgdmHswYMXMxb/CLgu1nGuO9OTsLFq8XM2baEdKbZcoGNBckPgVuhGmXBYdF9sttUk
 OqxxE9pWsU+OUKyvfQULLDPhfwtoy+L22RXg7kR6yOVU+Rn20GOphXo1toziJLfYr2
 7/EYracV6NaYOiPKxtSHeYKCREX6fTdGj020uV1KTW9LQWxWfP+YYPgygcFuoRbwlq
 rzBC4RrR4V0bDVdplHcaeu+vWs+TTFK+XAXDfUwB/4xX8gIJjn/EkotP+anV3vtgEh
 1D27H5F/Y7teA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 16 Nov 2021 13:45:08 -0800
Message-Id: <20211116214510.2934905-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211116214510.2934905-1-jaegeuk@kernel.org>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1mn6Gb-0006S2-Vo
Subject: [f2fs-dev] [PATCH 4/6] f2fs: fix the f2fs_file_write_iter tracepoint
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Pass in the original position and count rather than the position and
count that were updated by the write.  Also use the correct types for
all arguments, in particular the file offset which was being truncated
to 32 bits on 32-bit platforms.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c              |  5 +++--
 include/trace/events/f2fs.h | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fdc440d212c3..709fa893d832 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4321,6 +4321,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	const loff_t orig_pos = iocb->ki_pos;
+	const size_t orig_count = iov_iter_count(from);
 	loff_t target_size;
 	int preallocated;
 	ssize_t ret;
@@ -4403,8 +4405,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 out_unlock:
 	inode_unlock(inode);
 out:
-	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
-					iov_iter_count(from), ret);
+	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f8cb916f3595..dcb94d740e12 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -540,17 +540,17 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 
 TRACE_EVENT(f2fs_file_write_iter,
 
-	TP_PROTO(struct inode *inode, unsigned long offset,
-		unsigned long length, int ret),
+	TP_PROTO(struct inode *inode, loff_t offset, size_t length,
+		 ssize_t ret),
 
 	TP_ARGS(inode, offset, length, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(unsigned long, offset)
-		__field(unsigned long, length)
-		__field(int,	ret)
+		__field(loff_t, offset)
+		__field(size_t, length)
+		__field(ssize_t, ret)
 	),
 
 	TP_fast_assign(
@@ -562,7 +562,7 @@ TRACE_EVENT(f2fs_file_write_iter,
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, "
-		"offset = %lu, length = %lu, written(err) = %d",
+		"offset = %lld, length = %zu, written(err) = %zd",
 		show_dev_ino(__entry),
 		__entry->offset,
 		__entry->length,
-- 
2.34.0.rc1.387.gb447b232ab-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
