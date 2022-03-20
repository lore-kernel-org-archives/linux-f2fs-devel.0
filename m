Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D10C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 20 Mar 2022 15:11:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nVx5i-0007vS-6F; Sun, 20 Mar 2022 15:11:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nVx5h-0007vM-F3
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 20 Mar 2022 15:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rTkeYiQ/FFKhx5QX5km/qZAOTZEelVXkSoHggiBqt5E=; b=eFYLi7B+/p9iBTYGMdRqf2Edms
 zxh1nUeP8x4/E3JHaFAylOUNHg0AKcT+muG17I1rL+oa1KkYjZInyubg41U90NnrSUgSO5t0aKEcq
 zp69DJSSSJv/Uu78m7lLdz75RQWQfrEC4vEMzE+iFUuX6LzabrJBehjBAkZwR7r2p/5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rTkeYiQ/FFKhx5QX5km/qZAOTZEelVXkSoHggiBqt5E=; b=VnzSqI9QN9MyYVzN6QUemkgWHB
 /lUJ+YPXjxO16+i/mJZ30TRe1Z7uTLh5Qh8dLyjf8g4iBzKksoDLZ0K7RO5a3dcl3Yq51mPRJmWNB
 L0ilQ7jUlFtZMQYANPaU7ovGCnWpxijal6acJaNFMlanhaD2CimoomxpZ5mg2mjsjWrA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nVxDb-0052qQ-PM
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 20 Mar 2022 15:11:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5641A61163;
 Sun, 20 Mar 2022 15:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B67C340F3;
 Sun, 20 Mar 2022 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647789092;
 bh=5l9NEIMcyP4FPt0pdJyWoMggxzOU3w5z/HzDfaBdRaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ng3QvHUvZx0Mk8NXcpdjyMBYfixDbP03eAaPCBcG8CeuH5QRwn9/NqXHToa4s1g/z
 J5JVVrEJZs0wYiRDB2UQdgeIWl67D62kQzucCP7h6lekdlt/fcXH3yBRLAbTHpvZ0v
 4uHPxgjCaY+u+Kp+QVDmyhd4eW+lB2DkXgPigkFzQEuMsctPKwjqFeWD+WrjySeogv
 HZqDTn2dFRGvhcxeF/fFmX6zicre3q1u2xhKT+8bsPmDEJo3ZjKjmMpv6T9gJZsM4j
 /KTD8UBXP5rvHO1fMc09dPoR7JqCKJP1FxY/uXQxDEUPvP3LzlIB/cVVQQoioAjcyY
 QfY8FMhzQwyDQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun, 20 Mar 2022 23:11:18 +0800
Message-Id: <20220320151119.837552-2-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220320151119.837552-1-chao@kernel.org>
References: <20220320151119.837552-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nVxDb-0052qQ-PM
Subject: [f2fs-dev] [PATCH 2/3] f2fs: don't set GC_FAILURE_PIN for
 background GC
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

So that it can reduce the possibility that file be unpinned forcely by
foreground GC due to .i_gc_failures[GC_FAILURE_PIN] exceeds threshold.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e83c07144d8f..6a7e4148ff9d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1202,7 +1202,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	}
 
 	if (f2fs_is_pinned_file(inode)) {
-		f2fs_pin_file_control(inode, true);
+		if (gc_type == FG_GC)
+			f2fs_pin_file_control(inode, true);
 		err = -EAGAIN;
 		goto out;
 	}
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
