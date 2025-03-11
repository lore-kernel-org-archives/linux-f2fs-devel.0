Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA8C28B2F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:04:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1trubW-00052E-Lf;
	Tue, 11 Mar 2025 08:04:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1trubV-00051y-3F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 08:04:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C4o+pnKbVPfMuA0uQ/zNBQOLEbBGKbOEy0Yxg0LZa1w=; b=QPwljgA5l/HfxNJy/dDMK+mHfI
 4rvTnpLRbp51ER7yd8fbGV087oNy7IzhrJWaub7llkf2/JzHaF63X5g2RhCZFKpUt/5YtMSdCPoO8
 N2odPSyCfZ2d47ESN6I/0k2bWxaKwV7T3ksakVUxY15P8UEy3J770oCYeYnlWy85ZIYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C4o+pnKbVPfMuA0uQ/zNBQOLEbBGKbOEy0Yxg0LZa1w=; b=WP7pBuP80H0c76l++Hh/oSZFZz
 YPnKtyH4etRwc2mjQYAfR6a9K5DP3bGvUmmljnX3aDnhJa5OwnxpgOMJ/gjRApg1PwaA1oPlxMXd2
 J0UOeu8AAZXPMnKat9+xwySkPonyVZifF+sYqYMpICIdVT6y1/Qrc8fSXjpmSM3+8K1E=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1trubV-00050s-8c for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 08:04:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7978EA46950
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Mar 2025 07:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF84C4CEE9;
 Tue, 11 Mar 2025 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741680279;
 bh=JtORvqb0o9MIu77+gkKC9qpeB7WkMNSWAwBvZCooKgk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X6x1kcSEGedOAfnUUBoYd6b3rklwKu7mUOC57IkZrcjgZczC6iflr/LxLiYhARSFP
 KYGnV968XQgulgJyEQ+6uNzgNRWc3ev+Aaw93Z8vSt8kz07m5UxpAnVGSZS4b6sZo3
 HZCJY2pCAX9nlxzxoWK+MoSiVDikbi4UmUgz5GD/6BmOg1MBmCNKvlQAhXomF1dM1V
 j4TPRTJRwPBSvHR9+vTsaHprfft7vGp/ZNX2oVEPBXusHzx8K34tOmk4gckg19RhGN
 Twk2dyeZgCeDatHM23IGxxkBdnaalHjBSFiQAhwse80aDJbxeRuHl5yJp8MnYzI3UB
 5ckN3gsBcD8xg==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Tue, 11 Mar 2025 16:04:27 +0800
Message-ID: <20250311080430.3696582-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311080430.3696582-1-chao@kernel.org>
References: <20250311080430.3696582-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1trubV-00050s-8c
Subject: [f2fs-dev] [PATCH v3 3/6] common/config: export F2FS_FSCK_PROG
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's export F2FS_FSCK_PROG, then we can use it in
_check_f2fs_filesystem() later.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- export F2FS_FSCK_PROG, and it will be used latter
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
