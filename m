Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C2ECD98E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dNYG3KK8qLqdoYBw+746FTPTEXFWiVG/XMAtBZ1sGJQ=; b=OacDASIHjTYeAmvl7MxoFStAAd
	SH52udbPtOk+Q77xsBLM+TBXmJST/QhGm9G411nVzriW98iGadjVT0ga65TLnq5YSg9AHgUgpWwCi
	ahk1K9ViUwdqjF2XZg1FU5GBUvKo6CRotN2HsjzwM3Z9/UynZpbG/zB4BSPtWU4PEEnw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZkmu-0003l6-Vw;
	Wed, 17 Jun 2026 07:34:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZkmu-0003l0-3G
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 07:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/rnUG+9phvqSWTbG1RUV6ldfu1gWqqD6rk/CGwNLgAI=; b=ktupjqDpyjTffLOi1GsLDqBzA/
 g4obXZE6ZZKwC+9G+ph98PM+y9qfVblBH48Pox19tZgxCtwQVQTqKUFtxVrrl+7JatSKJkIZrGzm6
 BmIPda541L+0YCjav8tsRrARC3YLezJC34KG2sdYsYl6n0K9hDa1gl+FkSWGv5f8tmWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/rnUG+9phvqSWTbG1RUV6ldfu1gWqqD6rk/CGwNLgAI=; b=I
 dZTqGeMUaXEDSA45aXwDB+mq/nTGgAOrn8ANAUt2uF8aDJ9sveY78QO+FZHOAkIzt4qEe+T/4oH+D
 +oCnZdrNSnKjqOQLLq5SwL5YJsCs1SPlhsvZoin2pveLXxmB5G0XOgZoloCG1941lMzZF2KI9UWG3
 7DE/6lin0s2t/Vwo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZkmr-0005We-13 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 07:34:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21D6643AEF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 07:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D601F000E9;
 Wed, 17 Jun 2026 07:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781681648;
 bh=/rnUG+9phvqSWTbG1RUV6ldfu1gWqqD6rk/CGwNLgAI=;
 h=From:To:Cc:Subject:Date;
 b=OA2cvJtj5k2zTe0TnAHN23OInYvQAgAjeEoF//1vSmxuJvcoifL/SnDO3i3jxJruL
 xy2acEk9ir0FVaSDynvCYx11W32d9O67iXmNQ6h51shar/JJ/ra7fA3YgLoLq+XyOw
 LiKZwUXnwemMMyciARzxLw2aTuEjl87YVUDbncYSS/pZ0adDl92xTM50JxI4IhoMtI
 49LEWm4dK03jIWbMr3HqT8O13YI52+7Z52merpvnn2Da5UQZGBH5c61qT/w536PVhO
 2JBevV5N9lZNeNL8aLemswHW2ne7syVfLyVIXvZ+wMWL3y+SzAjaUboUKHqMgURG1s
 JzqyQoSe4Q0sQ==
To: jaegeuk@kernel.org
Date: Wed, 17 Jun 2026 07:33:57 +0000
Message-ID: <20260617073357.93682-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
MIME-Version: 1.0
X-Headers-End: 1wZkmr-0005We-13
Subject: [f2fs-dev] [PATCH v2] f2fs_io: adapt w/ page_size in
 aligned_xalloc()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When allocating memory in aligned_xalloc(), if the requested alignment
(e.g., F2FS_DEFAULT_BLKSIZE) is smaller than the system's page size,
aligned_alloc() will allocate memory that is not page-aligned on systems
with 16KB or 64KB page sizes.

As a result, subsequent calls to madvise(..., MADV_HUGEPAGE) will fail
because madvise() requires the memory address and length to be page-aligned.

Fix this by dynamically adjusting the alignment and rounding up the requested
allocation size (via roundup()) to the system's page size, ensuring that
memory is correctly page-aligned for madvise().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 17 +++++++++++++++++
 tools/f2fs_io/f2fs_io.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 94e61b8..9a866cc 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -97,6 +97,23 @@ static void *xmalloc(size_t size)
 
 static void *aligned_xalloc(size_t alignment, size_t size)
 {
+	long page_size = F2FS_DEFAULT_BLKSIZE;
+
+#ifdef _SC_PAGESIZE
+	page_size = sysconf(_SC_PAGESIZE);
+	if (page_size < 0)
+		page_size = F2FS_DEFAULT_BLKSIZE;
+#endif
+
+	/*
+	 * On systems with large page sizes (e.g., 16KB/64KB), alignment and
+	 * allocation size must be page-aligned to satisfy madvise().
+	 */
+	if (alignment < (size_t)page_size)
+		alignment = page_size;
+
+	size = roundup(size, alignment);
+
 	void *p = aligned_alloc(alignment, size);
 
 	if (!p)
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index 539964f..cf1c334 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -49,6 +49,9 @@ typedef u32	__be32;
 #endif
 
 #define F2FS_DEFAULT_BLKSIZE	4096
+#ifndef roundup
+#define roundup(x, y)		((((x) + ((y) - 1)) / (y)) * (y))
+#endif
 #define NEW_ADDR	0xFFFFFFFF
 
 #ifndef FS_IOC_GETFLAGS
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
