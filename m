Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C85C61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eYTPkKEZsn5cvExpwZSvJPNpUe6+GCsP7y/kdnvgPx4=; b=JdFyGflzVP0gF5clY0+Zpk5YOJ
	wir8t0+bdKZfNPfN5y4UrUrUlyljETrarFP30M+UX2Y/i+wAtaWt3wNRTeZYgI9V//MUVEzI1Yn12
	n6W7uIGtPkR/thcI4bX9tZAkP0fh/9BEEEpW7R8/fxf6nxtG/x+wgnAsjohUpDDkNE1E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyt5b-0005eO-EX;
	Tue, 25 Aug 2026 15:29:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wyt5a-0005eI-MW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tVKRvWX6p8X9bZrtcSCqgbr9okk3NH9G2DC7FeryNdc=; b=Pzpzw+AEXmrC2NrGjmP6NmjKY/
 S1O5hQwksr6S8E065TAo+sAC9hUwzGgVdHrrTEwBaz50kkxcWOwMMOo2kwG1FzJPJfEpTQ29e/0ez
 2y75htFdBnTP+W8XjcdLYNBB5cvioTvSzr/qWXnEbK1NwFwmErLebOSiNFebwLYExKVc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tVKRvWX6p8X9bZrtcSCqgbr9okk3NH9G2DC7FeryNdc=; b=QOM8JxUviOe/Vg0eN3EHsE6GH8
 Glba3gCrVvmJHA1soCbNA+uVgFlZPu7X2HCMXVDTnkWVbuhBT8W+qGm9OiW1uiwM4eGj9Z8Lbzf87
 h85yB3CdzS8nBaUkeI6/fnME3CU1DM09+9lXZ1x4dTRTyjPxWKLGc3JE7pVpRkgfiD+A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyt5a-0000kc-48 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:29:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D492601E0;
 Tue, 25 Aug 2026 15:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA86E1F000E9;
 Tue, 25 Aug 2026 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787671760;
 bh=tVKRvWX6p8X9bZrtcSCqgbr9okk3NH9G2DC7FeryNdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R12JOXqJ4q2QccFR9fFWBKsqbjFMfIU+wcLrv4ZDcI4EWiJix+FpDr/5wy1XK04Ck
 hVeeWF6XTWNqNwUn9lhiymxnF/XUhK4CJ/yULtPAnYj8rrF9vp9CF4tPLlkRfA72mU
 k82VVYvdhO3VWiHzNEz3nB5jemNhDOYqw5rZH+886xQYfHQ9tu6Ro9UYVmD1k2NP2a
 hWMBcoYUe23uP/w1Byvr2YnK8Buxvf9Eb5ezN1dGmFsGXkLjzbMf9llZXo+vKP4/Ye
 sxSF7CaclgHxB5Fndk3zKfkWuFPqw21FiIPZH3hnLvq/0yvzpe8dtYOFN+M4ldkdtV
 1//4OvfKzny2w==
Date: Tue, 25 Aug 2026 15:29:18 +0000
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <ao20zq7Qy8hUnM_g@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com> <aoylp9llX9zlKm-g@google.com>
 <20260825023925.230986-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260825023925.230986-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyt5a-0000kc-48
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't leave the hashed inode while
 it's unlinked
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/25, Wenjie Qi wrote:
> Hi Jaegeuk,
> 
> Thanks, v3 addresses the two error propagation issues I reported.
> 
> I have one question about successful rollback in a DIRSYNC directory.
> f2fs_unlink() runs f2fs_sync_fs() after __do_unlink() succeeds, but
> f2fs_symlink() calls __do_unlink() directly and returns without a
> checkpoint.

DIRSYNC is reachable only when there was no error until then?

> 
> Since f2fs_add_link() has already completed before symlink construction
> fails, could a checkpoint between the addition and rollback make the
> addition durable while the deletion remains dirty? Should the successful
> rollback run f2fs_sync_fs() when IS_DIRSYNC(dir), while keeping the
> original construction error as the return value?
> 
> Regards,
> Wenjie
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
