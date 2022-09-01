Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEEAECAAD5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 19:33:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTpwj-00045P-PB;
	Thu, 01 Sep 2022 19:33:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oTpwi-000451-8T
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 19:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zrGZ4cyS4KosERrDlZCd0HZQZn9oOspKa2Q72MucoEo=; b=LL2DrAhVN/j56LNS24+oC49eK7
 hFbNsK8bYf11G72Nyw+1cP7OFdDrXK0GajPcXxtERbP4P4paddw0iru6s+ifTQq4QCL/+GGSNi87I
 sw0yQOb3qQmBJvFp+odvvE01xlPFuz4mObejHfl2DsygVB3DTBeRDF7ROBSbsa16QsoI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zrGZ4cyS4KosERrDlZCd0HZQZn9oOspKa2Q72MucoEo=; b=V
 2yXxEuBJ83gXmW4QF+ImMii9H1OG7qmDEkrqfnqTPa9B6YBA4iL5tQn54B3YNRQPRPZIHli5uaxE5
 bHYngEhNBR+WajYpJAOGjV5FWhsEm29v1lk1/r6jZXY+DV67DSLihagjMC+ZtY1FuoOBI7M1ro5lv
 QPOSJdIlAOQhTGng=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oTpwP-0007ZX-T5 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 19:33:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 25AF8CE2952;
 Thu,  1 Sep 2022 19:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0971C433D6;
 Thu,  1 Sep 2022 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662060792;
 bh=Pl43GYt6Xsc/ANMGGsY4FRqWrbIBaTw6SVq8MHkVlFs=;
 h=From:To:Cc:Subject:Date:From;
 b=ZlWrYLUtM87oJ66958+byIVSwRs09ENVP/W42o9oocn7HaYiu/XKLb8X6wcrXrlVy
 nv/MTQpOkpOWC/2y6gyhxXTE3it53EuluzxehIX2libyt1KBRpauiHEAkBpwZawOvw
 vrCoZ2lwJQ5UJvD50/ysEQIxUsdYQRqrBitNcXv0dbb7NKmZnkAHTjsbxzdCX1AUdu
 ylgeC81ZRHuDK0HbZcFCPl4qIE9hpF8PVhOu2KI0qeSjrXgSnmh9a5YehgcLpvP4CZ
 /1rF0hYQ5b/e/ZhHFAzoss4RgKZM5vbyPh8+NBBVBrqUCrO7pJv6BVP/XeUlFihoUb
 j/GFuNHHOFbZg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Thu,  1 Sep 2022 12:32:05 -0700
Message-Id: <20220901193208.138056-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Headers-End: 1oTpwP-0007ZX-T5
Subject: [f2fs-dev] [PATCH v4 0/3] fscrypt: rework keyring and stop using
 request_queue
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
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Patch 1 of this series reworks the fscrypt filesystem-level keyring to
not use the keyrings subsystem as part of its internal implementation
(except for ->mk_users, which remains unchanged for now).  This fixes
several issues, described in the patch itself.  This is also a
prerequisite for eliminating the direct use of struct request_queue from
filesystem code, as discussed at
https://lore.kernel.org/linux-fscrypt/20220721125929.1866403-1-hch@lst.de/T/#u

Patches 2-3 eliminate the direct uses of struct request_queue from
fs/crypto/ that don't require block layer changes.  (The remaining uses
will be eliminated later by changing some of the blk-crypto functions.)

Changed in v4:
    - Restored a NULL check in fscrypt_destroy_inline_crypt_key() that
      I had accidentally dropped.
    - Tweaked patches 2 and 3 slightly so that patch 2 no longer makes
      as many changes that patch 3 then undoes.

Changed in v3:
    - Added patch "fscrypt: work on block_devices instead of request_queues"

Changed in v2:
    - Don't compare uninitialized bytes of struct fscrypt_key_specifier
    - Don't use refcount_dec_and_lock() unnecessarily
    - Other minor cleanups

Christoph Hellwig (1):
  fscrypt: work on block_devices instead of request_queues

Eric Biggers (2):
  fscrypt: stop using keyrings subsystem for fscrypt_master_key
  fscrypt: stop holding extra request_queue references

 fs/crypto/fscrypt_private.h |  74 ++++--
 fs/crypto/hooks.c           |  10 +-
 fs/crypto/inline_crypt.c    | 147 ++++++-----
 fs/crypto/keyring.c         | 495 +++++++++++++++++++-----------------
 fs/crypto/keysetup.c        |  89 +++----
 fs/crypto/keysetup_v1.c     |   4 +-
 fs/crypto/policy.c          |   8 +-
 fs/f2fs/super.c             |  24 +-
 fs/super.c                  |   2 +-
 include/linux/fs.h          |   2 +-
 include/linux/fscrypt.h     |  25 +-
 11 files changed, 462 insertions(+), 418 deletions(-)


base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
-- 
2.37.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
