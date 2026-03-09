Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31BFCA17B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQs4DVIYr7IsyRNZDxJgjkzt88CLck8paba+YylFQP0=; b=ejAXF+6APyGEkdmkmvPjRH2Aco
	NPqZujHemR7ZsJjLqflHy+Eunm/hwNkARAvXnV/dsH7DERAzdKwsdg6C3hkiZZvHwl1U2rc8wNCPf
	j1oE3ZKiwmrs6IL5skPvelRkd86JZ2YLYv7CxYzr010FoL3gv1eLgiHWxCkM60TYb8D4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzgDp-0006Ux-RL;
	Mon, 09 Mar 2026 19:24:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1vzgDm-0006Ue-SK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 19:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EqmAzwtuUnoWDQCs3T4jHeDf9RNgBiDH2lXpWKvug7c=; b=KOtbcLoeiDGIlgzQGTH69pmxMM
 KXz181OTG1MOs7DZ5ngMFBtQlMYIIxoXBnyInhxUsEjUw+010YyY4h/X2JpvW0ssfuFd8jFFwfn9n
 /UjLoYYRZS6bRXYJQjgpsQoqcV4wnD4J6a+pGz1kH74iKVulYF1GP+d2aO0qBBhA9U30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EqmAzwtuUnoWDQCs3T4jHeDf9RNgBiDH2lXpWKvug7c=; b=IfNQ+WOrQo3RNgFrbobUEsa9P+
 yjJjpGzESnz+NmcBqI2I8X0o0ntwEEHXyOm9e7iPtf6NpJm+nYAxeUTMxt8yUskRZLPLKsMeRVeI2
 ui5t4bvN5856MsuAAlh9QjBROrsPSwE8n7VfqvIttkzDEOdD+1oFM0TLef3S06Ug47bg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vzgDm-0001Fw-GL for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 19:24:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A1C142ADD;
 Mon,  9 Mar 2026 19:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEFAC2BC9E;
 Mon,  9 Mar 2026 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773084289;
 bh=etGIrqcNXIU4r5QxlQePtDsAPSree6HNQOZ2b+h8++Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vGtE4aaJ+XU17c/DS6suD3WEue3n1zyHY43O6eGaKy4PWb9PVLzA2tg6kMO/HI1j2
 kKecN+CZ3PhSQ4aqgXnIdDF90Q9/o0h0nHZy26rUD30ErqPcNrlyeLQ53o4WiudZgt
 fbfk3IQt1GBai42Y810IvQx7Yxqog0Br4Ur4Q9z8lCK/XL4ExNUxXCOTTWN2xC7R0j
 DAKY+Mj1niQbe6tELn2Wsy6duOLqEvYLwLIGOJZiBTLlccfD45ylIJj4bI2sFTU2IP
 4GtuXNykXcvogaZ9pfc6Ss1ifcWKkvRnQyd3CEncU0g8jRS96Pu8fO3+q1P39zHb0P
 aJyhQt7QaLyoQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  9 Mar 2026 20:23:26 +0100
Message-ID: <20260309192355.176980-12-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260309192355.176980-1-aalbersh@kernel.org>
References: <20260309192355.176980-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vzgDm-0001Fw-GL
Subject: [f2fs-dev] [PATCH v4 11/25] iomap: introduce iomap_fsverity_write()
 for writing fsverity metadata
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is just a wrapper around iomap_file_buffered_write() to create
necessary iterator over metadata.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 25 +++++++++++++++++++++++++
 include/linux/iomap.h  |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 31e39ab93a2e..88fe4723bb22 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1259,6 +1259,31 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
+ssize_t iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
+		const void *buf, const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops)
+{
+	int			ret;
+	struct iov_iter		iiter;
+	struct kvec		kvec = {
+		.iov_base	= (void *)buf,
+		.iov_len	= length,
+	};
+	struct kiocb		iocb = {
+		.ki_filp	= file,
+		.ki_ioprio	= get_current_ioprio(),
+		.ki_pos		= pos,
+	};
+
+	iov_iter_kvec(&iiter, WRITE, &kvec, 1, length);
+
+	ret = iomap_file_buffered_write(&iocb, &iiter, ops, write_ops, NULL);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_fsverity_write);
+
 static void iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
 		struct iomap *iomap, iomap_punch_t punch)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 89e5a7abc012..844fc8414363 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -356,6 +356,9 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
+ssize_t iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
+		const void *buf, const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops);
 void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx, void *private);
 void iomap_readahead(const struct iomap_ops *ops,
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
