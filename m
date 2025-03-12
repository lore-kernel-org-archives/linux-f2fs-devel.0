Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3E0C2BA1B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 07:23:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsGRH-0007VN-6w;
	Wed, 12 Mar 2025 07:23:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsGRE-0007VG-Mi
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 07:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u7qwdmIzUJtvNbLI12ETJryPUeCWkR7N3+WK2fH53ZU=; b=Hkcr19e5H5Ns57UBzly6HWHzVb
 AJ+xQYLd2AbiLCdAjmPnM1SowYWL5ZTNoaoZorRHniOzkzT+7/dDqnR6hXsVR1DdExx7oYrf/RMCF
 zT7tGthOTtASLk1XWuluEJElcnkVZVQPakKcX+kpPynf4ejYYfthA3iyUDDSHdYH0He8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u7qwdmIzUJtvNbLI12ETJryPUeCWkR7N3+WK2fH53ZU=; b=gofpUIibC57ajbl98WQULa1mci
 WVC386EZ05iO40/gAg11gAhsFLqCYCah1e6d9TPZCMjeTsYCDWtObvj65zvnvlxu17OS0dLOdMSrB
 PzW+I4xCNW7sl8Vr2oq3LPe46JQvnRKyf+3WLqOYYcxGFVJR2Cu4UG28SU911kzQf9f8=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsGRE-0005AP-Ik for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 07:23:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E6ED1A46DB6;
 Wed, 12 Mar 2025 07:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F38EC4CEEF;
 Wed, 12 Mar 2025 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741764205;
 bh=q00hiySpvhpXJYh+xrABq/hBgwJTyFyvPK4VSBpvgqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h/QUBTOB5FODJqVSRUlgf/zrfZSgVH173w4GXnvTibnBIrjC30fU3CxgJTuFu4DQn
 k3A+fWHkOyDqtz7WyAK5Cz1v5mHzOWcvXrpRbwjoHnDMzbyJfotgzX4BBE/+BQUYa/
 /jeJxK4zSn3K8NbZuX5INgaE4YByw40SueyiQnuYbu7jAbSEpdUvEiTw6fJaiHnXv+
 RdgzmYuTmKqFlNuUd96jwdP/s/gCzfboIdxp70v3ahQN10EaTSPxudxeq86t/U7IsI
 VWt69Q9Ecw0UNGsZrCJDqxPzeFVuO/w/Av4VnD3lm831hQ1wu3TZKiaWnRInh9jjFH
 Fxl/YCoXFg1Bg==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Wed, 12 Mar 2025 15:23:06 +0800
Message-ID: <20250312072309.3989074-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312072309.3989074-1-chao@kernel.org>
References: <20250312072309.3989074-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tsGRE-0005AP-Ik
Subject: [f2fs-dev] [PATCH v4 3/6] common/config: export F2FS_FSCK_PROG
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's export F2FS_FSCK_PROG, then we can use it in
_check_f2fs_filesystem() later.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- no changes
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 7d017a05..79bec87f 100644
--- a/common/config
+++ b/common/config
@@ -317,6 +317,7 @@ export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
 export F2FS_INJECT_PROG=$(type -P inject.f2fs)
+export F2FS_FSCK_PROG=$(type -P fsck.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
