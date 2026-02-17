Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7230DE9A03E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JuLyBEEfye7qql2GUM8khkTT9mpsGxo3pAvNGyJJcik=; b=ELMAObfwH2FsO7KnDyOBdPPXh9
	pJMFVFYJmzbujsalLsOkFcjJJreBx/hNd1LLpo/cP7K/Irdt5L781TxRkg9F0eICRhK26Z0jiF4+9
	ll4BGcTlO/OSaZqCmxHiBD4PGqa8tC4Yw+nzvaEK/BvFgskd+sFhP/oZW5sr9Nl1Qrsk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSPD-0004Jw-N4;
	Tue, 17 Feb 2026 21:14:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vsSPC-0004Jk-Ao
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GbIGkssoD3il4QYKZ0tKDLuQhviTKtmlJjAOOAfQXcU=; b=T0TpHW9Bjr3ojtyV/sBAu6oZTw
 13MR5GAfoPHEQEZgRxOd+1crCNPQwmqBtI97DW0MrQHM54WR0uG5C0dwdtYfsyCjR5eFvtmsIMou7
 eXoToZzHys55fS6xPpZbmoXHkRL/ToLXsot6/hstT1Vv7lp/5aHsAqvX76Im/x4Il044=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GbIGkssoD3il4QYKZ0tKDLuQhviTKtmlJjAOOAfQXcU=; b=N2OxcIvbwPoxmkTvTb6y06O86g
 gIK3gWJH8XCPSHVxjFT9dBIS8yy/NgaqxWZ9Djega0ymG8C3PNzYMl0R5cuF2mx+3seMHscSCSecg
 YngITcRk7oUUceRkQ/JFXfEzzea5szOwBhXOfPJ7wpMMHq2fRN10ARAmQiZx2yEl7TaE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSPB-0001TR-QB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D12A43957;
 Tue, 17 Feb 2026 21:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462D8C19425;
 Tue, 17 Feb 2026 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771362879;
 bh=6hJdaM0GcFWek9dW3PnUx3HenDAaAnbR4Dj/tBebWTw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=WsFF9vwt03+HzTrBKIZYHHMwK4vsplppy1D31u9WgBMUXk8vuJn6J4OT463b7vifv
 /q4RmpKbTCO39kDYSi/wvWYXLjK4j+3Zlp5MGNklMb66vt39o+IzUML05u4JnwxoOM
 3KgCHpN8wKZUIjkNykl25LJoMImsrjHj53tsvT8F+DVGuy5lvkhe5rWwlH0BhF6Dxn
 EJ4uIa3GV1fqTFUjAsvX5UYszlhLzupZtNLtuN0vQ2JA8mIOlddCWI5pKgV45bzO0S
 2eXZk/qsRCWRfYoqqtDIRZRxd8Olo1C+Irf4EyvpDpe93NUaFMqYbQcfZkTKXaQES2
 spjfMrYBrbgdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 4804B3806667; Tue, 17 Feb 2026 21:14:32 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177136287109.643511.9798324970398190582.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:31 +0000
References: <20251118062159.2358085-2-hch@lst.de>
In-Reply-To: <20251118062159.2358085-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1vsSPB-0001TR-QB
Subject: Re: [f2fs-dev] [PATCH 01/11] fscrypt: pass a real sector_t to
 fscrypt_zeroout_range_inline_crypt
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
Cc: brauner@kernel.org, tytso@mit.edu, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Tue, 18 Nov 2025 07:21:44 +0100 you wrote:
> While the pblk argument to fscrypt_zeroout_range_inline_crypt is
> declared as a sector_t it actually is interpreted as a logical block
> size unit, which is highly unusual.  Switch to passing the 512 byte
> units that sector_t is defined for.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/11] fscrypt: pass a real sector_t to fscrypt_zeroout_range_inline_crypt
    https://git.kernel.org/jaegeuk/f2fs/c/c22756a9978e
  - [f2fs-dev,02/11] fscrypt: keep multiple bios in flight in fscrypt_zeroout_range_inline_crypt
    https://git.kernel.org/jaegeuk/f2fs/c/bc26e2efa2c5
  - [f2fs-dev,03/11] fscrypt: pass a byte offset to fscrypt_generate_dun
    (no matching commit)
  - [f2fs-dev,04/11] fscrypt: pass a byte offset to fscrypt_mergeable_bio
    (no matching commit)
  - [f2fs-dev,05/11] fscrypt: pass a byte offset to fscrypt_set_bio_crypt_ctx
    (no matching commit)
  - [f2fs-dev,06/11] fscrypt: pass a byte offset to fscrypt_zeroout_range_inline_crypt
    (no matching commit)
  - [f2fs-dev,07/11] fscrypt: pass a byte length to fscrypt_zeroout_range_inline_crypt
    (no matching commit)
  - [f2fs-dev,08/11] fscrypt: return a byte offset from bh_get_inode_and_lblk_num
    (no matching commit)
  - [f2fs-dev,09/11] fscrypt: pass a byte offset to fscrypt_zeroout_range
    (no matching commit)
  - [f2fs-dev,10/11] fscrypt: pass a byte length to fscrypt_zeroout_range
    (no matching commit)
  - [f2fs-dev,11/11] fscrypt: pass a real sector_t to fscrypt_zeroout_range
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
