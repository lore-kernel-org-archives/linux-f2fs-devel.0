Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3125CC6B1F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUbfupsK+o+1u1fu+4ZQNKhRu5+q8c710s6Pe3k9G6U=; b=SFl6mrjmQEcZeptiqZtE6u+oS5
	q34xYR2SBHkXbYJyuvDCkp2mZFrfFgfTDh3AMbcL5LwufLLX4H4LIocDj2W0KHQ9YbBhC9l9jiCjD
	rGmpLrRvmXJtgZZR9HENmuidw5HGHnX6IIaYwmyIW0F78Sr/gxHlc1fc1PgHqrS/iTPk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl10-0007Wh-R7;
	Tue, 13 Oct 2026 22:30:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0m-0007UR-TI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GiBJ/oLan3EyG2DRV6lI24u5uShBkAvfvTrWseow4t0=; b=YWJJrb7We+xKitPSCRqwK87QR9
 pGNvFF7K3jhMZU4jYJz3Y5s5RheDY518P8vQaYIN3oYlwMMwr+PZS5L5a17P/EPX+FVX9AFrGvwCN
 T61tN7r8dMAYUdBzlCsYhtqVvtS/n4wHuvmH1uQFA9Owy1tR4acM9XmIRNaQ0kZZ1s6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GiBJ/oLan3EyG2DRV6lI24u5uShBkAvfvTrWseow4t0=; b=ji5yCSZ1Nkcm4nRJ6VfJQYKM3p
 9s+Z/nRU7FyudZGYoJIdswLrAPr74GS95vKdnf6m1se1eTd4k1YbRBQCtkplqEjOkxFdqXxkra4YH
 RD5bGCqhP6HYpIA+TNeW3Efp3XSTfhVNuaH4L0/lV8ScXFr/ZJ0bNe4+pHfRm2ffR2ec=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0k-00064D-3s for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D8A56021D;
 Tue, 13 Oct 2026 22:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BD91F00893;
 Tue, 13 Oct 2026 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930612;
 bh=GiBJ/oLan3EyG2DRV6lI24u5uShBkAvfvTrWseow4t0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=WHa0rhzXK35hKXLoG68fCSgJBrMz0B2vQP+g+KwmngLpdK5cSTGCiorSTryd+7Od+
 wTO1xmk7DpC7CS0jJACv2504ggyEMS5yTmWF84RcjYuTA9EUBl9aVbRWb/wIXGqFyK
 c7BFtEMr69xwyJs3zu0VIUFkI40hdz7R8jYj/ZB8mJ17OLugGITNIH8dXj/y/LcXvf
 aGlx5B4B6bUPzVktJHz0j+berMyv130AqMhD0DRFJaYiFqjjcRXAstbNolwQrfY3Fw
 2FhE2V0aB8avcPQPGk9amOx+oqkuVozFHLF0aG4J52IltYTCwYPkFgFfnvDQnqPHm6
 rY0eEKmh00F5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A36E39E4DBA; Tue, 13 Oct 2026 22:30:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193061076.1493834.3133612745818318306.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:10 +0000
References: <20261009095335.749891-1-joannechien@google.com>
In-Reply-To: <20261009095335.749891-1-joannechien@google.com>
To: Joanne Chang <joannechien@google.com>
X-Headers-End: 1xGl0k-00064D-3s
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: allow pinning empty compressed files
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  9 Oct 2026 09:53:31 +0000 you wrote:
> Commit a64a3fec11e7 ("f2fs: force out-place update for all writes on
> compressed file") updated f2fs_should_update_outplace() to always
> return true for compressed files. However, this function is also
> called during f2fs_ioc_set_pin_file() validation, so pinning an
> empty file with compression enabled now fails with -EINVAL before the
> compression flag can be stripped.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: allow pinning empty compressed files
    https://git.kernel.org/jaegeuk/f2fs/c/2eebc31ae5f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
