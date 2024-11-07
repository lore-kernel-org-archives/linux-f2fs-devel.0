Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D193BD5D688
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:30:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t999U-0003ho-30;
	Thu, 07 Nov 2024 20:30:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1t999T-0003hi-4u
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7YQRZtyxrqP8Yc90etZJhnu5nQWOl0h7UIkEz7NB8Eo=; b=ZwdpHjJ0ZwSvz1J6sBq10/IWn0
 5nlZ7VG9jjf27zJkin/D/LSoxWHDE6oQQwxixnmeZE7QXp0OKmOF3EB6iNIcWRkE+lgLwOdtOBJrs
 2DHn5+kPZFudzRz32kV1Zcet9c9LIis0GjcaBzOSTs2KibCVF4hMByBltvN+Scby3Kjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7YQRZtyxrqP8Yc90etZJhnu5nQWOl0h7UIkEz7NB8Eo=; b=Ko9dyaMCeSX9uiK/7554islkW1
 62qAorZbcb60jBqlTwLclAihq8RP72BAlgIFAcTq9qCVVm6A2vxCIw1bC0cScn6gHioJ+1n8RqA+i
 obSyl+dqSELA3Fa46Isz7yCkuh9Wq6Vw3t1b5eVR75JtMagS/RMCFrVmF2iLohbVdtYo=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t999R-0003uN-S7 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 65EC3A44AE9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  7 Nov 2024 20:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08466C4CECC;
 Thu,  7 Nov 2024 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731011440;
 bh=heoiBxP1nTthFD5q0UEdFf6g1XaL9Ti1foNVJFXQd30=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=FPh55dgxYDTP3x6Wn584mBnHL7G3psJEcftGuNLECYo6DTC5DyewpEVvUvYEzd7HY
 1CbKtgg/fdcUQP0GiGFjKwgaLcc3yZFUZ5gHBpr2XMf4ssAWN9GVp2aXc7vlKJG1Dr
 zz3yZ6/nmNeZjV0T+aLU9QYnaW8h7VB2IdZ8dULTpvaoC5d4zGI9QBNA/zRQB5YL9a
 JRr9HvN4L1lFArBls5g3skjnhIPbCaqbBoBg+pZeG126z8fcwNL9CKZAWXxMjT8rDK
 bqIRCX6TAEePkXRsHOJch6Syn1rS2mZ462Zdm3EcHYgaupLADS1NhxNTwXCe686WNH
 6Wqvg75ZVixvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 71A543809A80; Thu,  7 Nov 2024 20:30:50 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173101144899.2084993.8424317066290373281.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:48 +0000
References: <20241030081701.1853020-1-chao@kernel.org>
In-Reply-To: <20241030081701.1853020-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1t999R-0003uN-S7
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to convert log type to segment
 data type correctly
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 30 Oct 2024 16:17:01 +0800 you wrote:
> This patch introduces a new helper log_type_to_seg_type() to convert
> log type to segment data type, and uses it to clean up opened codes
> in build_curseg(), and also it fixes to convert log type before use
> in do_write_page().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to convert log type to segment data type correctly
    https://git.kernel.org/jaegeuk/f2fs/c/51d3d952c508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
