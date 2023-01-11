Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E72C67871
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 19:20:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFgeA-000752-IY;
	Wed, 11 Jan 2023 19:20:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pFge9-00074s-Ku
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PPVRNgvFczrxDjnUXZcT+Glyqxv2q5QM2HykD4EjN3Y=; b=fG/aInX4xX6JJXBQNhmFYg+B0D
 7rqIYX0JaBBQPklOrNbBPJWRGrQxRVmM7jPWYm6y8S0gYMI8g6neuKx0KdnWQVg4wqODBez+Bc6Ol
 3449wSuQxMiVYdKLo8WB4UQraH2jkoMh5MDx2kQVyt06+S4Zd7lTBxjeMycrAZVapLp4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PPVRNgvFczrxDjnUXZcT+Glyqxv2q5QM2HykD4EjN3Y=; b=ROh8s9KA5+N0ftcTdK+2uoyjBc
 vyYzIpxh2v0AtoeOSDdcyTpEvcdMZy/CyMLtNwaWPRIkBRSRmk35Twrd1ZcLoE2kYL/Rx7dcl1QW3
 MqherjkaIEhwAuPq461zrWfqNU1sshbpc2XgwWCjVdAmBvagkMBri1Z0VOBPY5TzXrPE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFge7-0001VE-KT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3554C61DBC;
 Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01B28C433F2;
 Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673464818;
 bh=52urJWoz0blI4bnQ+w3PNpauD8QBF38h3Q2tnnT+iTQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=rUnhfTub9goIwjO4RLaQaPVLBC+/Is8NWoPXtun5PVwSVVuRuzoCDPV1e9+HpOe6g
 TJckIi/o3djadXioCVaW+AWK7Q5GFGdp6cckC5e9BKoXnpAYHImJlddRWTGWqSGy0p
 ZM/bWx1gmViM2sWGxbQOLrWaMeBibJSk9wgjKAeJTC9Pjld98eV2Kg1pcEPR2Jz7H1
 oTnUxfhgob0+jESUgsgIme+aWBmWIX7/OubkZ+48mjD0lvJg5uVGukVIUKH4Lzm6cV
 Sdd6HvtjUYwQC+1ptX9T1vCPkgfAQndRX2si0jQbGjG6hdzl2FIxfuzKQrO2bouq70
 Z9nBjRz9w9sOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CDFF4E270F6; Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167346481783.5008.9895955069686531878.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jan 2023 19:20:17 +0000
References: <20221220183904.53908-1-frank.li@vivo.com>
In-Reply-To: <20221220183904.53908-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pFge7-0001VE-KT
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: merge f2fs_show_injection_info()
 into time_to_inject()
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

On Wed, 21 Dec 2022 02:39:04 +0800 you wrote:
> There is no need to additionally use f2fs_show_injection_info()
> to output information. Concatenate time_to_inject() and
> __time_to_inject() via a macro. In the new __time_to_inject()
> function, pass in the caller function name and parent function.
> 
> In this way, we no longer need the f2fs_show_injection_info() function,
> and let's remove it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: merge f2fs_show_injection_info() into time_to_inject()
    https://git.kernel.org/jaegeuk/f2fs/c/c40e15a9a59f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
