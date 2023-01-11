Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AE2C67871
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 19:20:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFgeF-00075n-4a;
	Wed, 11 Jan 2023 19:20:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pFgeC-00075O-2R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eXyZnIxPTkBUvlViPxZ2pNQeVlqh5h3+LFZQJpyAm7s=; b=hkJNAtF13zkICqTxRTMH9BIMER
 MW7Q8T164fPJPT19hdPuQAtmEsHwUgPh+fijJBTPrCVE5JNrVf48wjFT+rLzmNS5/dXn+dWTgF8uH
 y2rV1BAWo0IH/JzKlOiOrPo1Aa1Akbq5FDHTG4J3Z+PCy7WNtiC7fXlq+KLPHBy9SNbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eXyZnIxPTkBUvlViPxZ2pNQeVlqh5h3+LFZQJpyAm7s=; b=c
 pzJgPQ2r3WBHuNc4aNJrDaExJKIQCu8rTnTbtBXoOScwvaqIDtD/NsSy895aremWKF4ZUGgqUU1RN
 KjLhJN6kDcWjaP0MPPYCyhDwx+fldEl8JmVk3/TTe2t646uAKamlP8/Zus6kXZleZfl2caiM0+4b7
 EigoOaUl36w35mjs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFgeA-00011G-M4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2144C61E03
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E109DC433A7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673464817;
 bh=/airuWVjZ1NHpaF5hjuI+4oYRcgJ+Gk2Co2U+20qTas=;
 h=Subject:From:Date:To:From;
 b=J9AZZrpHoRP1XsXWN4rdSKNYtEV929TMHgPyu/z3f6UeEQo/mPk+OHbg4MyUiqmVg
 MVx2uPzGgekuOPF8cWvwBBnxxZX7NsaooT2Q96yVnaoDXe3aci/gsA4ozIeKB3S/i+
 WDPUXVQ11r2klO9jL43OpuTItLtbhk6e6R3UaVxufb1GjRlv63R1VC5n3at/JEyQPQ
 DcctI3sZLQoCOC7MopDGDFhy/ZbCONCl/FGd1qY5Xryk6zzT8Fax4/W7BSDRoJvhoq
 LTzd4qpcDLW1y0dbS26BDXITgOKtLT6dGjNRnZKm+1rATRqbSSgOUudasm18VoaphI
 AwU0d/nE1MPeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 BB41EE45233 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167346481767.5008.13553735157284478842.git-patchwork-summary@kernel.org>
Date: Wed, 11 Jan 2023 19:20:17 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pFgeA-00011G-M4
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: add a f2fs_ prefix to punch_hole() and expand_inode_data()
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=706033
  Lore link: https://lore.kernel.org/r/20221220191212.58042-1-frank.li@vivo.com

Patch: [f2fs-dev,v3] f2fs: merge f2fs_show_injection_info() into time_to_inject()
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=706009
  Lore link: https://lore.kernel.org/r/20221220183904.53908-1-frank.li@vivo.com

Patch: [f2fs-dev] f2fs: mark f2fs_init_compress_mempool w/ __init
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=707528
  Lore link: https://lore.kernel.org/r/20221229131828.59116-1-frank.li@vivo.com

Patch: [f2fs-dev] f2fs: convert to use MIN_DISCARD_GRANULARITY macro
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=705317
  Lore link: https://lore.kernel.org/r/20221217052448.60656-1-frank.li@vivo.com

Patch: [f2fs-dev] f2fs: remove unnecessary blank lines
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=706325
  Lore link: https://lore.kernel.org/r/20221221192634.18068-1-frank.li@vivo.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
