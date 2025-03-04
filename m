Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D7BC021B8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Mar 2025 17:10:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tpVmn-0007Ve-T6;
	Tue, 04 Mar 2025 17:10:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tpVmj-0007VQ-Ub
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Mar 2025 17:10:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=poECJ9JaMGByGubg/kLfg+KqKkxr6xl7mflGWMzZmlw=; b=hNPkFNcdESXBgBWfnbIBDiGcJv
 tl0JhRThpw3zT8oVp/UdZ+6GTy19PBEhvilYECUZTM3CEWl4rLalmDf5WBTjQzbt7CrTZkvWhO4Iz
 1feeHpMvBzswuPorOACzh27lsqYGzQm+ljDvylk2W1nZVXC5gttc7vY9CnYvetgB5KE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=poECJ9JaMGByGubg/kLfg+KqKkxr6xl7mflGWMzZmlw=; b=iTDE/p/O/IT7zMuc13DdjLVucm
 6Xb0mrIXqv0wjZKqxHzyMcQxIhdLxE0OpgfatpNKAxoAThOjaN67c9dVthb/K3IUxw4u+HfW0gnzR
 vKU2V8AlkCtFndLbVMcj0/Fo0KyfIIHyotuwC6lnhwmK0nH0V8oHK07l+jq01YlAzfUY=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tpVmj-0004oS-Bj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Mar 2025 17:10:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D1994A459E3;
 Tue,  4 Mar 2025 17:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E58C4CEE5;
 Tue,  4 Mar 2025 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741108214;
 bh=Jvj0r6ocwpbb8Xn0h34e4Fs/vyBMhR9edCgsHUHR8/o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Hpqrps7080EncjT1pVgnXdf3wCRbxyTCbPh+OKddo9l91mEjuQOVyxPcvAm0tjcwM
 mT4JWvLqXSdxvWzIQ5f4bOaLDAMw6/25GIooNItjg1wFys4VT8+kfm+ND2zHKACL6p
 BV0FLnn20U2tM4NjrIpvibRgDS0EkW2nO1vskO4a8B0y4PrdfvFi3VLMetZmIOlP4w
 xY/B6cR6dccM3vbp9Bg3kVyhg9gGbKVDUOly1bhVgbF3Oe6uD4L646t1LCyj3NRybg
 AvAM5BkX+ihHddfqE9hgeVKbw8Eahn53tibYOV/1AKhfTVyB6VCtlgQDjmcNISjV59
 EmK860bRWbwJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70D13380AA7F; Tue,  4 Mar 2025 17:10:48 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174110824699.224349.2815838938637655716.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:46 +0000
References: <20250303032329.1309786-1-chao@kernel.org>
In-Reply-To: <20250303032329.1309786-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1tpVmj-0004oS-Bj
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix potential deadloop in
 prepare_compress_overwrite()
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
Cc: jaegeuk@kernel.org, jprusakowski@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Mar 2025 11:23:29 +0800 you wrote:
> Jan Prusakowski reported a kernel hang issue as below:
> 
> When running xfstests on linux-next kernel (6.14.0-rc3, 6.12) I
> encountered a problem in generic/475 test where fsstress process
> gets blocked in __f2fs_write_data_pages() and the test hangs.
> The options I used are:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix potential deadloop in prepare_compress_overwrite()
    https://git.kernel.org/jaegeuk/f2fs/c/3147ee567dd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
