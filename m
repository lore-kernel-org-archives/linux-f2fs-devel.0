Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B42C28B2E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 07:23:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsGRO-0001tH-5I;
	Wed, 12 Mar 2025 07:23:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsGRN-0001t8-GN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 07:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dA7LXPEvhAZBAYkvx7TckTbESfKabFKuXT8fMaNI89U=; b=gkWfBwDFx3WscQ0SoNgXyqd8I1
 4aPhdkbvfujdHHNDphTDriKiU0QVuT2gl/FULgssqlnJCNGrNj/A1tkzE1ljEwAXeB5zkQlrD06/W
 Gh+j+dvDcsHNJomGdTXKAODEIeebaWSOlzJqTv/OwWS+JuaZrTWTvBikkOY7QiJmRsrY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dA7LXPEvhAZBAYkvx7TckTbESfKabFKuXT8fMaNI89U=; b=e8/yWYsgpvtS5SN2P7sgQp+mvT
 qDqySIfKwj/imULRqdiwkhseQaVIVJ3rp5+wxdo7A5R8JJQvazQfb6MQBaMIxvK4Gn1Dd0+gwS3CX
 7He3ogQasFyO/KriabuchJBB4ubbd9NzaHZhhXsjTjQrramaDdYL6QZnoYioXX7YDyms=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsGRC-00059w-Rr for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 07:23:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2F0B3A46DB9;
 Wed, 12 Mar 2025 07:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C3C4CEEA;
 Wed, 12 Mar 2025 07:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741764203;
 bh=ZjQBCbVNJ2p7dPP/EufdPPhi1TlsTlE8Tg2dAj0UrIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tEcthYLTFarRzRpboTGmFuBf9HI32xOrBtr2u+ZzoW53cmysUW7SBUnGQ2va508kr
 5mOGfOnrcfCu66dM9aH3blbV8itS/V2C/xiwX3vcmcrAs1puZHrwUPdiwwBv9k+37E
 FZmEEsfng89tG/he10sRY4eDjUvuB5a/b/U2pl4bJ1nMkcrKPx06UUXjHeAyWF7wPk
 KQW9IDmmctAIgcgRb66AfAfEYWZmTih3eQxSlmiuNLG1uRXcSjqyLHOXr5fbmoZz48
 e7hl0DvgRS6HPQgwMzUSsx+rzhg7fyn5+FSLERETCTjve2mUymRceup6zF54ojamyr
 +0L0euQnhNajA==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Wed, 12 Mar 2025 15:23:05 +0800
Message-ID: <20250312072309.3989074-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312072309.3989074-1-chao@kernel.org>
References: <20250312072309.3989074-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tsGRC-00059w-Rr
Subject: [f2fs-dev] [PATCH v4 2/6] common/config: export F2FS_INJECT_PROG
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
 David Disseldorp <ddiss@suse.de>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- no changes
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index aa525825..7d017a05 100644
--- a/common/config
+++ b/common/config
@@ -316,6 +316,7 @@ export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
+export F2FS_INJECT_PROG=$(type -P inject.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
