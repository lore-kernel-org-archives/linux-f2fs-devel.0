Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D075BC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 May 2022 11:53:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ns1Bk-0006TM-Ct; Fri, 20 May 2022 11:52:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <brauner@kernel.org>) id 1ns1Bj-0006TF-1V
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 May 2022 11:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hjSTuQtmJCGcPPknBWckYMJkzSehit25uQW9QfCDaBg=; b=ZiIG5JaLlghT0HhsSCMjDNI1Ih
 qkyNDU0ylMK5aUtaz2DwgY4+ezRDrHiMmriyBgqMVw6beOy6/SH4fxiwCnP5WJ7siGRbWTb+NYerC
 We5VMA0OtlqjpFFh20DR6QvZjGp7n9fKX+kYL84pBchzrYwY9vuccg0uyOPoN9Sm6tlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hjSTuQtmJCGcPPknBWckYMJkzSehit25uQW9QfCDaBg=; b=e7Fxv9EcBFNuPF0XtPkUTP9sqn
 eNWuLOELsGlQtc1Zaa/spQNPwLt4rKzUn8IaLfzyySG7HMmtekT8I0CAhzoAKNW/u3s/Ka/wagS7G
 HaAXthGp57VK9NF+fyvSrNE0MMbK+vBFdWYrzEfymRIZR/IYbZmq37gFFVn9waT3JCsg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ns1Bh-00CfNQ-8u
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 May 2022 11:52:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DC08061DED
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 May 2022 11:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDA2C385A9;
 Fri, 20 May 2022 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653047563;
 bh=KjobZP6O6Jgwt6QhmllP83ZeT6Jg+VwnOafaxcAZ+8c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bptv6Mg3TVFF3Sk1DQV4g4ILT2blHfHJLQtoU4tvyhqF7sBMSi7SFHPt3GYix9zDj
 fmabFBKLLAt+mzYpio3Dnr/a7b1Bzz/E1lwcSx8VAf8RLyOdKVCKRepQRXrq4mW3NI
 xqhUOLKtCR6bJJICVsEgK6en7zdhRbI3TuWM4uIQLCEtyDzROd1z4XU0U6Eg3HnHGC
 6Vu5Fs1CZPey2sZjUfEvTvZXyBNZShJ6tvoIR9/5uN7AJh/Mv7cAPeyxtXUC8GLCOr
 f3oZpQCpTLgA7aCs25q+jmOHsq0cBJOc1BrqKgBXL2hPTHR0+nkHa+zQP+BSejsGZ5
 JQb/K98Kky8rA==
Date: Fri, 20 May 2022 13:52:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20220520115237.w2oa5bdzyzhkgwin@wittgenstein>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220518235011.153058-2-ebiggers@kernel.org>
X-Headers-End: 1ns1Bh-00CfNQ-8u
Subject: Re: [f2fs-dev] [RFC PATCH v2 1/7] statx: add I/O alignment
 information
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 18, 2022 at 04:50:05PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Traditionally, the conditions for when DIO (direct I/O) is supported
> were fairly simple: filesystems either supported DIO aligned to the
> block device's logical block size, or didn't support DIO at all.
> 
> However, due to filesystem features that have been added over time (e.g,
> data journalling, inline data, encryption, verity, compression,
> checkpoint disabling, log-structured mode), the conditions for when DIO
> is allowed on a file have gotten increasingly complex.  Whether a
> particular file supports DIO, and with what alignment, can depend on
> various file attributes and filesystem mount options, as well as which
> block device(s) the file's data is located on.
> 
> XFS has an ioctl XFS_IOC_DIOINFO which exposes this information to
> applications.  However, as discussed
> (https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u),
> this ioctl is rarely used and not known to be used outside of
> XFS-specific code.  It also was never intended to indicate when a file
> doesn't support DIO at all, and it only exposes the minimum I/O
> alignment, not the optimal I/O alignment which has been requested too.
> 
> Therefore, let's expose this information via statx().  Add the
> STATX_IOALIGN flag and three fields associated with it:
> 
> * stx_mem_align_dio: the alignment (in bytes) required for user memory
>   buffers for DIO, or 0 if DIO is not supported on the file.
> 
> * stx_offset_align_dio: the alignment (in bytes) required for file
>   offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
>   on the file.  This will only be nonzero if stx_mem_align_dio is
>   nonzero, and vice versa.
> 
> * stx_offset_align_optimal: the alignment (in bytes) suggested for file
>   offsets and I/O segment lengths to get optimal performance.  This
>   applies to both DIO and buffered I/O.  It differs from stx_blocksize
>   in that stx_offset_align_optimal will contain the real optimum I/O
>   size, which may be a large value.  In contrast, for compatibility
>   reasons stx_blocksize is the minimum size needed to avoid page cache
>   read/write/modify cycles, which may be much smaller than the optimum
>   I/O size.  For more details about the motivation for this field, see
>   https://lore.kernel.org/r/20220210040304.GM59729@dread.disaster.area
> 
> Note that as with other statx() extensions, if STATX_IOALIGN isn't set
> in the returned statx struct, then these new fields won't be filled in.
> This will happen if the filesystem doesn't support STATX_IOALIGN, or if
> the file isn't a regular file.  (It might be supported on block device
> files in the future.)  It might also happen if the caller didn't include
> STATX_IOALIGN in the request mask, since statx() isn't required to
> return information that wasn't requested.
> 
> This commit adds the VFS-level plumbing for STATX_IOALIGN.  Individual
> filesystems will still need to add code to support it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
