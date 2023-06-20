Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB016EB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jun 2023 06:16:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qBUfR-00057X-Rf;
	Tue, 20 Jun 2023 06:16:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qBUfE-00057M-17
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jun 2023 06:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8W2DEuD87GIO7/1vXptKoP66YMqcW7HNrOQF79P3wa8=; b=FMqMNGyv5DHawb9fWB+VMquEWq
 LExJKBcr+aZ6y43fMq58Xv7Qkjn8rIpfaZMt4pYq4CXahpCuoJYpcJAuPs618IuVXgXLE0+cBFyYZ
 obfMpzmibEKsNNoMZrrRaoKSv6/faKEMJsBqY3wLMWvOG4ipLlQMp7XmGf0XXFAnziD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8W2DEuD87GIO7/1vXptKoP66YMqcW7HNrOQF79P3wa8=; b=lHFFPrxefACwDWKrG6+2zG8fJr
 upjlPSv6piQDfyAxbZWCoTh6pTQfPlW0Pyelk39v9zzLlPxlJAx6+JDzV0ia+j1Bd2ZrLyDOHTvEk
 1Mcdcd7h1mxXbwubpRA+Lt7+uTJZHqVdriQJUPnUBdzKLMcGghXxtUF8ZFpa8Rc1Q0HA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qBUfD-00024U-U7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jun 2023 06:16:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8485C60EA9;
 Tue, 20 Jun 2023 06:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C47C433C8;
 Tue, 20 Jun 2023 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687241781;
 bh=LMpBGTUUUELkIM6EQvSKyMUkDFcwpA6qZ213us++S/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=McUN6c30/9B3DyabSlV3RNOLOHpvJxz3x2/QO/PqBi1TJJTBj3ovgS4HP0J/GaEXe
 KDhYuEFd7/lPv4hkpbvMCsxo5+Me0Ixyf9I/NUQjXVT4G6twavRfo5HcXshpgWFF5G
 MlrdanTDPkbYMwgsyND8dU3Jw1wKB2kxOVYSO+XXWESEy4pXfYBwZC/nRoON+mTobc
 QB1yN0kBk/rlxO9no3utaa4R6KHWzbfzdCvjzhtVqwnw3wfTSWsxdG8f9KRmpci8PJ
 s+viyKm8QgrKQX3aEy6cc0z5btJ0KGd4FDQzZjdwY991SaF5kuwphQq4SgCoJyb9Gz
 3EyLjHvJxcB5Q==
Date: Mon, 19 Jun 2023 23:16:20 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Message-ID: <ZJFENFDFVx++RmhA@google.com>
References: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
X-Headers-End: 1qBUfD-00024U-U7
Subject: Re: [f2fs-dev] f2fs async buffered write patch
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
Cc: linux-f2fs-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
 Lu Hongfei <luhongfei@vivo.com>, Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/19, Jens Axboe wrote:
> Hi,
> 
> I came across this patch in a news posting:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d618126911829523e35a61f4a5a4ad159b1b2c8d
> 
> which has me a bit worried. As far as I can tell, all that patch does is
> set FMODE_BUF_WASYNC, and then just hope that the lower layers handle
> the rest?
> 
> What happens if iocb->ki_flags & IOCB_NOWAIT is true, and now we do:
> 
> generic_perform_write(iocb, from)
> 	...
> 	->write_begin() <- does this block?
> 	...
> 	->write_end() <- or this one?
> 	...
> 	balance_dirty_pages_ratelimited() <- this one surely does...
> 
> If you look just one level down the latter to
> balance_dirty_pages_ratelimited_flags(), you'll even see the 'flags'
> argument documented there.
> 
> This looks pretty haphazard and cannot possibly work as-is, so please
> get this reverted until f2fs is converted to iomap, or IOCB_NOWAIT is
> handled by generic_perform_write() and below.

Thank you for pointing that out. It seems I haven't reviewed it carefully.
Hence I removed it from -next, and hope to have some time to convert iomap
soon.

Thanks,

> 
> -- 
> Jens Axboe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
