Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8494EC636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Feb 2023 06:21:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPdpz-0007dn-KH;
	Wed, 08 Feb 2023 06:21:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pPdpx-0007dg-VX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5YCJw/RLnPdh8GovstVbf2rVyqeI/UAHHsIVqhugQMw=; b=eQSH/QEUdBvVXQgLG7TO4qfJ+U
 S35e/6CwP1ZYlGS4O45QDxsilOju1pQdYrmwSew0E8wqRQk+polmZwVv4npdmd4cl9pXbdsL+XmNd
 wpHvJorFXw1KL5xKx4tF33i8R3vp2qmcriwdaGGG4yfm1CaUu82+6Iuuhx3xKaOvgu/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5YCJw/RLnPdh8GovstVbf2rVyqeI/UAHHsIVqhugQMw=; b=fAyEgJ0WBIa2o91kWL6rOBmyQe
 fctVQCcA72gkGEQ1pjvEzyXrShhtGrIS+bEAQo9VW7oZQlhMLVUsKjJtYReiLBlq637S8sUt6DESe
 nvN7CUgbLbeDNxkwWLffJR9K6NoJIuTtF5exD87nha8AD5BQM9IdJT7ox9JSQ9PJRGKg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPdpu-0008Qp-En for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4A04C614E2;
 Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C28C433A0;
 Wed,  8 Feb 2023 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675837296;
 bh=yjmeR+HuHfvezqUObRjW0JmkMkN4qqziD8/F7kQFQoY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hT9wbh5lvDI4fsinMVQlijsAmGKYTa8mpzuBKjJvZdcI59ojR9Cc8Y0JeTfP6EcUW
 gnmWte7KXT5+7DMRhWstF+GOYeEdc0mWM3C9q2/d/uS++ZXpPcKaWFLMX+5Bz0KcXV
 svLKcryv3OwMsB3NjgUpy1TI4h79P4ZvpFk8EY2LMpMMK4U8+/AEy4nESn4eHgVt2Q
 LDB5rnitSdhws3R/f5wYRp6nIbFdruxxBqVUbwNsv97kpoCbHw1Myev+E+sNUpoVfR
 qJTkvr0Y+k9p1FoLAfA1PRBrCLIYncTqVpO0qbIa2pNsuyBF39Uj5wCQbAp8HfXVcz
 N+FuuAq++dH3g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue,  7 Feb 2023 22:21:06 -0800
Message-Id: <20230208062107.199831-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pPdpu-0008Qp-En
Subject: [f2fs-dev] [PATCH 4/5] fs/super.c: stop calling
 fscrypt_destroy_keyring() from __put_super()
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

Now that the key associated with the "test_dummy_operation" mount option
is added on-demand when it's needed, rather than immediately when the
filesystem is mounted, fscrypt_destroy_keyring() no longer needs to be
called from __put_super() to avoid a memory leak on mount failure.

Remove this call, which was causing confusion because it appeared to be
a sleep-in-atomic bug (though it wasn't, for a somewhat-subtle reason).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 12c08cb20405d..ce45b7fd27f90 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -291,7 +291,6 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
 		security_sb_free(s);
-		fscrypt_destroy_keyring(s);
 		put_user_ns(s->s_user_ns);
 		kfree(s->s_subtype);
 		call_rcu(&s->rcu, destroy_super_rcu);
-- 
2.39.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
