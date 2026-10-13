Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE600CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A3Bn8nVlOLAqH8weWx+gZj40K7fkdEgk9+02A/aL2LI=; b=EMInusTqHoPZWcunTZPiFqiM0D
	yF8/wA3d06aa0b2WjViyHp4S7mWz5ov/ILhGtAvS9kY+BHIh4pkDJwrGmqiEjGiuBgyKwyALFBXrd
	TYok9BgeYdfGDRJgOROT774BYxYtqEK67rkdmIt/Pcd5E+8jeR+nxJhLuQzVpYmQwx54=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl0z-0002BT-Vb;
	Tue, 13 Oct 2026 22:30:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0i-0002Aq-Nk
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5WeS8w4Ji4g1xJ9NDbo6XBD3M/iITXPbtnMJ+1aCzZ8=; b=UlPq+RDGsjFceujEDb0Xzg5M1c
 S5+Qxi3Q0BT0s7UwSC2yVmAUumutgRCnxjFQRbJu2AAsIkv09Qj00wgaf5cKrjWL6t/Fc5A9L1f5u
 vegWEnLTyK923iEZs2wCJCoJ40MR7S910jta5Rj2RLtIRv1nxLaTzoYhUb6v7UesGV38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5WeS8w4Ji4g1xJ9NDbo6XBD3M/iITXPbtnMJ+1aCzZ8=; b=H4fTkfukOu/xRKkqNRC9HsgiMN
 tCLNo5JRid4GnNepz3TaDbxHvFH+UcGNz01HOFHDUjycCSUNGX2lx5HcSIh7ET5uVcw5g2FOCX3FS
 QtBFy7MMoh/XqR6tJLAR2buYBEdokivryNAAZlEYc2rPHgMqHQ5bm2SepwFmtPSxre08=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0i-00064B-Oy for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16522601DB;
 Tue, 13 Oct 2026 22:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F01F000FF;
 Tue, 13 Oct 2026 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930610;
 bh=5WeS8w4Ji4g1xJ9NDbo6XBD3M/iITXPbtnMJ+1aCzZ8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Bv1QrvWA3Exuyznt1c1aUmzEyqKvRv8jMoJFf4I5aD9CDwnRc0Idbyf/IIdukGFqL
 ZJ9dyqVNTU1725x2ubumMobtc7e9Gw/AjXIE5BwDOEmrzjgpJRWpMqn35JdvDENCdr
 lm0LYrSW3nTlcK8rGq8szPW4K7Klc6+x98BnmrVuMhn7KbJCT3eNWPaOi0RDsW2aWQ
 XjmYc6JllobitMPp7LhheluMCeqZvsUDwrSHlCYCDDo7zmSbFkpg357OikRUjvXerO
 hxFnVeYxW90UfeU/kDxJmctwtSX6NNi3DK06xfErkrDCTbOIovmO/C+VVT3CDHU9os
 vjLITES0iH9ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B44A239E4DBA; Tue, 13 Oct 2026 22:30:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193060952.1493834.8525794701490344819.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:09 +0000
References: <20261010074912.114840-1-jsjlee1020@gmail.com>
In-Reply-To: <20261010074912.114840-1-jsjlee1020@gmail.com>
To: Seongjae Jeong <jsjlee1020@gmail.com>
X-Headers-End: 1xGl0i-00064B-Oy
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix termination of
 f2fs_sync_meta_caches()
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

On Sat, 10 Oct 2026 07:49:12 +0000 you wrote:
> When __f2fs_write_meta_cache() returns false in f2fs_sync_meta_caches(),
> the function only exits the inner loop instead of the entire
> while loop. This leads to an unnecessary lookup of the next batch.
> 
> Also, when nwritten >= nr_to_write, only the inner loop terminates.
> This allows the function to continue processing subsequent batches
> after the writeback budget has been reached.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix termination of f2fs_sync_meta_caches()
    https://git.kernel.org/jaegeuk/f2fs/c/a45c9a0055f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
