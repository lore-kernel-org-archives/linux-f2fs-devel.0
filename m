Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FDACA0FF2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Aug 2025 03:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjWhd11ElGyGG2CAoWIMhYTLxHqCzTo/UAfoNuEiZec=; b=mQ+/jPB4uCD+SNF6UshAVECgAE
	o4SI8tU5ccfrgSWawbLFulQjeqIsW+qso++NOYEg6zsYPlm07gSi9LPv9y5gQjtAab1yXmBSQY8rR
	pz455R1xEVt29tKcTuReSLqKsHdjh76+2x1CRNVuLoRQlBmOuI2SpQP1n5rA7/dmsUh8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1urTMc-00031Y-Up;
	Thu, 28 Aug 2025 03:31:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1urTMc-00031P-Fx
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Aug 2025 03:31:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WZsmG2FaXMKy0XH/8wB2xfmUoQhcWycJ5ebMVewMZbI=; b=Aj6quS0T8Bi40VAKgML6O6Jl3e
 V4MYbiEGnbJlZ1arIO0ailPPuDsoQKqL7cC4hEgOX4mQ/IOJZEuKpsMIIYGsd4trycVv9sO8DeSMa
 vBCVe9z4l0TNouS+12XeCp6+faL/itETo6nqx9K7f5x9DXcdZe6A9Onh6AKIxPCfeYkw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WZsmG2FaXMKy0XH/8wB2xfmUoQhcWycJ5ebMVewMZbI=; b=j1Mhz1S1y4vy6JninZOWzXs+Iz
 vHuBaTH3ww9oHuXPw38Ai+6vf2Mnci/sguWAoiFGfn0zc6LlQt+42/MSucHukl5X9/HjMXvUnExqr
 77l7qV0r2h4/tBW9ooJ5NojLsTCoKhcH322keTuQOjzZwn61vRRIKLaXbXfBiqB7fl/w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1urTMc-0005pw-Ur for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Aug 2025 03:31:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 957F74470E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Aug 2025 03:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB26C4CEEB;
 Thu, 28 Aug 2025 03:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756351900;
 bh=eYE4YCC+62NgocceA6DStyJGNAxd9Czbqyz9l9H8fPI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=GTWNkWeSX8cuirS/frmngcfncIZSlAu+Qqk7hpzkFsg+OmZuJgVQ558/KyJHml/nX
 U+rBjZWqWMKjkKJmFgL5kRNbaJE89+ZaVGuL59tbMkkx9ZT/fgVSds00uih6H67JSc
 vN3VpUARgf9biQ/Omemn1VYmblRWqAppZJkKBOCFsuGcH0a1kfb6oi4CGgttEgbt08
 kz1y8J0E9czEwnO1ERzOagvmjzw5u1ccbQJZHFgjjGGb6shIIrP+jd13arjV7Jcb7b
 Giy/qI5eNsb3/o/co1PXsnuAG1ymbfkRT4rBnhskOvScSzcnlUC3Fws3NBToCe7uE8
 RChmDh4MVgzuA==
Message-ID: <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
Date: Thu, 28 Aug 2025 11:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20250827215222.1615844-1-jaegeuk@kernel.org>
X-Headers-End: 1urTMc-0005pw-Ur
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Let's split IPU writes in hot data area to improve the GC efficiency.

I didn't get it, IPU may be not friendly for migrating data along w/ write in
hot area?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e0f6589c6a1c..bb79dad55ac9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  
>  		if (file_is_hot(inode) ||
>  				is_inode_flag_set(inode, FI_HOT_DATA) ||
> -				f2fs_is_cow_file(inode))
> +				f2fs_is_cow_file(inode) ||
> +				is_inode_flag_set(inode, FI_NEED_IPU))
>  			return CURSEG_HOT_DATA;
>  		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>  						inode->i_write_hint);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
