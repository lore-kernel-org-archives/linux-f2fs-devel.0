Return-Path: <SRS0=gGzW=P6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB0C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Nov 2021 08:49:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C57F61208;
	Thu, 11 Nov 2021 08:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C57F61208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ml5lm-0001jt-MI; Thu, 11 Nov 2021 08:49:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+a654ec194c2e40c649d1+6654+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1ml5lk-0001iz-M4
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Nov 2021 08:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qQClB1RuEEhDViXhRSFuuf7aZYP052UynzMbrreOcic=; b=MCUjibOc+a7ECttLjnPQ387Jcu
 fPi5AueXFOb2Ll2qVxEAlaAth/LCI/WhM4Yn7Nfat5CkjQkyU20SZtFhTJb/lBKB3l4URNAtyK0Ya
 7bQOTW62yzjEqmFQUxufSPH++U76BHAhx7rgIM08MzMgWqFlQjdDfr+A+e/k83VflITA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qQClB1RuEEhDViXhRSFuuf7aZYP052UynzMbrreOcic=; b=KRUhDUGMwqK9nEG4BFeIA8Q/vR
 vHsggCwUY+0p4wqZ1+C4Tmb8MaOKNxTreAqfGR+VPv5vKdsUdW637PB5C9U4DicDRiFyg7Ol1Wr+1
 qMCaAPbTA+UhGRJDRXscawut0kUI5G9bIlnoaeLK5AXmvGbCqBqfM1ArNcSDYF34SL9M=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1ml5lj-009ORj-EJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Nov 2021 08:49:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=qQClB1RuEEhDViXhRSFuuf7aZYP052UynzMbrreOcic=; b=Zd5UfjRbODlmAtwbJ4KpmWeAmF
 79+6ibuZAQEsaWiXNYkbfxtEXbvioSVDfJ2OkN05o5rhhO9H5digIAirsBy4aoeSVcpY249GusI0Z
 CIB8cNEqDDyg8/jVolvzxXHfPN1A/BxZ9t5eEjwhPIqAFnBMhWOqFFo5sTHm4s56nkZnDpuP21rOb
 LV/jUu3BlyQkOkbxg/+BQ614xGg0RrtTaGmcXFZ4fThaPD3GaD27BuHWLHKw25B5zKYwXri9O4TXL
 QNDkCZVJXVt8KwuX5I5R31/RM1RkUc6VwZ9gsBIDImeGcW4oEYp50oOW4ZKeVQu0vl9GJijXqRD4R
 byAROOgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ml5lb-007Wsc-G6; Thu, 11 Nov 2021 08:49:07 +0000
Date: Thu, 11 Nov 2021 00:49:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YYzZA7UHY6p5x3Or@infradead.org>
References: <YYyX3oZXNAjYzG0A@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYyX3oZXNAjYzG0A@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1ml5lj-009ORj-EJ
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 5.16-rc1
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

So question on the direct I/O code.  The perfectly fine iomap code
wasn't merged because of the pre-existing stale data exposure issuewith
f2fs direct I/O low-level implementation.  This doesn't seem to be fixed
or even worked around, but instead we do get new direct I/O features?

On Wed, Nov 10, 2021 at 08:11:10PM -0800, Jaegeuk Kim wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit ff1ffd71d5f0612cf194f5705c671d6b64bf5f91:
> 
>   Merge tag 'hyperv-fixes-signed-20210915' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux (2021-09-15 17:18:56 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.16-rc1
> 
> for you to fetch changes up to 5429c9dbc9025f9a166f64e22e3a69c94fd5b29b:
> 
>   f2fs: fix UAF in f2fs_available_free_memory (2021-11-09 08:23:17 -0800)
> 
> ----------------------------------------------------------------
> f2fs-for-5.16-rc1
> 
> In this cycle, we've applied relatively small number of patches which fix subtle
> corner cases mainly, while introducing a new mount option to be able to fragment
> the disk intentionally for performance tests.
> 
> Enhancement:
>  - add a mount option to fragmente on-disk layout to understand the performance
>  - support direct IO for multi-partitions
>  - add a fault injection of dquot_initialize
> 
> Bug fix:
>  - address some lockdep complaints
>  - fix a deadlock issue with quota
>  - fix a memory tuning condition
>  - fix compression condition to improve the ratio
>  - fix disabling compression on the non-empty compressed file
>  - invalidate cached pages before IPU/DIO writes
> 
> And, we've added some minor clean-ups as usual.
> 
> ----------------------------------------------------------------
> Chao Yu (7):
>       f2fs: quota: fix potential deadlock
>       f2fs: avoid attaching SB_ACTIVE flag during mount
>       f2fs: introduce excess_dirty_threshold()
>       f2fs: fix wrong condition to trigger background checkpoint correctly
>       f2fs: multidevice: support direct IO
>       f2fs: fix incorrect return value in f2fs_sanity_check_ckpt()
>       f2fs: support fault injection for dquot_initialize()
> 
> Daeho Jeong (2):
>       f2fs: include non-compressed blocks in compr_written_block
>       f2fs: introduce fragment allocation mode mount option
> 
> Dongliang Mu (1):
>       f2fs: fix UAF in f2fs_available_free_memory
> 
> Fengnan Chang (1):
>       f2fs: compress: fix overwrite may reduce compress ratio unproperly
> 
> Gao Xiang (1):
>       f2fs: fix up f2fs_lookup tracepoints
> 
> Hyeong-Jun Kim (2):
>       f2fs: compress: disallow disabling compress on non-empty compressed file
>       f2fs: invalidate META_MAPPING before IPU/DIO write
> 
> Jaegeuk Kim (1):
>       f2fs: should use GFP_NOFS for directory inodes
> 
> Keoseong Park (1):
>       f2fs: fix to use WHINT_MODE
> 
> Qing Wang (1):
>       f2fs: replace snprintf in show functions with sysfs_emit
> 
> Weichao Guo (1):
>       f2fs: set SBI_NEED_FSCK flag when inconsistent node block found
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs | 16 ++++++
>  Documentation/filesystems/f2fs.rst      | 19 +++++++
>  fs/f2fs/checkpoint.c                    |  8 ++-
>  fs/f2fs/compress.c                      | 20 +++++++
>  fs/f2fs/data.c                          | 95 +++++++++++++++++++++++++--------
>  fs/f2fs/f2fs.h                          | 54 ++++++++++++++++---
>  fs/f2fs/file.c                          |  6 +--
>  fs/f2fs/gc.c                            |  5 +-
>  fs/f2fs/inline.c                        |  2 +-
>  fs/f2fs/inode.c                         |  4 +-
>  fs/f2fs/namei.c                         | 32 +++++------
>  fs/f2fs/node.c                          |  1 +
>  fs/f2fs/node.h                          |  5 --
>  fs/f2fs/recovery.c                      | 14 ++---
>  fs/f2fs/segment.c                       | 83 +++++++++++++++++++++-------
>  fs/f2fs/segment.h                       |  1 +
>  fs/f2fs/super.c                         | 39 +++++++++++++-
>  fs/f2fs/sysfs.c                         | 24 ++++++++-
>  fs/f2fs/verity.c                        |  2 +-
>  fs/f2fs/xattr.c                         |  2 +-
>  include/trace/events/f2fs.h             | 33 ++++++++----
>  21 files changed, 359 insertions(+), 106 deletions(-)
---end quoted text---


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
