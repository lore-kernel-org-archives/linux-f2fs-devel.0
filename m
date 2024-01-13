Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3509EC3DA79
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 13 Jan 2024 01:46:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rOT6W-0000Pa-4j;
	Sat, 13 Jan 2024 01:46:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rOT6U-0000PU-TB
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 01:46:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nbA8oeWMgDf0w1JXDAr2dIj49ylyqJTLOAoy/Eha1iE=; b=f5sGPfoDmegemtSTxqjQJ2MzD4
 LyzO8P1P5+iLVq2wUOd9AzyBWllHS/RwlbLla1GiFPgWlhyDpp93rmi5fu14wm6CMbTo3SBgoHYhl
 PwSxHvmNz2VuCXDRGcXq5ryvAJeF7W4b5MfBhKq6gin9u+sXKwIwGQEr3qC5sN5Fkll4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nbA8oeWMgDf0w1JXDAr2dIj49ylyqJTLOAoy/Eha1iE=; b=VLeNmQlk409n2PpFxsvpUJJnRX
 rIowE6rPJhE7y6EZs/NRDDh4ZFlHeVL7n8hjUE21Xk3KK/x6YHBAtQTKEuoFSVTJ4rnFxJ0RDkgem
 qnuM2A2j0a3gSSpzDywAM3O8dYEm88GXhiorHEx6KR2WGZK+NW+whRPdMTPLmsGfkoSc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rOT6T-0007mk-H7 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 01:46:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0ED6ECE255F;
 Sat, 13 Jan 2024 01:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BECC433F1;
 Sat, 13 Jan 2024 01:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705110376;
 bh=zaiPSNhhDCALEXPsu0/5zDP8KZ7Ygv+cVB7uxilxzUQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mNEF6G9y8paz4GxWqk1eLQbEY3D4GZkjIU6iO+3PipzXR/Y10s9P3jJAHfAGDmYmj
 s7XY93n/huD/VZepZR8kOEm/Vn1vk4GojCJbaYXrFkWC6BNXuT9qO4X9NH09oC6XU8
 whY5MFm0y+ARTfFazvmWq955UftabBTGDz7VuHevgQetUrzmYUbGkYKsz5Brl/KdVy
 FYuOPqV61IMgAL/9q+1XhT+F4MgbuIypBsJ1DFrUj1knndFep2siRWJYpkL149E5nG
 TBXs2MzTV8jSzX3Te41k+QKXqISAfzBNlrbCgvEXo6cz/XMOqMlzeTre8/XqE+DL8s
 oidHNV7VodHiw==
Date: Fri, 12 Jan 2024 17:46:15 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZaHrZwPr9CG1COIe@google.com>
References: <20240113005031.GA1147@sol.localdomain>
 <20240113005747.38887-1-ebiggers@kernel.org>
 <20240113010118.GB1147@sol.localdomain>
 <ZaHnPyZeJPtsJQKF@google.com>
 <20240113013223.GA40156@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240113013223.GA40156@sol.localdomain>
X-Headers-End: 1rOT6T-0007mk-H7
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
> On Fri, Jan 12, 2024 at 05:28:31PM -0800, Jaegeuk Kim wrote:
> > On 01/12, Eric Biggers wrote:
> > > On Fri, Jan 12, 2024 at 04:57:47PM -0800, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > kill_f2fs_super() is called even if f2fs_fill_super() fails.
> > > > f2fs_fill_super() frees the struct f2fs_sb_info, so it must set
> > > > sb->s_fs_info to NULL to prevent it from being freed again.
> > > > 
> > > > Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")
> > > > Reported-by: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/r/0000000000006cb174060ec34502@google.com
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > 
> > > Jaegeuk, I'd be glad to take this through the fscrypt tree since that's where my
> > 
> > Ok, are you heading to push this in -rc1?
> > 
> > > broken commit came from.  But let me know if you want to just take this through
> > > the f2fs tree.
> > > 
> 
> Yes, we should get this into -rc1.

Ok, please do so.

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
