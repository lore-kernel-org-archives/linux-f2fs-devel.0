Return-Path: <SRS0=rqbO=62=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A4C2D0F8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2020 23:36:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F851206F5;
	Tue, 12 May 2020 23:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="a07D6LE8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="e/MjlLA2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SITX0Uc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F851206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jYeRi-00088T-B3; Tue, 12 May 2020 23:36:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jYeRg-00088D-OQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 May 2020 23:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t0w58PLIgzzsr7/STKiAZLYfk9q8jhCoDDzdassOWmk=; b=a07D6LE8htKISr18PolzIs51Y1
 jPzG2DGcIfVkD6Si8MHeYFnVuLd8abfD8I9xY/OmNMG24Cvme/G+PkpIZFHm5+lzIjmjluIXMpS9S
 iv9AJ4Iq8xNecFVkW4OAfhm3II7PPmylHeLfTeksCtJIJX8e6ouueNEIXiQwkc7Ruozg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t0w58PLIgzzsr7/STKiAZLYfk9q8jhCoDDzdassOWmk=; b=e/MjlLA2IH9iKnvC9E0bG0CpDX
 q1/jsW9khwLwYlOKtgjTjjo8j/Z8R2DZuD6J0UqADvLcdjA5ZjJQrkRgcbKr7oWBs+t/j8Og1wQxP
 bH2yNz8vaWCAAbcIw+ooTX4D3H180njcMmtTH64bGf0NbOmVZ8CLRjoL9K4EP9TNR8us=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jYeRd-006x0I-TJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 May 2020 23:36:20 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C09620769;
 Tue, 12 May 2020 23:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589326567;
 bh=/L5xK29ViM6H3K9diQ/RKFdZi3A2yxf+q63QlofvZKw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SITX0Uc6cMqd/Nx4GmNh0VLRUjEvlCxuKD67PPh8tGhogHIO8Tac4vLmagL3S5tek
 xnJqA+d98BFL7TRYI+7VEKSZNKuWmBGbrMI9mjHKr/wrjKCPjP0k/vBUGEcssM1Qf4
 C1jbi5q9p7UHDRxUrzBVEqdWLDAidSecKoRobD28=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue, 12 May 2020 16:32:48 -0700
Message-Id: <20200512233251.118314-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512233251.118314-1-ebiggers@kernel.org>
References: <20200512233251.118314-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1jYeRd-006x0I-TJ
Subject: [f2fs-dev] [PATCH 1/4] linux/parser.h: add include guards
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>, Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

<linux/parser.h> is missing include guards.  Add them.

This is needed to allow declaring a function in <linux/fscrypt.h> that
takes a substring_t parameter.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/parser.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/parser.h b/include/linux/parser.h
index 12fc3482f5fc7a..89e2b23fb888e8 100644
--- a/include/linux/parser.h
+++ b/include/linux/parser.h
@@ -7,7 +7,8 @@
  * but could potentially be used anywhere else that simple option=arg
  * parsing is required.
  */
-
+#ifndef _LINUX_PARSER_H
+#define _LINUX_PARSER_H
 
 /* associates an integer enumerator with a pattern string. */
 struct match_token {
@@ -34,3 +35,5 @@ int match_hex(substring_t *, int *result);
 bool match_wildcard(const char *pattern, const char *str);
 size_t match_strlcpy(char *, const substring_t *, size_t);
 char *match_strdup(const substring_t *);
+
+#endif /* _LINUX_PARSER_H */
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
