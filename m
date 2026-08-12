Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C43C5DF65
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NrW36YfhM2x1IhWULgRHP9yLDpxw0AEkcv+6mNYgsgg=; b=RtUpe1LbbNHQbFdeUGnzHTmggc
	WOe09mfbGn6C3k+0CEn3YBfkCB2qoQR7jGbna20Xl55MDgPUDlQp+sZlTWl4Bik4GNyDuEFM6mWB+
	RdHkok0HgCc7G0m0Xaxxdlq5Dk0iboMDBjZ1rzFR0cQq2/M5JMO4Gv/Gu2JCGsVpMoMw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuFbS-0004wk-PG;
	Wed, 12 Aug 2026 20:31:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuFbR-0004w8-25
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KWayOvxdGhPR/EVDl3AJbGwV+v1v/6G2FIF2bn4bCnw=; b=D+5P30Zz/eHMFe8GObWxuZ/VFD
 bHzrfP7TllytmYwGVTi/YfaTPIUb4L3X3AVnZCZO0I5QX9445JtdXz9su9/XIKZKAICq5XiC0W43+
 scRNOfap3uslVrsujRonY0xUx/0XlYzIZy1n8mCtRCeLdDIYgbHmt8rPgZdIoASzRrnA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KWayOvxdGhPR/EVDl3AJbGwV+v1v/6G2FIF2bn4bCnw=; b=kJLxyLCtlZ3JLf2P1+YS1P2dH0
 4CpTNB/hIR+pA1T2HCzmjcRj/UdPLZstCKug9VGWcjXxB/m/ws+BxTs773K81ZS/8Z9KakdX3bfAt
 516eQussxs/PVI9ft7kwO03FcOrPA+NunnWO8VyUWqfH0IrDMNHgvyjl8+lY7WZ3J+CY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuFbG-0000qO-Ey for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:30:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 326AE4394F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 20:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158231F000E9;
 Wed, 12 Aug 2026 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786566653;
 bh=KWayOvxdGhPR/EVDl3AJbGwV+v1v/6G2FIF2bn4bCnw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=LmtlVqmcPDMD8XNDCuJ7uKAnPlxhpW4wYXTntjCdHQbZppiBVt3M/0JoamTDj1TlT
 rDK4/btzLhDGLRalE11WsCx3WlL6vHx0edJA+e4+I5vGlKGOZ3XqSolwoG9ZbU3sm2
 a7aHW+/Q7t38eaXcnMEiVzThsZylHtIp2NKqKxbQ/UcDOv90dxz3HPjwty//jKGDgl
 HIoe5CZc4klM0n2fC1AZqb1YlgB2GdKV3tUve0psKKnZ/E4sanQrz35jdB11ih0M1h
 QSAMycosf7vjV/E5qgznOIF3mk0oQEACQYLFv1batQeLES4ga1e0O7cDm3gzncE+XR
 9gQ4E03s7bYXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93972380CEC4; Wed, 12 Aug 2026 20:30:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178656660813.2090005.5153919600313897354.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 20:30:08 +0000
References: <20260809012639.568485-1-chao@kernel.org>
In-Reply-To: <20260809012639.568485-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wuFbG-0000qO-Ey
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: unify add/remove ino entry API
 for all ino types
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

On Sun,  9 Aug 2026 09:26:38 +0800 you wrote:
> - Call f2fs_add_ino_entry() and f2fs_remove_ino_entry() for ORPHAN_INO
> - introduce __f2fs_add_ino_entry() to wrap __add_ino_entry(), so that
> both f2fs_add_ino_entry() and f2fs_set_dirty_device() will call
> __f2fs_add_ino_entry().
> 
> So, after this change:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: unify add/remove ino entry API for all ino types
    https://git.kernel.org/jaegeuk/f2fs/c/d3915a0a356e
  - [f2fs-dev,v2,2/2] f2fs: reduce memory footprint of ino management
    https://git.kernel.org/jaegeuk/f2fs/c/798bddf3d9a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
