Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90F8C3DA79
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 13 Jan 2024 01:28:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rOSpE-0003yM-Hn;
	Sat, 13 Jan 2024 01:28:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rOSpC-0003yG-L1
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 01:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k1QlxykwAsW7DTzQJp7Homu1hZvduHpcR0Q3Ek6HOtg=; b=IettXL5/r+sfmYLWjaCosyZgav
 EQV+e1vpsM9UmbjY0UnsAqqjq2/BsTUERon27O8lchhsBwyOy/7Bb9VqFOt10HlvHAlWgZ3C/47r+
 GUpLKZABHgAwD8x6Qwo1WcZBOdAAAvg/fSI4NqN+sYRgIa4GHNcoPFFwpOuoCNp7RHi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k1QlxykwAsW7DTzQJp7Homu1hZvduHpcR0Q3Ek6HOtg=; b=jOdA2m8ND1tGqOSe7Z91gROaJ+
 P1Eq+inkjRYSUheJb3Cr3snuM/km32YoWaOyfN1PTXCB7vhov3e7xXRu90rVNh71ihE96FUI4RneM
 HUTL6kdeEaDSHHLvGzF3hA/wSXmV6LsgKRtsQp4UCM3Qtfv/ncHhof5dSnyD2JoDiX9E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rOSpC-00070A-0U for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 01:28:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 29CD9612F3;
 Sat, 13 Jan 2024 01:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0BFC433C7;
 Sat, 13 Jan 2024 01:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705109312;
 bh=SGE0qROC2eANojk01AHCid9ZzrWcrsXBwB3H/XejRT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F1WMRQqK2LK08NPGtpm5xkCmp5k3ABCWCdYWrmK7C6KEqf5psragMFvsWOXOVjdoR
 rFzeCcyZQbKGxOqobTJBPdZJ7Q7LYDBW2hYAJ6Ks/eNoPiGy0oYHnRf9IBqSymDUYr
 gIDpL482iIs3Zeaso9exXhk5ViSnHJnHlUqfUWHUb/lHfz7Gchtvl4Q5Ag1TUVWg7/
 FBZ/xgTV+3RXAF736EiSJXLcpp2PwqrPehvk8m2laHdlXugCUedIIAytrlzUPBIlzZ
 JWMz2vDEyn6AHWbCyYpPYDcMvL9v3sMKaznGV+3uXEaJjXgrovkBMbODnAgZCabmVh
 X49DWrqaiNQ8Q==
Date: Fri, 12 Jan 2024 17:28:31 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZaHnPyZeJPtsJQKF@google.com>
References: <20240113005031.GA1147@sol.localdomain>
 <20240113005747.38887-1-ebiggers@kernel.org>
 <20240113010118.GB1147@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240113010118.GB1147@sol.localdomain>
X-Headers-End: 1rOSpC-00070A-0U
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double free of f2fs_sb_info
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
Cc: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com,
 linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/12, Eric Biggers wrote:
> On Fri, Jan 12, 2024 at 04:57:47PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > kill_f2fs_super() is called even if f2fs_fill_super() fails.
> > f2fs_fill_super() frees the struct f2fs_sb_info, so it must set
> > sb->s_fs_info to NULL to prevent it from being freed again.
> > 
> > Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")
> > Reported-by: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/r/0000000000006cb174060ec34502@google.com
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Jaegeuk, I'd be glad to take this through the fscrypt tree since that's where my

Ok, are you heading to push this in -rc1?

> broken commit came from.  But let me know if you want to just take this through
> the f2fs tree.
> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
