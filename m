Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD24C5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VmvKrAIKXKmdAgjqGBKvSTcEXifviw6YEz+ewwJGhk0=; b=jPlQ6KQUO8iamUzOokcBAnaVh8
	JCx4+9VoZ4O2ZwkIEDtEkjkCKOogvJqsgU/lvxzIBhcQOdWl5itUHmwPVUEpAp49EMnmWek9r6t86
	ysSTUgziyijEWluPVDFG1eQ+R2UaBjY0QNKzOCAQzG+H+dzB+TRDVLE2RlREBnFgKwKU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoBF-0004AD-LE;
	Fri, 14 Aug 2026 09:26:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoBE-00049q-11
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QUXeMqxPDFfB1YOreWMQBvO4KxPIdaHtnGf4i8sQDz4=; b=i/YSWm1v+ZkOoQGrwoKzeSr2/M
 jlSoCfrv/xVDxJUEEqQS3CBHGrf09yq9K2a3nJbdsR1xfi29UpaL8S/vnBeZzAL4hJzNyEXwjYlhN
 Vw5OnSOLNA/+q+lzCeA1oxfGnc/mB+Q1zLAADcKq54njf9Nz6RCiy8nbPdZ3ZHWo7e7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QUXeMqxPDFfB1YOreWMQBvO4KxPIdaHtnGf4i8sQDz4=; b=MjQH1+y5X1cWAG6QWGifYxw8ra
 uWCeCYUJoTg5+xze5YMNMlUxwnbkQePaTTpUfmw5KCTG3nIP5wjtxNOKOXwLC1cCIkR6NfcnPyhMp
 ksbfJAQmCa4ouOT/qcitjSlRbbVSOJMGaddqQI1pPjEafacztB9+E9OpxNgT4273QQzk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoBD-0007kA-7y for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F093C41480;
 Fri, 14 Aug 2026 09:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B491F00A3A;
 Fri, 14 Aug 2026 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699577;
 bh=QUXeMqxPDFfB1YOreWMQBvO4KxPIdaHtnGf4i8sQDz4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UOQQqfzhEfsuYP/m3e+Ed/w5/0NRir1nxh8SN/yzQgQCVWm8iC99JZWZIyc0i+4Mb
 ZA5aZEJY8WgXXyqnPCMbCDGWY8dzkQSpjxjebuMoRC8tM/ZhsfYdYATzgMRykKlQg1
 WLVPd+l4dnj9AZyUCRjloQhYl47UlOzqRXAJ+8N8ZMZyTGjry7RrAWtX4pLSCPNxT7
 kNbe4lC84BUyLqsNGBHwPf3LA0Vwq70rtO4xEy4gx9bV6ywnkq791wnD5tms0Nvfxy
 UdqxHUEVU6Nwt4ufyPKO4f8+5dgPVxxOq38HZV7NeyapxYT+KAMilkiFKaoPSvU/w7
 wwlPOhUQtTllA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:26 +0200
Message-ID: <20260814092448.1818082-10-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoBD-0007kA-7y
Subject: [f2fs-dev] [PATCH v15 09/25] iomap: add a iomap_ioend_flags helper
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Christoph Hellwig <hch@lst.de>

Add a helper to initialize the ioend flags to the values that can be
directly derived from the iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/ioend.c      | 12 ++++--------
 include/linux/iomap.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index fb636dce43af..d71e7f5609c6 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -215,7 +215,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 {
 	struct iomap_ioend *ioend = wpc->wb_ctx;
 	size_t poff = offset_in_folio(folio, pos);
-	unsigned int ioend_flags = 0;
+	unsigned int ioend_flags = iomap_ioend_flags(&wpc->iomap);
 	unsigned int map_len = min_t(u64, dirty_len,
 		wpc->iomap.offset + wpc->iomap.length - pos);
 	int error;
@@ -225,20 +225,16 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
 
 	switch (wpc->iomap.type) {
-	case IOMAP_UNWRITTEN:
-		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
-		break;
-	case IOMAP_MAPPED:
-		break;
 	case IOMAP_HOLE:
 		return map_len;
+	case IOMAP_UNWRITTEN:
+	case IOMAP_MAPPED:
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
 	}
 
-	if (wpc->iomap.flags & IOMAP_F_SHARED)
-		ioend_flags |= IOMAP_IOEND_SHARED;
 	if (folio_test_dropbehind(folio))
 		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 56b43d594e6e..7328e30fb8ad 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -415,6 +415,18 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT | \
 	 IOMAP_IOEND_DONTCACHE)
 
+/* ioend flags directly implied by iomap flags */
+static inline u16 iomap_ioend_flags(const struct iomap *iomap)
+{
+	unsigned int flags = 0;
+
+	if (iomap->type == IOMAP_UNWRITTEN)
+		flags |= IOMAP_IOEND_UNWRITTEN;
+	if (iomap->flags & IOMAP_F_SHARED)
+		flags |= IOMAP_IOEND_SHARED;
+	return flags;
+}
+
 /*
  * Structure for writeback I/O completions.
  *
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
