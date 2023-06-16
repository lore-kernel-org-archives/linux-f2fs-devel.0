Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1D0EB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Jun 2023 23:50:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qAJD4-0004R3-J8;
	Fri, 16 Jun 2023 23:50:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qAJD0-0004Qx-8Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jun 2023 23:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yaqDSD0JVCfmjfHU9iLxxG2OJrlqRP6Cub6hdBoSDdc=; b=eq10e/EX3L9b5Dbi6bCOkIpEsL
 f3KBjjq5dMEBIAhrz/kTHuLzCYXOCO3S7i4DZkGSHZocpulXrPfq/sJ77nzq5gTe9WX5T7NY5lgKC
 1wRGf0ioDeko9UqSR6sLDwJAKOqvQvwZ/PZsdssz0KgiWKscdiriKmMrfEXSALYvNHno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yaqDSD0JVCfmjfHU9iLxxG2OJrlqRP6Cub6hdBoSDdc=; b=XQXCZOLPlXP6oD2RqXTyPkr0fj
 qiqeBpVK9kIIyez+JUhXasnKfgsBmN7V/4Thn+M9S7nNYSjZDABB0+Wx/86Q4nS8OfUDl1oyG8DRX
 +PfK64atw8aRBf1jDM00NGzJV+bxmZOucPsTxY/MnEhYSEimLeKWxSDA8/qgvzY+KLEA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qAJD0-006Gis-Gi for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jun 2023 23:50:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2245960D57;
 Fri, 16 Jun 2023 23:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 791A3C433C0;
 Fri, 16 Jun 2023 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686959420;
 bh=tpI1nNLOMsidJC5LfSO36HzZCJ3rAkUYRMbae3G5Lwo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=c3VbRa0W6onMFD9QuFdy2MAp7G79AjuUTBFfWAdP3AGiXtXpc4R/zDv62uaJi0T6s
 tDnrUx3i00OXJJJ1hNNVXp5yUHHy4Krk7aFOKowa3djChv+jfl6pN+z8lvwc7+RXBg
 F57HhtGQQwtvj5kP5f9hfaCsIfSGtY4J5o5+L+8A6bVJGSfk3cXzxJ96z8gZPJUob+
 Kgv0Ga0wy4Dl2lw6NurWhxefAY9qdRzyGtKahhKCLx3PL8ylwkQT+UPzFcX4hn7SYz
 pItD18Ca7Hc486kQb9SNRcmw+z9OhjmRNhaJ6hIEFxSEXZjAT2GGHfu2QZppy5+QRr
 /wZnFcbvVgn0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 5E4DDE21EE4; Fri, 16 Jun 2023 23:50:20 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168695942038.30361.15438439169807836528.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jun 2023 23:50:20 +0000
References: <20230616142009.2332411-1-colin.i.king@gmail.com>
In-Reply-To: <20230616142009.2332411-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
X-Headers-End: 1qAJD0-006Gis-Gi
Subject: Re: [f2fs-dev] [PATCH][next] f2fs: remove redundant assignment to
 variable err
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
Cc: jaegeuk@kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 16 Jun 2023 15:20:09 +0100 you wrote:
> The assignment to variable err is redundant since the code jumps to
> label next and err is then re-assigned a new value on the call to
> sanity_check_node_chain. Remove the assignment.
> 
> Cleans up clang scan build warning:
> fs/f2fs/recovery.c:464:6: warning: Value stored to 'err' is never read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,next] f2fs: remove redundant assignment to variable err
    https://git.kernel.org/jaegeuk/f2fs/c/71a1277a46da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
