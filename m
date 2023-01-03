Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F18C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jan 2023 17:03:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pCkhR-0004yq-OT;
	Tue, 03 Jan 2023 17:03:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pCkhP-0004yj-R3
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 17:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=30A9UU58eLsJsI4fwFvg1Qv3IgMM+/V0q3hZS0jm2iE=; b=djvZ38HWU7trOqdatbTY0boh9n
 5VOOUOtPqgY8upiHSIBgoCnH5CrgoY82ippzqrkAlausqYbpDSFrAdgWFtoUCtmM64YrVgClmO9dt
 Xbg1GmunBiNFX2E2sz1rjnKDW/ktYGoDONrQkeA9Y10GmzstoLTisLfaDy0MrFpCz1dM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=30A9UU58eLsJsI4fwFvg1Qv3IgMM+/V0q3hZS0jm2iE=; b=Z+jYWbxr4kU6BmTgsykIVuqAAm
 HVL+/uzbHElhF0xuHIYghMJqMseyeRC/efz0ipZGJHtGOEpUoi/OJLh7Zd6SCOVuRemqp54f5+FPk
 FSwvx5+3DpOWiGn2kjARidOcWFHPnStbCRgNG6VAVLMy4OcSRGMJvULaozJa5j1eFjtc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pCkhG-0005We-HB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 17:03:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6FF5EB81023
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Jan 2023 17:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30ADBC433EF;
 Tue,  3 Jan 2023 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672765402;
 bh=es9YEwfTJUiG5onbnN2r3/MT0gKlvyPEE1s/ihzxQ40=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=UNZHWsYsbqP+6kFXbs0mEDWbKzasYQXOzWNSySfJo2aBpZBLMQd3ExEN2Helh9NCb
 24aus7w9kvod/v/bgH1nZQ9CsY9aGHPN+0ns2PwqrI/rg7PxO1nUA79YXN/PVMi1+G
 VEQ7lrz1Hf3XfTIvbN9cPTcepT0WUCI1mmE/9/YB8D2q3N0E0ChN1izfm3M7jzM6nV
 uhUlE/MGvnulY+Fgy3g9tMPZdpECESOD9FumiCd4XDDd92SYzConkj3XoJsBhUpKxr
 12VAzMFjcMnTg/rG5cfJzmhuLeFmrmjbB9l3+d34QI33KIFjfI1ivb1+j3FoDHWOd+
 kuYTRz+TpFLtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0E6ACE5724E; Tue,  3 Jan 2023 17:03:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167276540205.24190.7786330518792341546.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jan 2023 17:03:22 +0000
References: <20221230154332.5082-1-chao@kernel.org>
In-Reply-To: <20221230154332.5082-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pCkhG-0005We-HB
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid NULL pointer dereference
 in f2fs_issue_flush()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 30 Dec 2022 23:43:32 +0800 you wrote:
> With below two cases, it will cause NULL pointer dereference when
> accessing SM_I(sbi)->fcc_info in f2fs_issue_flush().
> 
> a) If kthread_run() fails in f2fs_create_flush_cmd_control(), it will
> release SM_I(sbi)->fcc_info,
> 
> - mount -o noflush_merge /dev/vda /mnt/f2fs
> - mount -o remount,flush_merge /dev/vda /mnt/f2fs  -- kthread_run() fails
> - dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=1 conv=fsync
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid NULL pointer dereference in f2fs_issue_flush()
    https://git.kernel.org/jaegeux/f2fs/c/b3d83066cbeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
