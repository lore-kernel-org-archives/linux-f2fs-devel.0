Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92F6C636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Jan 2023 14:47:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMruw-00051U-Nw;
	Tue, 31 Jan 2023 14:47:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pMrut-00051J-Dm
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 14:47:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GmNaIi+ixbD4cZnUhvF4wZ45ugwmMIQjvPAb9K7xk88=; b=NBGqTeQG5paCyrociQVWiomV9+
 wKnXA+wKCbO5jPReXv9oXRJ0iV7aEK8kOmfOYJ/nDygfzwYRpKnZu/MVpFO2hTHnqA0+7ksSNaMcF
 plUxIU9v2IBCef23Hf9jKRtcDU94Eel1QyxnAVygu9eZkYqHwZejaqXVfKvUvWt3JRV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GmNaIi+ixbD4cZnUhvF4wZ45ugwmMIQjvPAb9K7xk88=; b=A/9teQaeAzdon7U2TV80CL3h2O
 QJtXIfL04/6W0rJ+BWMaFhq9tMGq7TkAOYxf7z+HNlhOvqRJSP7zevJolqrxot8PdYS2mHgSB1aDN
 qsjyRBoY55B3l9me2/8Y8BKES+FOhQVMGpdrJbx3cP9jHcuXKaL86JdvjTSBAag8hkmo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMrum-005Nzm-6v for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 14:47:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CC50161548
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 Jan 2023 14:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2603EC4339C;
 Tue, 31 Jan 2023 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675176430;
 bh=fHwIuqaUuMg5+WXKD6YgXPsdEqVlJYuXKPQIpe6n52A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cHNqm69tdUwpoBfLCMhg7nBegkoqKVbDKXOdq61CYE7/k0DP9jA3TkEXyYogDWAO7
 UFpUztxi7RoVBfibSn8vg78LvzH26y+/4yuUrUcLEe9aeZvrHjG7EO6lVsEePsCyzF
 FDpnUDnmf3O8QvLb0F+7gSLEQ+PaNBG5C7zjdh/n9Py4mppEpKcEEeBH6JrNXGLFtm
 LGr2P35GfCPWrk+7MnMckVIXq1eM8+Cu/5UkfAzn7jkV3XscXcwQlJ6hs/48cgA/3/
 O0pG8TfMe46nppq0SMLzvDoQ0g7z4t7VuCq7Lo+e5q6tmgl3we9U3UTVvbnUqPSC2X
 Wl+1AXgyVURMg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 31 Jan 2023 22:47:01 +0800
Message-Id: <20230131144701.34418-3-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230131144701.34418-1-chao@kernel.org>
References: <20230131144701.34418-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pMrum-005Nzm-6v
Subject: [f2fs-dev] [PATCH 3/3] f2fs: fix to update age extent in
 f2fs_do_zero_range()
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

We should update age extent in f2fs_do_zero_range() like we
did in f2fs_truncate_data_blocks_range().

Fixes: 71644dff4811 ("f2fs: add block_age-based extent cache")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 746ffcd09b6c..60488749c35e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1494,6 +1494,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 	}
 
 	f2fs_update_read_extent_cache_range(dn, start, 0, index - start);
+	f2fs_update_age_extent_cache_range(dn, start, index - start);
 
 	return ret;
 }
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
