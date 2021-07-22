Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE95C6377B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 01:43:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4084260FDB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 01:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4084260FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6Njq-00034k-To; Thu, 22 Jul 2021 01:43:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1m6Njp-00034O-Me
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 01:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qZBmtpysc110Nc04juAmH/QV0HtDI+GOC3DwQx24no0=; b=fcBbrQrJ1HKCrb5QgdL9TMiErq
 06uuVNm+/5q3zPfVXqMV9XI05z5ALEmUgmYbI2CcpFXskxKTOY+LxWQww/8zTv143YeuGPnH9lzFX
 ItFdqnD/6+AtmHaqgUA2MrUaZYwjf5sK9b3R7/+IVx+sRXmUp0cVcNaFAykf6zaY+83A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qZBmtpysc110Nc04juAmH/QV0HtDI+GOC3DwQx24no0=; b=erEirSp0obCPu4tuaY44gg42OJ
 PhRwPAZkcNgReA0T7/9EiQyidSPjps9SV5PiSQ/fGMJgUeFF+l5+tFML/rqCbwz180u6lXb4gcjRv
 3lGitbd0VxBb7ud5ql8S4JZBXGytB2wyx8WjCud9tw3YEQMA/z6dKod70L+f9hO+JUa0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6Njk-00GIrK-UR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 01:43:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D8F60FDB;
 Thu, 22 Jul 2021 01:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626918171;
 bh=Y2xTwQc6YUfESJt0St8gmjwX+3UIJoeNHUkqBbZj8n8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b2gf1zVUCuVjVzKkm8L3v+N3ou/SDemhBhKk1skdhgMpRmfWiZnfcmb2XyNHo8p2Z
 4GuPI8gTKCfbRdSHaFEKtrf9NRZQ/QUrS+GoCHR5I+rjVNSLn+CeHGW7b5mZhNzMTL
 wAqEFwtnhX/U64HKeH5YOEjoy4ML9eO3QOs2AGeMqNChz3Ba9ufLSDXA31vscPCWa5
 HEmcE1cChWgQCMLAuvBtyaEo56KUYpVnm4hQJpw4I3WQMqD7f329rcQ9V9cCu+KjQG
 0HmueBdH5FmHF6tKxuEE009snZqkyGs7UhA93anhKdiAOuXvjKnSnOqdZ83mrqgrvm
 XgppLKrhFWwag==
Date: Wed, 21 Jul 2021 18:42:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YPjNGoFzQojO5Amr@sol.localdomain>
References: <20210719084548.25895-1-chao@kernel.org>
 <YPi/4kMUAhlRZV3M@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPi/4kMUAhlRZV3M@sol.localdomain>
X-Headers-End: 1m6Njk-00GIrK-UR
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong inflight page stats for
 directIO
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
Cc: jaegeuk@kernel.org, Chao Yu <chao.yu@linux.dev>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 21, 2021 at 05:46:26PM -0700, Eric Biggers wrote:
> On Mon, Jul 19, 2021 at 04:45:48PM +0800, Chao Yu wrote:
> > Previously, we use sbi->nr_pages[] to account direct IO, the count should
> > be based on page granularity rather than bio granularity, fix it.
> > 
> > Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
> > Signed-off-by: Chao Yu <chao@kernel.org>

Also, do we have to do this, as opposed to just moving F2FS_DIO_WRITE and
F2FS_DIO_READ out of ->nr_pages[] and into separate counters that are clearly
defined to be per-request?  As Christoph pointed out
(https://lkml.kernel.org/r/YPU+3inGclUtcSpJ@infradead.org), these counters are
only used to check whether there is any in-flight direct I/O at all.  (They're
also shown in /sys/kernel/debug/f2fs/status, but that doesn't really matter.)

As Christoph mentioned, there is a way to avoid needing f2fs_dio_submit_bio()
(which would save a memory allocation for every bio, which can fail).  But it
will only work if the counters remain per-request.

Can we leave these as per-request?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
