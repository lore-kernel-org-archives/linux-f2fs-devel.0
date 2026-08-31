Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA23C624C6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pJYFDKhN+I6X+KG+9J0+ShyIB20u02a20YEorCvYmv4=; b=e3GDbxg/c9Yp9n3xHwjGHF4Fgh
	lTICcIVjn+97EZZ1Ts7/61zBnxPe4P5McN3SAmxsYUHoC4AwsGb+dziWsDuuV1QM8rZ+2wWERDqWT
	I0yONLA93RUucfBPuukPy0f+6412GAnHtr0QDc0X99k+P5LyOVqmJuZsMjmv4gmMx5Bs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x18qN-00048Q-L8;
	Mon, 31 Aug 2026 20:43:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1x18qM-00048I-Bu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 20:43:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EcsqIntohDBj7T07atoCdhzgU+9ZNI8GEG8azdvgvJA=; b=nQaH5cNO9l0bRA1Mf1LIfiZSiU
 l4oagAV8jdiqdEhoda898N/10LTnLAgMqUoH0xLKrougGWQEoAnDtS/ghS/URSswiZN8xZvZIXZdX
 cKjs/yWk8W+VjH/imNYKcoHmtDgYEgbjQxriNUDtwKa/hjblk7jIz8GuqeYgQN158Ufw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EcsqIntohDBj7T07atoCdhzgU+9ZNI8GEG8azdvgvJA=; b=CZzgvRoUzBDxj69LpTSMLZzgII
 8Wqjvb38cOBbt4XxuHQX7go3qwijtK1DlRsU5pXpJhh42QsuG5AG4k2ycSeD7RImYmYUXxjVg0gCx
 h9SSVHYz+MwbR1Hec663XnRJJsq6+/KAgqzseiDMDKwzKCz0fLM85qj8auUMQhTyiByY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x18qL-0000IV-6h for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 20:43:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EEF7601DE;
 Mon, 31 Aug 2026 20:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD401F000E9;
 Mon, 31 Aug 2026 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788208974;
 bh=EcsqIntohDBj7T07atoCdhzgU+9ZNI8GEG8azdvgvJA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dAAjSV36Im0KXym3fl6aCZsYF7UXjbdF0EVKD7PT4GhNaG6JFsOVEPUNApNhbs66Y
 oq/L0aNfPFZfjq52rnznStVLOCk+H4k8CfhCynCp9UuMgWj6erLwF9WcB+2mw27AG/
 u4Plxihgr50APIHEpiELpva/MHjbyQuolf36O/mGsL+RzjlSQtU/WEKk/z/D7/Vx7P
 vmE3hetnL6KajuIiq+Do9BwWkj6GyrNutROj9BvxMw9JhxakxnJ5S1FMyAdRL+4FNW
 WxpVMWiwAXQXy+IFMBZfpWPQuezikM9YmBkqdlis75Hs/nccI21HW9mYQPsMJYyec5
 ilvmJVLDInbVw==
Date: Mon, 31 Aug 2026 20:42:53 +0000
To: Kelvin Zhang <zhangxp1998@gmail.com>
Message-ID: <apXnTaf1gQOxBmLk@google.com>
References: <CAH=xXfE6o2sLwcYdoH9cayZpbf389y8PeJ_aDRty61i7q4QKow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAH=xXfE6o2sLwcYdoH9cayZpbf389y8PeJ_aDRty61i7q4QKow@mail.gmail.com>
X-Headers-End: 1x18qL-0000IV-6h
Subject: Re: [f2fs-dev] [PATCH v6 00/11] f2fs: prepare metadata layouts for
 runtime block sizes
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Kelvin,

I see only the first patch in this series. Am I missing something?

On 08/31, Kelvin Zhang wrote:
> F2FS currently describes several on-disk metadata layouts and filesystem
> geometry values with constants derived from PAGE_SIZE or a fixed 4KB block
> size. This series derives those values from the mounted filesystem's block
> size instead, as preparation for supporting filesystem blocks smaller than
> PAGE_SIZE.
> 
> The patches initialize sb_info early, describe the SIT, NAT, orphan, dentry,
> node, and xattr layouts dynamically, parameterize sector/byte/block
> conversion helpers, and derive node-tree geometry at runtime.
> 
> This series does not relax the block-size mount check or enable subpage I/O.
> It is intended to be a behavior-preserving refactoring for currently
> supported 4KB-block filesystems.
> 
> Changes since v5:
> - no code changes
> - send each diff as a base64-encoded text/x-patch attachment because Gmail's
>   outgoing transport reflowed long lines in inline text/plain bodies
> - verified that an actual received raw message applies with git am and
>   produces the expected tree; the list-side copy of patch 01/11 will be
>   checked before completing the series
> 
> v5:
> https://lore.kernel.org/linux-f2fs-devel/CAH=xXfH7TPGt-zKXvJRNTgGDZKa1Xoq_sF3-WGs5kdsQLuYn4g@mail.gmail.com/
> 
> Changes since v4:
> - no code changes
> - resend with CRLF-canonicalized RFC822 messages; the delivered inline patch
>   was still reflowed by Gmail's outgoing transport
> 
> v4:
> https://lore.kernel.org/linux-f2fs-devel/CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com/
> 
> Changes since v3:
> - no code changes
> - resend with git send-email because the previous mail-sending path produced
>   hard-wrapped hunk headers in the delivered messages
> 
> v3:
> https://lore.kernel.org/linux-f2fs-devel/CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com/
> 
> Changes since v2:
> - use DECLARE_FLEX_ARRAY() for flexible arrays that are alone in a struct or
>   used in a union, fixing the reported m68k GCC build failures
> - use F2FS_BLK_ALIGN() in f2fs_sec_trim_file() to avoid a runtime 64-bit
>   division and an unresolved __divdi3 reference on 32-bit SH
> - no other code changes
> 
> Changes since v1:
> - rebase onto f2fs/dev at c966d29e01bb
> - drop the unrelated free-NID underflow fix from this series
> - split the preparatory changes into 11 focused patches
> - initialize sb_info earlier and describe the xattr layout explicitly
> - separate sector, byte/block, and block-size macro parameterization
> - update commit messages and address checkpatch warnings
> 
> v2:
> https://lore.kernel.org/linux-f2fs-devel/CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com/
> v1:
> https://lore.kernel.org/linux-f2fs-devel/CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com/
> 
> Tested with:
> - x86_64 W=1 F2FS build at every patch
> - arm64 16KB-page W=1 F2FS build at the series tip
> - m68k W=1 F2FS builds with the two reported randconfigs at the affected
>   patch points
> - SH W=1 F2FS build with the reported randconfig at the affected patch;
>   fs/f2fs/file.o has no __divdi3 reference
> - scripts/checkpatch.pl --strict (no errors or warnings)
> 
> Kelvin Zhang (11):
>   f2fs: initialize sb_info early in f2fs_fill_super
>   f2fs: describe SIT block layout dynamically
>   f2fs: describe NAT block layout dynamically
>   f2fs: describe orphan block layout dynamically
>   f2fs: describe dentry block layout dynamically
>   f2fs: describe {i,d,id}node block layout dynamically
>   f2fs: describe xattr block layout dynamically
>   f2fs: parameterize sector conversion macros
>   f2fs: parameterize byte and block conversion macros
>   f2fs: parameterize block size and mask macros
>   f2fs: describe node tree geometry dynamically
> 
>  fs/f2fs/checkpoint.c    |  75 ++++++++++--------
>  fs/f2fs/data.c          |  85 +++++++++++---------
>  fs/f2fs/debug.c         |   4 +-
>  fs/f2fs/dir.c           |  51 ++++++------
>  fs/f2fs/extent_cache.c  |   6 +-
>  fs/f2fs/f2fs.h          | 122 +++++++++++++++++++++-------
>  fs/f2fs/file.c          |  84 +++++++++++---------
>  fs/f2fs/gc.c            |  27 ++++---
>  fs/f2fs/inline.c        |  11 ++-
>  fs/f2fs/inode.c         |  22 +++---
>  fs/f2fs/node.c          | 171 +++++++++++++++++++++-------------------
>  fs/f2fs/node.h          |  89 +++++++++++----------
>  fs/f2fs/recovery.c      |   4 +-
>  fs/f2fs/segment.c       |  60 +++++++-------
>  fs/f2fs/segment.h       |  32 ++++----
>  fs/f2fs/shrinker.c      |   2 +-
>  fs/f2fs/super.c         |  83 +++++++++++++------
>  fs/f2fs/sysfs.c         |  10 +--
>  fs/f2fs/verity.c        |   6 +-
>  fs/f2fs/xattr.c         |  10 ++-
>  fs/f2fs/xattr.h         |  15 ++--
>  include/linux/f2fs_fs.h | 131 ++++++++++++++++--------------
>  22 files changed, 636 insertions(+), 464 deletions(-)
> 
> 
> base-commit: c966d29e01bbf829f8bb4a39a49811c56cdb49c3
> -- 
> 2.53.0
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
