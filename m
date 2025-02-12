Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A842EC021A2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2025 02:40:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ti2fg-0004n2-Qa;
	Wed, 12 Feb 2025 02:40:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1ti2ff-0004mw-D7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 02:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NBOxFvUDdllO6MIj+38zTQP6OPlmRPPe1WnDnnIfAKk=; b=m81zUHn73C22AcZHAHALKHvUuR
 EK/Rq4e58QHrvdmZKdICFreEFe2GinECDhyOK2QocaLSQzgrlTFG0AdKtIrSpdXs6xYvJ9zSWhWll
 4cKmLUpGB+yCMCq3jUmMSUtVQO8s2ACqZao46D8dkTdGEnW4/Uhi+doPcxy0kICmfXpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NBOxFvUDdllO6MIj+38zTQP6OPlmRPPe1WnDnnIfAKk=; b=KQUFP5/f+ZQvn5rJl/dUJ+En4b
 xLIjNfw+FnZdkh12NXojPMOkRuBlwBZMWs+Rr/YzKq9eGmWNAz//66m01Y4sM9F9CEocvordyWWws
 FoLAI+bM8/gpQvxrN+udMzxJh8tD0WZUHepA6bYVI5V4n5DrXTqunhiiEBUDziEbr6Wo=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ti2fe-0000ms-0Y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 02:40:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id CD3F2A40F1F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Feb 2025 02:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFEAC4CEDD;
 Wed, 12 Feb 2025 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739328002;
 bh=qCqjKDkgcJ9MTQY84WTCtp38UhKYa6ZgpJr4unZFVtU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tTK4Ay43kUqtrBJl7vMg8mVzH7+9t+lhzK5y2Z9LIeOLOVNR+xSh0fNVcujXn+EP9
 n2pCBhaOw4TXM2LDpgBb5+Ew63guS85rUlAW+BeZiwScbFrVgT9uOVgk7Bbie3TeSH
 +u9QyXCMdvDadvlXzj/IOLydnveTxUk0EhQHMvfOwXrc76TOQtiExS57hxgcmOLDZp
 Ym6h7+f+k7ssd6AQSyST28/TJtFf9MMcHf3zKkqu6WfoApfuzS+8hRTUWFBW6sszji
 Sh6DjAJ9l3M01DzaEW3J3ZqnxCo9MyX7OoR6/57J7rwopmtFuPPWvfQp4fXQdqtXPN
 CWrMG0ncsJVNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EB854380AAFF; Wed, 12 Feb 2025 02:40:32 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173932803180.78500.9143356682528307382.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 02:40:31 +0000
References: <20250212015413.666375-1-chao@kernel.org>
In-Reply-To: <20250212015413.666375-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1ti2fe-0000ms-0Y
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't retry IO for corrupted data
 scenario
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Feb 2025 09:54:12 +0800 you wrote:
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: don't retry IO for corrupted data scenario
    (no matching commit)
  - [f2fs-dev,2/2] f2fs: add dump_stack() in f2fs_handle_critical_error()
    https://git.kernel.org/jaegeuk/f2fs/c/4f91f074702a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
