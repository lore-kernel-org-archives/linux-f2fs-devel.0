Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1B7C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Oct 2022 01:06:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1of9ul-0007xu-Nn;
	Mon, 03 Oct 2022 01:06:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1of9uj-0007xo-RE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Oct 2022 01:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OfRyUk4k9ntOD+XElilkt5DMi0ypr0g+lsaUdiHqw7c=; b=X0eOnPqk6sjSycGR4KRcBTfu7L
 K8X3+IkkczPL89s0mrbJ8Z320GJlmfOs+MRJow4vFRJBlwyG/qmBGY9fHCjT/ObGYepJ7etFdprWf
 0CEYZEA2gVlRDrNC6V3GPEjNxzWMgUK17m5ZxhS3XiGy/lxlqIeiHJR5R8nlodlgJWs0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OfRyUk4k9ntOD+XElilkt5DMi0ypr0g+lsaUdiHqw7c=; b=SBPLZ5hk/YvvQ2abLIDiMUQ25/
 NRwLmSysWUrqRHehQLddkB1VvDnhX+06fyRrAyxWyRfNBczhc0TiG7MSPW/V2AHwJiMU3OCmyt4SM
 XPNfGdrzwgbtUYfKU2fHQQFrFuvSzAYTLh0F1vhb/rfkfVPImq0mpkNRazW46ixq2g+w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1of9uo-00AON9-0y for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Oct 2022 01:06:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC3860EB6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Oct 2022 01:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B762CC433C1;
 Mon,  3 Oct 2022 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664759187;
 bh=LNtyrqL8s3QCbfOe513whdYym7bNutbjbJr00KK4IHk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CCh/Jptcva3GfzdKOnh8bRdLb+pr3CyHVhA+3Z/vNpeInKyBo5v3wOdpl1wzEk64F
 lJ9D0iDxPrPtMfgwzIXsYlWDYQNO1WxTwb4aHrruNf3mNaR78kuByklaST3OgBGFaX
 fqTihHzUE/JKAFWfxTx4zS0nAgqC2tcvwr53UxNkLyE6IR1V8SxAGocpqCsBGYHHdn
 hfwa3b0yIVXFmGUAkbm68tvN9o4vh8ZZI77hSk7jnZL6WaWLqIaASmyFpbUvgBkQPN
 tDZXHxsJyjGILPG/ZIDcpUq6Nyn1VjOt21wC+W9sOquP+GXLPNDEVWtJNzhkVLqfjb
 k+ZKeON9dKsKQ==
Date: Sun, 2 Oct 2022 18:06:26 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Yzo1krmcr4N58mg+@google.com>
References: <20220925055802.11955-1-chao@kernel.org>
 <YzMnm4vx7dxb+vAA@google.com>
 <f8be286d-a3d9-2426-ab79-34d5c6e80a9c@kernel.org>
 <YzO8P7/XM4OckVSp@google.com>
 <7387ba71-46bd-aed9-d435-f234f486a7a0@kernel.org>
 <YzXjrn7oZzVmUz/n@google.com>
 <45e56fa9-de7a-7858-f032-4433adb2b021@kernel.org>
 <YzduzKQN3xTg1cqh@google.com>
 <d42b88ab-39b6-71ba-a891-5d3a82b486d9@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d42b88ab-39b6-71ba-a891-5d3a82b486d9@kernel.org>
X-Headers-End: 1of9uo-00AON9-0y
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: update allocation policy for ro
 feature
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/01, Chao Yu wrote:
> On 2022/10/1 6:33, Jaegeuk Kim wrote:
> > On 09/30, Chao Yu wrote:
> > > On 2022/9/30 2:27, Jaegeuk Kim wrote:
> > > > On 09/28, Chao Yu wrote:
> > > > > On 2022/9/28 11:15, Jaegeuk Kim wrote:
> > > > > > On 09/28, Chao Yu wrote:
> > > > > > > On 2022/9/28 0:40, Jaegeuk Kim wrote:
> > > > > > > > On 09/25, Chao Yu wrote:
> > > > > > > > > Update allocation policy for ro feature:
> > > > > > > > > - hot_data: allocating blocks by LBA ascending order
> > > > > > > > > - hot_node: allocating blocks by LBA descending order
> > > > > > > > 
> > > > > > > > This will increase the RO image size.
> > > > > > > 
> > > > > > > Shouldn't RO image has fixed-size during mkfs?
> > > > > > 
> > > > > > First run gives the reduced size information, and second round makes the image
> > > > > > with the required size.
> > > > > 
> > > > > I didn't get it, in which step it may increase the RO image size?
> > > > > 
> > > > > IIUC, after we apply this patch, reduced size information won't change due
> > > > > to that after sload in first run, total used block count should be fixed?
> > > > 
> > > > First run fills the data and leaves the maximum LBA touched in the image. Then,
> > > 
> > > How about caclulating required size w/ total used blocks rather than maximum LBA?
> > 
> > Do you think that can give the smallest size for the image?
> 
> I guess so, but let me do some tests to check that.
> 
> Segments for data block and node block should be calculated separately:
> required_blks = roundup(data_blks, blks_per_seg) + roundup(node_blks, blks_per_seg)
> 
> Am I missing something?

I think that'd be fine tho, please test first.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > it'll resize the image file and run again with the smallest image.
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > > > ---
> > > > > > > > >      mkfs/f2fs_format.c | 4 ++--
> > > > > > > > >      1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > > > > > > > > index 40ac589..8d0f410 100644
> > > > > > > > > --- a/mkfs/f2fs_format.c
> > > > > > > > > +++ b/mkfs/f2fs_format.c
> > > > > > > > > @@ -544,10 +544,10 @@ static int f2fs_prepare_super_block(void)
> > > > > > > > >      	}
> > > > > > > > >      	if (c.feature & cpu_to_le32(F2FS_FEATURE_RO)) {
> > > > > > > > > -		c.cur_seg[CURSEG_HOT_NODE] = 0;
> > > > > > > > > +		c.cur_seg[CURSEG_HOT_NODE] = last_section(last_zone(total_zones));
> > > > > > > > >      		c.cur_seg[CURSEG_WARM_NODE] = 0;
> > > > > > > > >      		c.cur_seg[CURSEG_COLD_NODE] = 0;
> > > > > > > > > -		c.cur_seg[CURSEG_HOT_DATA] = 1;
> > > > > > > > > +		c.cur_seg[CURSEG_HOT_DATA] = 0;
> > > > > > > > >      		c.cur_seg[CURSEG_COLD_DATA] = 0;
> > > > > > > > >      		c.cur_seg[CURSEG_WARM_DATA] = 0;
> > > > > > > > >      	} else if (c.heap) {
> > > > > > > > > -- 
> > > > > > > > > 2.36.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
