Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25CFC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 21:24:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrncz-0001su-Ma; Thu, 19 May 2022 21:24:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nrncy-0001sj-Kv
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZrTv3QvLLHyK75XRTH4iFVs4p7lsGGVaLxI2nvRmAAM=; b=WnOxLzPh71svJqLwo265IkRxar
 PKEbpxdSqADrFF90tMPRtvu6CGuI+u5KibxwaEp3mIxtEgyMGMA6FsmWBZhA2/PlP77dyqSipuVxa
 b2GExIXcod1G5U42CcHy/umS9d2lhdMqBv3+sW8Hm/CzsteoW5ozuXKYZqgnb3w+1jAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZrTv3QvLLHyK75XRTH4iFVs4p7lsGGVaLxI2nvRmAAM=; b=D
 MiV5keUfDhkq/JTe03gW1WEWX44ux6GBTKqUq9We2CX3BIR6FTA8AFh0DN4cBq6cMjJIOlngIf8O4
 idAc9Eaj6JiaQjzeN+AiI2Z/0vu87oXPhVCOyaRBhldVLsNYsWIVYtaUSarLfkFl2iRkdy8/6x293
 kfCiccSxPAzfI26o=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrncw-0003ro-Tq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:24:11 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 880C01F45EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652995444;
 bh=xCVBbVqmp/7jdLxAOUghr2fFaWRVCwCpo6pL22/iD0s=;
 h=From:To:Cc:Subject:Date:From;
 b=VHzlb5p5uTnIJL9Fs9GAtX9nIvNF1bAC5lywlDj7RP7kYwQQG7YI+TSyIJExeaqjR
 nNC3SBrlIOSLYpznDuIfg7ULqavjlBfshG0DGu+P5L7M71Ksn8Gh8GIvRGGOmKx2Pa
 hU2M7T8jrNzXh020lHr2Uak9srNi+0Dn6CLDNexowOV2yK+0H4vLCFlhglSj0iqtyg
 tPEwsTkigWYsKGPM+LORkOCQ8Vm3hzEBOCvjLlV+8+AUU3vpnVUH6ZvZAMyWEjUi0F
 /BNAvVj7a9lQQZBhtYPEJiAlooJXOVxcxKtfAEUtrujgphiz6M4/SiBV9WCtTOyIL2
 BwSXjXMdvxkGw==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 ebiggers@kernel.org
Date: Thu, 19 May 2022 17:23:51 -0400
Message-Id: <20220519212359.19442-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1nrncw-0003ro-Tq
Subject: [f2fs-dev] [PATCH v8 0/8] Clean up the case-insensitive lookup path
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

Hi Eric, Ted,

This is v7 of this series (thank you for the feedback!) .  This picks up
a few r-b tags and has one small fix asked by Eric to handle a corner
case in ext4_match when IS_ENCRYPTED() and the key is added during
lookup.

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

 fs/ext4/ext4.h     |  49 +++++++++--------
 fs/ext4/namei.c    | 130 ++++++++++++++++-----------------------------
 fs/ext4/super.c    |   4 +-
 fs/f2fs/dir.c      | 103 +++++++++++------------------------
 fs/f2fs/f2fs.h     |  15 +++++-
 fs/f2fs/namei.c    |  11 ++--
 fs/f2fs/recovery.c |   5 +-
 fs/f2fs/super.c    |   8 +--
 fs/libfs.c         |  68 ++++++++++++++++++++++++
 include/linux/fs.h |   4 ++
 10 files changed, 197 insertions(+), 200 deletions(-)

-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
