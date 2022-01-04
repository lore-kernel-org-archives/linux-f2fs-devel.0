Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477D8C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Jan 2022 21:24:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n4rIR-0007gx-B7; Tue, 04 Jan 2022 21:24:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1n4rIN-0007gq-Ih
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jan 2022 21:24:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3EGjSLIMl/BbWaZ4nrqdPnTRklDPb3M5ZL/L2LKWASs=; b=fAwUg8M9nvEqdIioJOEklKlCe3
 d2fN4HZyP4YIwMWdb+60YPsY8iL8YpUojdiNkN47dHWOo3adPD3+qo+udMr1+6FpC3Pu83Tm2GwMz
 SUR85uwK/X/pGx5xzKmuLoXYmFxwRCXgfTrdib1bCyzr3djXzwaou45FbwZa8rmj1URA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3EGjSLIMl/BbWaZ4nrqdPnTRklDPb3M5ZL/L2LKWASs=; b=MyBjRKnKdgx6iUBODn84XANmi1
 Eqipuys4raL0WiHapAbBsxwpBhCDYv286B0BsUPfgi/TjuswcFXw1dMilt4QIkzQaASDqswCDRIwE
 jk/Y3x36kxjBtJUcruZqcgxYwBX+XKPZX0Lhvza7nOV32yLgqLf+1AczJ4Cef1XPmjck=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n4rIM-002GS5-Pm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jan 2022 21:24:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6CAC4615A9;
 Tue,  4 Jan 2022 21:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E221C36AEB;
 Tue,  4 Jan 2022 21:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641331473;
 bh=+cD0bVmur39/mZZYScz/Vt2+aXcvYE362LOr2fvRC2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EYF5czKWnVrjw6Z9QZrLoy5tH5IXU9xjedOFuCFTlIU6xETnPpRckp7aYjNFEvK6u
 EoyA+yL7CWPbr+6MM7YNrNUEtwqR9B/SZCK0rqqYJI7T1M/MahE6O5CcdUHViZMfHL
 TL+ClowlfFt2v46HEPN14l3reW/V4AKYbmemzjvS/MtD7MggQMTKdwWaIjoUzevFpI
 G94KXKjeItKOGtXpRcFw/c2Qch+ceKG5Qm56lZ5puRzyzsBH7TVDgsNTJpFA3PwMds
 UiF94osdckYXXMnneiQcVXcMNYIFacO8hiUVFvtOYUNs3pHtmj8AH8avBtI3BfbbCp
 Ul4oyoXCGuxnA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  4 Jan 2022 13:24:17 -0800
Message-Id: <20220104212419.1879225-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104212419.1879225-1-jaegeuk@kernel.org>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1n4rIM-002GS5-Pm
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
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c              |  5 +++--
 include/trace/events/f2fs.h | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e1445cf915ea..048db4852b28 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4312,6 +4312,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	const loff_t orig_pos = iocb->ki_pos;
+	const size_t orig_count = iov_iter_count(from);
 	loff_t target_size;
 	int preallocated;
 	ssize_t ret;
@@ -4392,8 +4394,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
2.34.1.448.ga2b2bfdf31-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
