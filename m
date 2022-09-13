Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F633C6FA8E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Sep 2022 23:59:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oYFoL-0002O2-ID;
	Tue, 13 Sep 2022 23:59:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@collabora.com>) id 1oYFoC-0002NW-F5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 23:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Me7nQ7Qt+8UkL7nbZD5XTfeD2SYCxvRRo8RPBs6XHhQ=; b=L+WRsb5hO2whRZBuyG6Zvs8UhA
 ELOURZMXJfcEzXtm36H0+TVu4NL+gPRE/o7nsD2neyw9UTeyjCmoUAEu5uibxDPihGcrjiJhf3Kty
 pljMcNYjGnfmH18eWwGC5v8BIWo8hHSSIM6Uwdas1s4xItSoP8rPWhIapJsi3udHLBKY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Me7nQ7Qt+8UkL7nbZD5XTfeD2SYCxvRRo8RPBs6XHhQ=; b=n
 DuLI9B3eTHMxcH1L9ffBm0RreZEBDZ31IPagOp/BeV7+/MVxSPzRPblOu7bASKghTIKbRjGoZ4Kwl
 97kBnq9v4WB2tgMqqhNBy1ANDML4kMRPRusKpm6gnBs90Bv7lky7fyuKyidoQjPjb7a0eZb6iCCYc
 BD6b3Y8jQeKuaTs4=;
Received: from madras.collabora.co.uk ([46.235.227.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oYFo8-00035Q-6s for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 23:59:16 +0000
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca
 [96.20.102.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: krisman)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CB626601FB9;
 Wed, 14 Sep 2022 00:41:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1663112519;
 bh=NkYVyeuwI/2gBd1BQe2j2SOPCFHneHhCTKmec17TYMo=;
 h=From:To:Cc:Subject:Date:From;
 b=g+iniuRQu5VXHNund2XMCfZ2vMLAqfVZ2Ls+dexJ2CwAzNMjXu9EGk/8Y5+Rv7AQn
 fKCXKFPH4GMCEAAZkAHBvXZScoOdOyCn2/OBA4kMC/GrSxAJOnIJUekA5DWpb5HAlY
 xRbStlOQPcULVG8KAtl8oi5mLlGNN1/VBwI7NedFrgdjKlngOD1tg+qEHGCymSAEyp
 1HDjulkiZ7a2G5dqyvpmmbIEgFeCj8rQ/Y5CDW2ybqFbfQ6qtu+qCEefk/CRWsiwWd
 HaSMRO02UFmpahzjKOuvbriBn+tmdIYuKcxIo78Leck8iROr9PaJUUFN6+LesOyF4w
 ZqLedh7gaqocg==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 ebiggers@kernel.org
Date: Tue, 13 Sep 2022 19:41:42 -0400
Message-Id: <20220913234150.513075-1-krisman@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Headers-End: 1oYFo8-00035Q-6s
Subject: [f2fs-dev] [PATCH v9 0/8] Clean up the case-insensitive lookup path
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
Cc: linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
 kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

I'm resubmitting this as v9 since I think it has fallen through the
cracks :).  It is a collection of trivial fixes for casefold support on
ext4/f2fs. More details below.

It has been sitting on the list for a while and most of it is r-b
already. I'm keeping the tags for this submission, since there is no
modifications from previous submissions, apart from a minor conflict
resolution when merging to linus/master.

Thanks,

v8: https://patchwork.ozlabs.org/project/linux-ext4/cover/20220519212359.19442-1-krisman@collabora.com/

* Original commit letter

The case-insensitive implementations in f2fs and ext4 have quite a bit
of duplicated code.  This series simplifies the ext4 version, with the
goal of extracting ext4_ci_compare into a helper library that can be
used by both filesystems.  It also reduces the clutter from many
codeguards for CONFIG_UNICODE; as requested by Linus, they are part of
the codeflow now.

While there, I noticed we can leverage the utf8 functions to detect
encoded names that are corrupted in the filesystem. Therefore, it also
adds an ext4 error on that scenario, to mark the filesystem as
corrupted.

This series survived passes of xfstests -g quick.

Gabriel Krisman Bertazi (8):
  ext4: Simplify the handling of cached insensitive names
  f2fs: Simplify the handling of cached insensitive names
  libfs: Introduce case-insensitive string comparison helper
  ext4: Reuse generic_ci_match for ci comparisons
  f2fs: Reuse generic_ci_match for ci comparisons
  ext4: Log error when lookup of encoded dentry fails
  ext4: Move CONFIG_UNICODE defguards into the code flow
  f2fs: Move CONFIG_UNICODE defguards into the code flow

 fs/ext4/crypto.c   |  15 ++----
 fs/ext4/ext4.h     |  34 +++++++-----
 fs/ext4/namei.c    | 130 ++++++++++++++++-----------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 105 +++++++++++-------------------------
 fs/f2fs/f2fs.h     |  15 +++++-
 fs/f2fs/namei.c    |  11 ++--
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  68 ++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 11 files changed, 198 insertions(+), 201 deletions(-)

-- 
2.37.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
