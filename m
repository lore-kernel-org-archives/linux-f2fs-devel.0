Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036EEC88CB5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Jun 2023 20:50:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q8oUf-00031H-MK;
	Mon, 12 Jun 2023 20:50:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q8oUe-00031B-Qq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 20:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3jx8GmBufojtkRqFuD7YDxhuK0Mx97Af6IkaVZ1tpms=; b=FKartlPcc4pfT6K8Vk7k2FZMi3
 UMkHwPGaHns17Nhr+sZ/Vv697a4iIkcbHZmv3tWWFRgfmMBtnSGgEwdaPB9lhNnSiHi3emYm1nD+0
 UxRcLCp6XnIbyH/ZkSgcNITZfBgg5pFwF43nCcFw9GyJDtYXHPBn19cOGI8R/inzbTxo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3jx8GmBufojtkRqFuD7YDxhuK0Mx97Af6IkaVZ1tpms=; b=K
 EMJWWr4lopc+D1Rr2lOnlst4pnp+yN25Auc8Cxj4TEsMPsI3fNmlRU6oT+sgP5B8csBXemmjtS0KZ
 OM15Q7NuDFVUk0kNj1YApgKre2XdNy57fPKC6+o1CneNzKM75nM5sJQa6JKz4l90KGytsgsEbTQhw
 hunNq5uQoS0BuPNc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q8oUe-0007Uf-68 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 20:50:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C4E736130B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F284C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686603022;
 bh=SEx7dV9nAjW0dkHfEsrGOYs539oeXuu1EqPP20ae+84=;
 h=Subject:From:Date:To:From;
 b=LxiD6HTz9LFS7zRZuDceBtMNLZZTZ3Ga1RXD9T8GZ/kTdqluCe3Jh5aUT4B9N9UHO
 TBjUVy+Rq7VyboyGouXU5pxNtkLRkaO/ir37YMiT5BbjMzKzzgm9uSTcFciuJUsKsy
 mpt155tI7NHzQgyomPj63mGGxXbZUATF36K3JLSDyS5LdMhc971m4x7KB5vAvzmPNW
 DEGqOB0/b2F+gh5hmwWNAfK4ChCoTSpsin8r39pw3Q7CdDCg+XNWiI8CMcJYIfnePi
 koavQWUJSlyn7mwOIx7jmuFCmANW7TqMAuDndFYVuYJbk49b/pUR0sdbPxv+RcztIE
 WvkAy6KkF07GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 12F94E1CF31 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168660302199.10168.971770710606969396.git-patchwork-summary@kernel.org>
Date: Mon, 12 Jun 2023 20:50:21 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1q8oUe-0007Uf-68
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

Patch: [f2fs-dev,v2] f2fs: fix to avoid mmap vs set_compress_option case
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=751813
  Lore link: https://lore.kernel.org/r/20230529104709.2560779-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: check return value of freeze_super()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=754275
  Lore link: https://lore.kernel.org/r/20230606061901.1179970-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: introduce F2FS_QUOTA_DEFAULT_FL for cleanup
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=754274
  Lore link: https://lore.kernel.org/r/20230606061822.1179551-1-chao@kernel.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
