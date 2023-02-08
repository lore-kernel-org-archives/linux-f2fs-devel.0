Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F94C05027
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Feb 2023 06:21:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPdq8-0006LN-PF;
	Wed, 08 Feb 2023 06:21:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pPdpy-0006Ku-Ue
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hDaq+hzSVVr5/sihIKGTr4ISu/lQ4Nf0whpSXh44p6Y=; b=N/adQMzFa+rw2yQyYtz4thmf4f
 vxzlcLRLqWv13Vp0C1PS4HSQVOc8931tozcM2GlzLrxSPimv1m7ZRixg6cKmOkcGKbJ9FDPYl+q4n
 fbzEtFbgQIwziOb0bX57rCRd9spqHszo0uTvu1eUzo/nhq5iQxTe2xblg8J3KdwGhJvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hDaq+hzSVVr5/sihIKGTr4ISu/lQ4Nf0whpSXh44p6Y=; b=l01kFvY5TXvYgbKCg/tVf18+3w
 EioAOLhAtmSidn52l2fziCLVogcBcRC+8FIc7v+EJCHRbZ7BNHREut4IjNQW4gSOi6ihSzrJJiJKo
 pdxsXaXuTvOTWmI3Mvf/zaw6yxN7B0807VQQQGrkbDhEq0stERom++JfKZf2bAdKcfgA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPdpw-00EiFu-Uy for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB85614E4;
 Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962A8C4339E;
 Wed,  8 Feb 2023 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675837295;
 bh=sQVJxIPMagQOo1HvXPpx7fyeR0XGhmDecu3YxyPB1CY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DbGtwnF4VnuwU4on1O7/cEfWfHUtx13gh7P3p8mGefvuSnr1Ike5IbZgNRonYmLak
 TlZiwaey1dosbaeUDX+gS6i63mlXqU+UUnqw3ObBCq5amvYOD+PdMoBuEbDHpWdTeE
 7Tf+IAkd9SNsWzJrexAGucM8cE6kuRJGukl+uiN49e23GgXqvpHO04TJjfHzI9VhdH
 dPlxSQ6u82GVy9gg6YzNeoUC8+osvpsuBem37izs+Vr7b9l0T48EplZNtLsVCjt7lB
 lBZpV3e3rS9HUxDLQYLa0e6DwSGUDLlMXwL7Bb8UZoX4o17JL+rQDuXZ73F7xtKhQq
 B0+C/uOTOfAog==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue,  7 Feb 2023 22:21:05 -0800
Message-Id: <20230208062107.199831-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pPdpw-00EiFu-Uy
Subject: [f2fs-dev] [PATCH 3/5] f2fs: stop calling
 fscrypt_add_test_dummy_key()
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that fs/crypto/ adds the test dummy encryption key on-demand when
it's needed, there's no need for individual filesystems to call
fscrypt_add_test_dummy_key().  Remove the call to it from f2fs.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f812b9ce985b..64d3556d61a55 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -540,12 +540,6 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 				  opt, err);
 		return -EINVAL;
 	}
-	err = fscrypt_add_test_dummy_key(sb, policy);
-	if (err) {
-		f2fs_warn(sbi, "Error adding test dummy encryption key [%d]",
-			  err);
-		return err;
-	}
 	f2fs_warn(sbi, "Test dummy encryption mode enabled");
 	return 0;
 }
-- 
2.39.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
