Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C5AC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Apr 2022 21:18:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ni0fu-00014V-T8; Fri, 22 Apr 2022 21:18:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1ni0ft-00014H-IH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 21:18:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eTTKyFcOA2Z9d74Wdim761lvE4vxACqXDiO+v9prCCs=; b=Rqv3kC8h4O9yGumUtIBbHg3RAA
 K4SVS9m9PAzGIquliAwXrUsYcshkGQgC3+KTAfWSlk9NCHfrFz9CqbGzKIwXNtkW5jmMnbo1q9TwO
 AKEPRSxDUTOBsCQ8BTYeptdETB1uLBgurGTA4JgY2rvRcxS+8x0u6CUSGGQAeaz8YiqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eTTKyFcOA2Z9d74Wdim761lvE4vxACqXDiO+v9prCCs=; b=PCOPtI8/82fUQj6m+PfELQk83L
 qTWGE4VX1Gn5yZYig8470T+9LmNDQPuue5a8XT6bFg7cz625Ufb4/Qej+DrSqzef6i8W6cbZigXJg
 dZn53/QDClU7PPtpdjA3g51MN0AM46xENqgSGt3VxRY4MBIJKUfWt76JdZhK5oYaBq4I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ni0fq-006rCL-4Y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 21:18:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8322E61E76
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Apr 2022 21:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4605BC385A0;
 Fri, 22 Apr 2022 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650662309;
 bh=1xqGk9515hwxNd2PBiRzVzbl+fp1PNbvgLO5lCzLVcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MP1bbwrcnMnc9y5mAkifi99HQs1TNFtSEQAnPR4NAOBjR7J0Vyh0FsmY3/z02Hnlz
 S5gFWHNVpGBO4M2nL3pf4YWF2R0vbyFHmjLN88zgc7qEi+TNWLiTDhqiwmAQetncT1
 MhD+LVZ4TZnVmmTJ5hstm19NYH7Vc2mtQMDPcspdEfbse5En+WnzPT95f4JG3U/4T8
 3+cay3Ckwfw1OiAZ8NY5MLCNzkld4HoGqS5n4rFvbMlL4cfWLRt77Sh5s+jqLyIqHc
 WTUf3/6DIb5W6nrhvYOANAztO+SxO+EeITwvLHQqOCubh42STAH7nsm3sYPshu6qax
 fad6TEuKG1D6Q==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 22 Apr 2022 14:18:19 -0700
Message-Id: <20220422211819.2230879-6-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422211819.2230879-1-jaegeuk@kernel.org>
References: <20220422211819.2230879-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1ni0fq-006rCL-4Y
Subject: [f2fs-dev] [PATCH 6/6] mkfs.f2fs: check uuid library
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 3 ++-
 tools/f2fscrypt.c  | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index ce7d1c9e40bd..2759b5a03bc4 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -24,7 +24,8 @@
 #include "config.h"
 #ifdef HAVE_UUID_UUID_H
 #include <uuid/uuid.h>
-#else
+#endif
+#ifndef HAVE_LIBUUID
 #define uuid_parse(a, b) -1
 #define uuid_generate(a)
 #endif
diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
index f2fbf0bf3878..4c5d87036225 100644
--- a/tools/f2fscrypt.c
+++ b/tools/f2fscrypt.c
@@ -356,7 +356,7 @@ static void parse_salt(char *salt_str, int flags)
 			perror("F2FS_IOC_GET_ENCRYPTION_PWSALT");
 			exit(1);
 		}
-#ifdef HAVE_UUID_UUID_H
+#ifdef HAVE_LIBUUID
 		if (options & OPT_VERBOSE) {
 			char tmp[80];
 			uuid_unparse(buf, tmp);
@@ -384,7 +384,7 @@ static void parse_salt(char *salt_str, int flags)
 				(((unsigned char)(h - hexchars) << 4) +
 				 (unsigned char)(l - hexchars));
 		}
-#ifdef HAVE_UUID_UUID_H
+#ifdef HAVE_LIBUUID
 	} else if (uuid_parse(cp, buf) == 0) {
 		salt_len = 16;
 #endif
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
