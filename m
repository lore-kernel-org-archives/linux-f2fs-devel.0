Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6D8CA0EED
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Aug 2025 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oIy5mUITZv7/duKCqRq4IVQfkPeVmOTvkw/qAinuEVU=; b=NgRoypbOtQ4mJ8vT26zSHrSyYC
	MO1fMfJyQ537w6LsZ4ZuI8yDs/uC7N7au0oOO+5F3JM4mL5ABUhE/AaHo2xKZQq2rQx0qJ5ey7r0c
	K+9Jyuv74uNVZ68h8tXu1wrunnjaLWeMsmneGzbHLhchpg8Pp3pmQhF+YmzVZFZcHFGM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ureTE-00057D-AC;
	Thu, 28 Aug 2025 15:23:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ureTB-00056u-So
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Aug 2025 15:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2b/dtXYWBln2J5oP8lc0EDeOJ5aUdHOcjZK+JPuyYmU=; b=QutxmI/ui4F97wJ9F2lR1sp8J1
 PA3c/b3R/SxkLmP6tRUmWdyNP5pMb8g8TqJzZZXZehaTO4Ww5fVRMWkCzOzYn4sm4fBwTdehTvLwy
 Pcvmxmx9WA10HtTr3wJC4fejaHg0gmvWUDuYtxjTTih4X2FpwGwrvw7MRzFdN7+uTlBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2b/dtXYWBln2J5oP8lc0EDeOJ5aUdHOcjZK+JPuyYmU=; b=alx37aP8XO+qfmfV/D3EEfILdD
 aBbokTHpWvK5tIdmfDDpvbQRT2kMHFqFjJpwXCkBStOaJuTzWBygmS2OxPcw2guPoiOE9qFceZCE9
 KpIZhPrTFNs4ZWXswl6URWK3UxowieHpk+9aHPTAW1bgabyxIU9nqGcxs7o0aKLP5xuk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ureTC-0005R9-Au for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Aug 2025 15:23:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F0129443A8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Aug 2025 15:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ECBC4CEEB;
 Thu, 28 Aug 2025 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756394591;
 bh=+IyXtugZDAwkV0nQVOTbTUtq9KhDGW63qq1hNOOYnJs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uy6xN7D1uOPIBoQpgwlyNsfJbS+24BQG0O5abid6fPCHXFDzeLcy4Ym4kxbZL2NCO
 S3h2n54MmM3T48+C1jFWBWr9F9DbvkZeM2OYuse4Rdtp/fFXGd7eX4ZKEt/X6yOM5J
 VjBbA6DTD5SfqExyUctidVjT7bsBDppv16ORj3xjUW66LSOI0Wv9KBvLBvFOXcqJZb
 U6/uAnEC9zkOmxV54EKHgPoBQHpsop0FueOxnuLcS6lZKwtNndYi6fYDIYrBCddfLJ
 Quq163YxqILJoCKX9DfmYUdDgpr5FSZgwoA74MrfHmOSRukdwdR1+Mt7jmTQNd3JqZ
 xXuT+V/FZYatw==
Date: Thu, 28 Aug 2025 15:23:09 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aLB0XeQh_tm2tXIA@google.com>
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
 <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
X-Headers-End: 1ureTC-0005R9-Au
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
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

On 08/28, Chao Yu wrote:
> On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > Let's split IPU writes in hot data area to improve the GC efficiency.
> 
> I didn't get it, IPU may be not friendly for migrating data along w/ write in
> hot area?

This deals with IPU in the LFS mode.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index e0f6589c6a1c..bb79dad55ac9 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
> >  
> >  		if (file_is_hot(inode) ||
> >  				is_inode_flag_set(inode, FI_HOT_DATA) ||
> > -				f2fs_is_cow_file(inode))
> > +				f2fs_is_cow_file(inode) ||
> > +				is_inode_flag_set(inode, FI_NEED_IPU))
> >  			return CURSEG_HOT_DATA;
> >  		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
> >  						inode->i_write_hint);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
