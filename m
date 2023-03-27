Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DABC76195
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Mar 2023 16:00:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgpGq-000476-CA;
	Mon, 27 Mar 2023 16:00:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pgpGk-00046w-Ok
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Kr+9867MZaL7RLCzHvuFx9fcAPfrmOHyX8Sx5mVUjo=; b=i8xG7y0cUmSwqPLr7YoCJKBQ5X
 GaQ17isdJHZyxzuOu9haXqgwtjI4dc9f2SgL5zpWgCZz+dqM+otHBjVU9j/mBLmqKj29LlLmYg2mR
 oggFqa1jdPE1aU+Rw9k9pEjUH2EVtI+9S9htbvTBBcTkQxwWWeH+MjOcd658UlsKQGL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+Kr+9867MZaL7RLCzHvuFx9fcAPfrmOHyX8Sx5mVUjo=; b=X
 hVYEZRztSqkwTHcTqbC8wDTgD8YIf4mvMLIlQxa/Kb4H2gCo2OAJog1SBOhbk1eFIklIyheQsNUzB
 6Ytxh70Fzkq4BOPxR//018+6OqancMtH+snjYnJVI+FcHu2o0efEgKrYQrEWsP1JO4ga/MgtgbVuZ
 DOudF6Kt2Qifdd10=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgpGj-00038M-Tc for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 83DAC61300
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C6AC433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679932819;
 bh=L+jDIEzeEPbsuCCT+VftOvBDUhGkqRcjeCsBELhI7u0=;
 h=Subject:From:Date:To:From;
 b=DBFo0GZ9qH8NIqV5qOse9d0RgRpySfrsfRXMkAluACRoJyQmcB6NQcFCxCtF6wMbR
 L8H8i2MD9LmjfbrYdSQ9rPu5uouOWz+bgLd6aIrZ2GF+/Sw6hPirJjWeZ/ztoGr60e
 Y1sk70zfpJI4e9pD4UO3nnFHTzQs5rNUK71SOVonRaZi7ct62MmQl4/K4l2lNaAmY2
 WAjyOPr7/B/dMsVZixoyb0upyvpd2s30Nx6fzINhMmAmXNZNW0u8rQ3oDoDhz6n1sw
 TyCVUp8s2fUsBnYrIQENyEUBBxbgje1wE3mnDvblzKZCGaxN/A0yHhFVjvmoSPqakD
 sjyxwRKH+VLig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C7460C41612 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167993281972.32120.6047445159680423521.git-patchwork-summary@kernel.org>
Date: Mon, 27 Mar 2023 16:00:19 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pgpGj-00038M-Tc
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

Patch: [f2fs-dev] f2fs: fix scheduling while atomic in decompression path
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=733339
  Lore link: https://lore.kernel.org/r/20230323224734.2041173-1-jaegeuk@kernel.org

Patch: [f2fs-dev] f2fs: remove else in f2fs_write_cache_pages()
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=731967
  Lore link: https://lore.kernel.org/r/20230320173137.64413-1-frank.li@vivo.com

Patch: [f2fs-dev] f2fs: apply zone capacity to all zone type
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=732512
  Lore link: https://lore.kernel.org/r/20230321231157.963598-1-jaegeuk@kernel.org

Patch: [f2fs-dev,RESEND] f2fs: convert is_extension_exist() to return bool type
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=731514
  Lore link: https://lore.kernel.org/r/20230319075822.79337-1-frank.li@vivo.com

Patch: [f2fs-dev,v2] f2fs: compress: fix to call f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=731966
  Lore link: https://lore.kernel.org/r/20230320172218.59628-1-frank.li@vivo.com

Patch: [f2fs-dev,v2] f2fs: add compression feature check for all compress mount opt
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=731511
  Lore link: https://lore.kernel.org/r/20230319075130.24962-1-frank.li@vivo.com

Patch: [f2fs-dev,v2] f2fs: Fix system crash due to lack of free space in LFS
  Submitter: Yonggil Song <yonggil.song@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=732125
  Lore link: https://lore.kernel.org/r/20230321001251epcms2p4c1fd48495643dbfca2cf82a433490bb8@epcms2p4


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
