Return-Path: <SRS0=IVPH=Y6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B2C5DF63
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:57:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAF02173E;
	Wed,  6 Nov 2019 21:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fjQNJ+T+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dKH5aPuK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXQ989co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAF02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iSTIx-0001HX-LH; Wed, 06 Nov 2019 21:57:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iSTIw-0001HQ-0P
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Nov 2019 21:57:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mWqdWwOtX++HMvHsdA3efMRq5Ymgvn0gy61KF+advYs=; b=fjQNJ+T+70XhJBTune3IyEMAlp
 c84ObjC9moYVCRMik4JssebQtVcn9O6nb7GrthW/+EP7wOo0qTDJJ0TQHW7z3etNIuiQ2MVB2HTFk
 L/PYQeQhKS5Vx5LsHWNzdcOX3Pf850AiwBlWubzP2EFhluoLGP49dRFdLzHvK+uwMcOw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mWqdWwOtX++HMvHsdA3efMRq5Ymgvn0gy61KF+advYs=; b=dKH5aPuKn32Fn8+KIm/ZKeQpuW
 0po67omTXL80P2F8Lo94hX5DQ10bdm+70dqri65UzXIdoXJVxl0ExVzkYL2/5RAMtxzgiUwfNi4nL
 GA3F3gu5XQidlPR+LZng0gWf7ZtSTIvDvlS+J+0/euW2fKr1I66vIQq52CfK5wBCNhbo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iSTIu-002o4a-43
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Nov 2019 21:57:29 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1CBAD2173E;
 Wed,  6 Nov 2019 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573077442;
 bh=7sER/moXfyFUCLPKujherydIaD5s2ggVDodB0ZuwT+M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KXQ989co5T5zuGUY3xiXOlxt1pwdFozDP5LJM6vZo2e886Y7nWRvRxGCJ5d8Gl1x8
 ZfJ9edkjSHIhb0xHddY3u/Q+iOI3VKdX2WifaKh6Xu7HP+S/LGsc+YPT0G7Pxttf6X
 ojykarHulCqdIL31fYSHwT9zDu0I366d7+7o3FeI=
Date: Wed, 6 Nov 2019 13:57:20 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <20191106215719.GD139580@gmail.com>
Mail-Followup-To: linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Victor Hsieh <victorhsieh@google.com>
References: <20191029204141.145309-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191029204141.145309-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1iSTIu-002o4a-43
Subject: Re: [f2fs-dev] [PATCH 0/4] statx: expose the fs-verity bit
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, David Howells <dhowells@redhat.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Oct 29, 2019 at 01:41:37PM -0700, Eric Biggers wrote:
> This patchset exposes the verity bit (a.k.a. FS_VERITY_FL) via statx().
> 
> This is useful because it allows applications to check whether a file is
> a verity file without opening it.  Opening a verity file can be
> expensive because the fsverity_info is set up on open, which involves
> parsing metadata and optionally verifying a cryptographic signature.
> 
> This is analogous to how various other bits are exposed through both
> FS_IOC_GETFLAGS and statx(), e.g. the encrypt bit.
> 
> This patchset applies to v5.4-rc5.
> 
> Eric Biggers (4):
>   statx: define STATX_ATTR_VERITY
>   ext4: support STATX_ATTR_VERITY
>   f2fs: support STATX_ATTR_VERITY
>   docs: fs-verity: mention statx() support
> 
>  Documentation/filesystems/fsverity.rst | 8 ++++++++
>  fs/ext4/inode.c                        | 5 ++++-
>  fs/f2fs/file.c                         | 5 ++++-
>  include/linux/stat.h                   | 3 ++-
>  include/uapi/linux/stat.h              | 2 +-
>  5 files changed, 19 insertions(+), 4 deletions(-)
> 

Any more comments on this?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
