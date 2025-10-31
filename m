Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44112CCF9F8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6smb2VF0/yXsKBasKcWfxfXMknGW47fNvRRL5CwpXYw=; b=BZxwilyrix0qgR5aJaw2n83u53
	/gzTM7b7DcCIwg0Hevwep+Mk2b6C9rrhpiPxrwJacLPwLNrfAOaNykBYyBuNuwiP8/Bp3ckOtsHyF
	0cccd1VIZPueOd0uN4o/h6+eRAXBiiN2I5MpDxL8oXJ1BNEDKSb5qlBatFyJ+IFBJeOg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vEwmt-0004pP-Qe;
	Fri, 31 Oct 2025 21:35:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1vEwms-0004pG-Dl
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Oct 2025 21:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TBC+gm9pXQW2HFcImxHUjk2Ct12z09HpzEI43YymQss=; b=fFKl5txw/0YExobptWNdgJZ6Tl
 Oydlzpz3N4QhAtUZec94K1r0IfTDF9E9kottKqFICTBgN8mCBEJws3GWj6XAlD+eTt856aUrxHdBp
 eas10W0M5gykIPlysqLi1bPTJ6sg8r52VFIrWyLG6dNW6lO3V7zEYiG2wlD6WQO6I16w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TBC+gm9pXQW2HFcImxHUjk2Ct12z09HpzEI43YymQss=; b=lsupAQJjNglTmQ86sEG9U3bBsv
 75F75gRfIFtZl6Cxnf3K4sifQUrCWoTfafMktSAnep/sfwwgcC09Ms582kCoiQaedpIVv4VUFBo3u
 SNfkLaBm21VlS2EmLhegrq1snu8QyBAdd/tagLgJzGk5n0jDZwYgFXNsnCDEOUscURhM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vEwmr-0000nU-VB for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Oct 2025 21:35:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F34D0601FD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 31 Oct 2025 21:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB70C4CEE7;
 Fri, 31 Oct 2025 21:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761946551;
 bh=x6L31CG0svo1i4rtHQe15pm7gZjhLeWBH7Dz36e3EoI=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=c+RVo2RcNbmb7uPQsgrPpFbqrLlRW6C2f25hvUJqpBUr6jXCvlzNSo4HOCu1gRyyu
 O2zzKs416AeA2yAYwl8FZSzkSd5dtGnwIUwJAG4P2Y73ArbPI2cBjUBb9Dok7+1oyt
 cKqivWnwFsQ+QpwPWAYdJLLIlWitXq2P3LRXNRIYeRxCIS/Ovv2kxZ0DAZZtO0Auyt
 DiVTOR3d0+4fxk/5CFjWfwbB7wbLRCNuIy8NsYDAv64vZVx5uIgoEw3/+kh08jePn4
 khlz9KVAqrddSZNoqLecb98wiG1fSaxXteeFBi2iP3sKIs6+ZbPAAnAc2JKJTviWc8
 7IfEYeUb19nOw==
Date: Fri, 31 Oct 2025 21:35:49 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <aQUrtSAXWtHtLhtm@google.com>
References: <20251028195444.3181203-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251028195444.3181203-1-jaegeuk@kernel.org>
X-Headers-End: 1vEwmr-0000nU-VB
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add fadvise tracepoint
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This adds a tracepoint in the fadvise call path.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 v2 from v1:
  - use i_size_read()

 fs/f2fs/file.c              |  2 ++
 include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b966f6d40d2..d7047ca6b98d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5288,6 +5288,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 	struct inode *inode = file_inode(filp);
 	int err;
 
+	trace_f2fs_fadvise(inode, offset, len, advice);
+
 	if (advice == POSIX_FADV_SEQUENTIAL) {
 		if (S_ISFIFO(inode->i_mode))
 			return -ESPIPE;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index e1fae78d64a5..e00611ead024 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -586,6 +586,38 @@ TRACE_EVENT(f2fs_file_write_iter,
 		__entry->ret)
 );
 
+TRACE_EVENT(f2fs_fadvise,
+
+	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int advice),
+
+	TP_ARGS(inode, offset, len, advice),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t, size)
+		__field(loff_t,	offset)
+		__field(loff_t,	len)
+		__field(int,	advice)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->size	= i_size_read(inode);
+		__entry->offset	= offset;
+		__entry->len	= len;
+		__entry->advice	= advice;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
+		show_dev_ino(__entry),
+		(unsigned long long)__entry->size,
+		__entry->offset,
+		__entry->len,
+		__entry->advice)
+);
+
 TRACE_EVENT(f2fs_map_blocks,
 	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
 		 int ret),
-- 
2.51.2.997.g839fc31de9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
