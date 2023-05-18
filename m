Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52060C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 May 2023 01:50:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzSn6-0007J4-J7;
	Thu, 18 May 2023 01:50:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pzSn5-0007Iu-14
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 01:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tYvBe56RiRok/NsXQTsyeK5Vx+wkToLEn80xiRdETjE=; b=exmOTUMxnX2+6pMdl84aThZkie
 Nk5er4k8o5Xhmnr+dvM9Iovfim5eIqYl5UfDw47WoYOksv8LHQNbfxR2/WQZKChrS5rxSx+FYaCT9
 ADqSXshR//qK8UFUurz11LOycCpZ9Zpehzivps0QNl82rZApFDAwz2hH6sJeJu0e+H10=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tYvBe56RiRok/NsXQTsyeK5Vx+wkToLEn80xiRdETjE=; b=c9Fc0np4suuk/QIOM/NOC0DlkV
 vPewFKzt477vOCgqS5znQSEbgD60ZPQBNn5jQZm/LBzAKV04zSxDBBR3nPrvZv/p00jYx86/rTY62
 c6zzf64k0Ve+XDM5dkU1xYBaf9XB40Jmtxm5lf1DleRMiBeUarlcoTQ/pEVRukZqIaHA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzSmq-0007VD-V8 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 01:50:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B90C464C50
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6DC8C433AA;
 Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684374621;
 bh=h5wZXuGuivPiw1wCi19eTgzWGkbGvrsyWB3cTP8ACus=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ONhYuEGnjXYVm5PHis3SOTu0gvw5dQJMAlcPsVZRRm3p3alc9JKeYMzyUXXZFVyaq
 qtewm1Oio41/WBN/q/hlUmlRVe3GUxPZ7eWgzRNuqoF062EBUsKXFOZGaHrVSnzZGe
 C8QUiDZK47RfCyfcYbmxOwQ8iSn+RVXGhfJu5HT0p1x0OqQlsgaaKDm0LJmEQBBjMu
 oeFGSKUW8TKfcAUPbqPCmBpkREYFr6OVWkEt1/gTILsZ+1aq+mXm7wsJckKDFxlQTB
 YPE2+OK/RDsF3U4Pw8cDQTLyKErgk58DX9wigUSAnStePgQ8CNIfgqdhAeXF/tyL4L
 wbWIB4LuTG6IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 897F6E21EF8; Thu, 18 May 2023 01:50:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168437462155.19511.5323396327491038939.git-patchwork-notify@kernel.org>
Date: Thu, 18 May 2023 01:50:21 +0000
References: <20230505191841.3185179-1-jaegeuk@kernel.org>
In-Reply-To: <20230505191841.3185179-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1pzSmq-0007VD-V8
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix the wrong condition to determine
 atomic context
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  5 May 2023 12:18:41 -0700 you wrote:
> Should use !in_task for irq context.
> 
> Fixes: 1aa161e43106 ("f2fs: fix scheduling while atomic in decompression path")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/compress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix the wrong condition to determine atomic context
    https://git.kernel.org/jaegeuk/f2fs/c/f063fa439956

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
