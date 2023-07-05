Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC99C0015E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Jul 2023 21:29:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qHA42-0006fk-2O;
	Wed, 05 Jul 2023 21:29:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qHA3l-0006fa-Fy
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jul 2023 21:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vorQ8+OFyacNZqWtUOJfTKcpv4BquuPIfrdKUfdy42A=; b=K+LrcMMMxWsyvH7PPM8TQs40xC
 NF4nx2c6BJoGyGjQ1qNMqnb011XPcu58axwHXIqf2QZ5WiM8P/V5//5yqfCl7vJR6cVfmS2g2nm8C
 +5ICdGBovdr51bbg7kKBIPOfLIanG1TvSLTsGy3F5ceHLfBP0qIqYDQgic3ljNk3cmZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vorQ8+OFyacNZqWtUOJfTKcpv4BquuPIfrdKUfdy42A=; b=i
 OJ48g4EDkVwcFtQIWqGqy/Ta6caE+wkUQJquTLa5ilTC7hw3z4mrPz6KeZ4ZtrqtsIdrY/qonK5rl
 tjp4oFoexmF1+EgmfMjQpgCOxFbWi4Al8h3ZckpxaaO1xF0ocwQZkw5DgMIJ4I/JArgHSfCxPCdn7
 YUvZkT9zLTy9Slm8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qHA3k-007cIg-2W for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jul 2023 21:29:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF7E61751
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Jul 2023 21:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A554DC433C7;
 Wed,  5 Jul 2023 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688592545;
 bh=n7svmHUh1Z6GbwcL6k4hTmYd2sPiWtLOTvwd8wlcx48=;
 h=From:To:Cc:Subject:Date:From;
 b=sb+zENMFLr0TYlhy6muwquT/CgUn1f+YoD+fgTheZs3ZaIo05qoY/oXk7FLYXWLHI
 imptyVlAgYbrhXscBuZJ4ccYhKVhilV/ZaAGXTTasdep6+ZPYz4dqAkqWvXPaSG9S6
 BxNF1CTgsJytitzcZZsA8r1qCY57EAh1knPg/Q03dPdfd+m01uKkyg3EV2ryNQs838
 DyjWgrP4V9RQkq/Wmq3yrcldCMpaQ7vgAKNu9tlHWAuteZFQtzZs+iAethi1wuW8WI
 19VnR7R4s2q/l/6ju2aoXYGbIlsfuko4q68BHDIKq2Zm2EPoK5fDFK7kg6KUFN5uT9
 1WD0NGkvxG+EA==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Date: Wed,  5 Jul 2023 14:27:41 -0700
Message-ID: <20230705212743.42180-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Headers-End: 1qHA3k-007cIg-2W
Subject: [f2fs-dev] [PATCH 0/2] fsverity: simplify initcall and move sysctl
 registration
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
Cc: linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series simplifies handling of errors during the fsverity_init()
initcall, and moves the sysctl registration out of signature.c so that
it is not unnecessarily tied to the builtin signature feature.

Eric Biggers (2):
  fsverity: simplify handling of errors during initcall
  fsverity: move sysctl registration out of signature.c

 fs/verity/fsverity_private.h | 12 +++----
 fs/verity/init.c             | 56 ++++++++++++++++++++-------------
 fs/verity/open.c             | 18 +++--------
 fs/verity/signature.c        | 61 +++++-------------------------------
 fs/verity/verify.c           | 11 ++-----
 5 files changed, 55 insertions(+), 103 deletions(-)


base-commit: ace1ba1c9038b30f29c5759bc4726bbed7748f15
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
