Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDFACD98D2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MOnoej7oq469QBcVvmm+Py1zNdMd9PYmHPeXIKE5G8k=; b=mQ5UfroQ3vwR44e9VcHL5thr+E
	H8PklzN0+odMtsOAq7oJAJggTKX71jWiLj5LTejNNttc7uv7q6V4X+o21EDLvU6uqNklimc74h0D6
	DA1LN4+hgda6e/CPQyJPtrCB0PkA2XsRG4FSpH1+oHzktHwNUGTDLmS7uctq7VXD07R4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZOPy-0001Tq-4d;
	Tue, 16 Jun 2026 07:41:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZOPw-0001Ti-Dk
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 07:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mHKTLAuwcY3e5jMqpY2/5BQURtTBfwyO9fzJIKibCMQ=; b=eg1W9qHh6GHQCBTZuiTp1gp4Yt
 jHnfoy6mcWdVUWbRMASTKyJH8PxMZrRFjX1f3+NSUGY3QH9rfX1M77fHpa1kj49cjhhiRMFDTfsnm
 7WrWkOLr902hX5/9RmXAorYBLIGCEjvN9Wd4pPPiIGCUU+O4+KPMWRu3MSy+Tox+52hw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mHKTLAuwcY3e5jMqpY2/5BQURtTBfwyO9fzJIKibCMQ=; b=aTfz7S/g8knumjTOYnvK8NLYOF
 SUD769+wTZiZELl2hWYe0gJteIW4lCY9f3xx1uU70y25cVvx0J5oJ1nJHwFRINJBIqDqBCozehKUc
 wnrGsu9s9a3VCO8uw8vSvJXx1gqpBeHJkfF8bZWVDuktbBeKUsZcHz7wm1WQ7+7i6QEk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZOPt-0007wY-BY for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 07:41:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BF9044025;
 Tue, 16 Jun 2026 07:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380801F000E9;
 Tue, 16 Jun 2026 07:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781595656;
 bh=mHKTLAuwcY3e5jMqpY2/5BQURtTBfwyO9fzJIKibCMQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LUoNmRyp1B4AF6jK+MpLlyn1Ng2ugnS8Pq751sU/oCjrQCEifuTr4/8rk+8CU+kHh
 EIG6n+81lS++i2oEsckVSNFI8PPX7O5Jd8TdIG/fS+N5tac2jTsOiBQQq+1dssyfXd
 ZV9e/HGyBlwKeyQOzJL5eutZdSltYfCXCPGBQS4RVb/A2Ub3vdOLFYgbIXpYT9y1JX
 vfbKqUwn6TwEw6M60TNKWShFRytdvHmdrTowCvqlMD5zUCIEqkMgC9mp21/XnQOb2y
 JSaiD3i9PFAIrP52yR7N3NJUWxV0aLY3ugfzxbw/nG15Ytym1RSYZyO61Su2yYPDa3
 cejbjy7Z01FTQ==
Message-ID: <076be691-398b-4365-a06b-9e290fa52a8e@kernel.org>
Date: Tue, 16 Jun 2026 07:40:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>
References: <20260615130822.2576088-1-chao@kernel.org>
 <20260615130822.2576088-5-chao@kernel.org>
 <ai_57zkSdVklsPuw@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ai_57zkSdVklsPuw@casper.infradead.org>
X-Headers-End: 1wZOPt-0007wY-BY
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: use fscrypt_finalize_bounce_page()
 for cleanup
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/15/26 13:11, Matthew Wilcox wrote:
> On Mon, Jun 15, 2026 at 09:08:21PM +0800, Chao Yu wrote:
>> No logic changes.
> 
> This seems like a step backwards.  We should be looking to convert to
> a future fscrypt_finalize_bounce_folio(), if anything.

You're right, what do you think of this?

 From 533ee72170c2ad451097db926dd713d9fea442f9 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Fri, 26 Sep 2025 01:43:06 +0800
Subject: [PATCH] fscrypt,f2fs: introduce fscrypt_finalize_bounce_folio() for
  cleanup

As part of the linux kernel's migration to folio-based APIs, introduce
fscrypt_finalize_bounce_folio() as the folio equivalent of
fscrypt_finalize_bounce_page(), and clean up f2fs codes with this new
helper.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
  fs/f2fs/data.c          |  7 +------
  include/linux/fscrypt.h | 11 +++++++++++
  2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac1cf4de3d62..e0fca6c60e34 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -362,12 +362,7 @@ static void f2fs_write_end_bio(struct bio *bio)
  		struct folio *folio = fi.folio;
  		enum count_type type;

-		if (fscrypt_is_bounce_folio(folio)) {
-			struct folio *io_folio = folio;
-
-			folio = fscrypt_pagecache_folio(io_folio);
-			fscrypt_free_bounce_page(&io_folio->page);
-		}
+		fscrypt_finalize_bounce_folio(&folio);

  #ifdef CONFIG_F2FS_FS_COMPRESSION
  		if (f2fs_is_compressed_page(folio)) {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 54712ec61ffb..20b59b021c94 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -1132,4 +1132,15 @@ static inline void fscrypt_finalize_bounce_page(struct page **pagep)
  	}
  }

+/* If *foliop is a bounce folio, free it and set *foliop to the pagecache folio */
+static inline void fscrypt_finalize_bounce_folio(struct folio **foliop)
+{
+	struct folio *folio = *foliop;
+
+	if (fscrypt_is_bounce_folio(folio)) {
+		*foliop = fscrypt_pagecache_folio(folio);
+		fscrypt_free_bounce_page(&folio->page);
+	}
+}
+
  #endif	/* _LINUX_FSCRYPT_H */
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
