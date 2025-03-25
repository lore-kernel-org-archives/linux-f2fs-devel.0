Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF0DC35FFC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:58:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tx3ru-0005Kg-EG;
	Tue, 25 Mar 2025 12:58:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tx3rt-0005KZ-H8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 12:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bJjFCLCPPVcO472WZ4SPoV39yUGXFECO4TrTlkUm/B4=; b=O0iUW+c4TTYahmimYjyUM/QfrA
 Vq5lOZdUaOrRobQCWagUtad0OjpEbpIIz6Pk0PS9IIvQHciGk8v/MIpBQA2fdrKH9II+mnpCakjka
 RTHKvVoAddktG2u87NBWOaUrfJlygH0mc5MYx+VPs095FP5qF+KNu11KrgSa9TpLr0BI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bJjFCLCPPVcO472WZ4SPoV39yUGXFECO4TrTlkUm/B4=; b=aJzX/mq4O7Ct3S8pXyVf22p8zN
 3R9BhrEChjIIsvi+3Sr27nYq2i6yYLqgfJEBoaDH+xAPjDw54awRlq28DKOOEdoNmNrrmMHQdgDkh
 IGPSpizGjFgA33q3SHP/ouwFv4u0zCih4xir1hhEYMPQWL3MAUvxVWIFLRgxy49z9Fkk=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tx3rt-0004AW-Bl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 12:58:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AF544A4A6E5;
 Tue, 25 Mar 2025 12:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25095C4CEEF;
 Tue, 25 Mar 2025 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742907526;
 bh=MjEyGyyl7AWswcFK7usJ4ngiXueb/ZAlQKbJoWJUfJo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Btgm8qLKkZb/zIk2pHCPlr/V+crjFxJoB4Bkp5HYSDmP5/LLlKA34qHmP3cZCYsre
 qKXWL3dHTVhqYsI1fc0pGXUKajrJAnW7wIyJDQCAS2rU9TXkpVClB54iaOXqx/jD6J
 RMddRb2nbRsvEOg6F6Fbl8hGVoMfMg3v87jKlYSRsGhL95N93kwjk03/OJ5REFb6CZ
 3CoEAM64pPh1azcL4Qe3W4rTYp6mmMTj4dGVwVkJUWazmYeEfRfI8hXpNn3sZ6sM3S
 GVKoRl0/k/nj0Pi5wpvPoL1MugiBFhD7KSFhZZLeI/w2O8RRc9UxFXEFvUqi85Kx7k
 wAdMgll41nVLw==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Tue, 25 Mar 2025 20:58:21 +0800
Message-ID: <20250325125824.3367060-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250325125824.3367060-1-chao@kernel.org>
References: <20250325125824.3367060-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tx3rt-0004AW-Bl
Subject: [f2fs-dev] [PATCH v5 3/6] common/config: export F2FS_FSCK_PROG
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
