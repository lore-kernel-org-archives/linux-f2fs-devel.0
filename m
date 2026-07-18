Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA7AC4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gat/ISr1odmWgt7Vkg2CJ22vzZCtCK3hbkdzeFQyRkk=; b=ZMyhXf7qYAyPryL8C54FSAYt9s
	N4OycrMAgY2LhWk34kgDoIbpQM23lDAvd2OzUr4YZGEjaEmoargWr3PtaCy2y0RXRjC0Iv5/8iUjt
	SkBxJz+UQlIypw2w3sPvu9Ei/uuMrOMQHT7K+oo+n1ZTSi1i3nKf/eYnLmw9PDzeeB0Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlCuH-00081P-N9;
	Sat, 18 Jul 2026 21:49:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wlCuF-00081H-Ql
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=51BZI0czokw254bwWkQ+Q7dU3NsJmPHSH27DSUDwsvQ=; b=NtUon43TeYMVr8XeqCuMNrlWoM
 u8PbRQH1B+pKmJhq92TYQJnkJukbrPmMkhozX+3oBH1wyq1dzFi9sC4vpFUI9X7T3WVG3tEzmuA0O
 y5JARkvBAPexA0lNLpdksrwN5v5L6EDEIhDtmw7pEmhlBKMw0uX1TCWOHeOXNVzVHmic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=51BZI0czokw254bwWkQ+Q7dU3NsJmPHSH27DSUDwsvQ=; b=eqcXP2MIC/kjQQQ8lS+SguxreP
 sW3864AitoWFvXLWbGiUGRG7anQKzCf5q7AHcYOY3nyYu/GlPBBLGr83TkSa3/b+nEmr7IgSPIcCQ
 ILepRkSDRqidB6DYONrbmVSJAHr1WrNZTrLds22bBpbnu/1ReavMgNOmmF4sL0jYXjXE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlCuF-0003Vr-LB for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02C3C60008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 21:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91671F000E9;
 Sat, 18 Jul 2026 21:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411345;
 bh=51BZI0czokw254bwWkQ+Q7dU3NsJmPHSH27DSUDwsvQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=k5+0M4B1y7CJshMruk8auUvrezpIIGRwRHFUoaRPzCxWdOsoaktzhBM2fkqkvY7p4
 CPMlD4KZZjJYDjso3fQ1BXPMb0PLfzqbNKqd26ung8QygO5ZgwJqMJE+eIlb5c8ycP
 oy9XfDo5PX6jFfw4IenDm/uYmxZG1qW/ofrl9vw1ss297L1QrKh/Eg0Jh6R/3oXIuo
 qkWVu5tLxAb4q8mzmHbrtQT+9ovcOKCbbxdF3m6Bdx3gUtZaD8KuL2wNQ5K46HYg0f
 uRGSHGxwClG5xAyK7ktJbo1/MMqeMdDBAuN3JaAkSTzUhUZIwcAXlh5xIARPvtokdg
 JoyONc5c0jo9w==
To: linux-fscrypt@vger.kernel.org
Date: Sat, 18 Jul 2026 14:46:52 -0700
Message-ID: <20260718214655.63186-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718214655.63186-1-ebiggers@kernel.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlCuF-0003Vr-LB
Subject: [f2fs-dev] [PATCH 3/6] fscrypt: Remove unused function
 fscrypt_finalize_bounce_page()
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fscrypt_finalize_bounce_page() is no longer called, so remove it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/fscrypt.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 52ff014aeae6..42ffd66a2491 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -1057,15 +1057,4 @@ static inline int fscrypt_encrypt_symlink(struct inode *inode,
 	return 0;
 }
 
-/* If *pagep is a bounce page, free it and set *pagep to the pagecache page */
-static inline void fscrypt_finalize_bounce_page(struct page **pagep)
-{
-	struct page *page = *pagep;
-
-	if (fscrypt_is_bounce_page(page)) {
-		*pagep = fscrypt_pagecache_page(page);
-		fscrypt_free_bounce_page(page);
-	}
-}
-
 #endif	/* _LINUX_FSCRYPT_H */
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
