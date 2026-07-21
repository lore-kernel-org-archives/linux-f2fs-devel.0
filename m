Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70198C44515
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 00:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NwXtfoHsfexeQyMCG+fJeOUPB6V+zICuVxd+0M+OCdc=; b=auwTX2tmrPuf0d/In4YIkGy/RE
	oA7nowHM4N8kJ6hbIIz8au+BRuaCUnykj4wTp3Ht+NcjXwGe8Jw6VxTTEpYYL1fjDCsd25mYrQLZb
	23cw4Pum5ZDUXWzXug/BDrYaOFdfgGNZw7EaWVgw68f95PaXv3RamK2GywAh8lFTmBh0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlye6-0000pp-Pc;
	Tue, 21 Jul 2026 00:47:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wlye5-0000pi-9c
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 00:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qe4dxL2O/OqQk5rOLVOCDy8ZLVEizuB81/dqZgzj2ck=; b=Xs6PFrTftorjGmaUrqsTnPNHXg
 n1Nr5tObhvi60egTT6i3lrvEJz6PLbhl39IcyFlWH8Fc5HtAi1JNFCckXWWSnhZWFQ6f6xQ/pBqmG
 KbBvuOmz4NKiqZB9IyKswz3hujnIBfL/Y8H837Hti/0va9ft9/fJ58ujHL60M1yHNXqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qe4dxL2O/OqQk5rOLVOCDy8ZLVEizuB81/dqZgzj2ck=; b=U20uoVyYbgWF/Ncj/c4AJpfGCM
 Y51UAY8HTgGsRsxMrWjB4r8BvWPy0nN3bennM3PL6MvHCKnRLoAzZbIiaxCk7JV16l2d2QLnGZnb2
 4LgFtYv8DDfRFZ9m3ZC98/ziaMKtmx7MKUOtlnGpf/NnwFHx+udXzAHO3ZuPyF4rUvtM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlye5-0002mm-Il for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 00:47:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 022D3429C2;
 Tue, 21 Jul 2026 00:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE1B1F000E9;
 Tue, 21 Jul 2026 00:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784594850;
 bh=Qe4dxL2O/OqQk5rOLVOCDy8ZLVEizuB81/dqZgzj2ck=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fXoJK6QCD8VJuuAQVXPH2JRgJXEEHoYLDcfiWzMM/4zT63SaV61CK4wO5WaTZ03LF
 LodzRaqokD/DCOisjaN+u1rOcQiSkc3mUrzbZyyn58FluP4Sqrm/uH0Qo8Unz8elCz
 WZl9r1qAHwtCJsjKfIhJb+MKuSzSSTilrk40QeF9WLMzIctEX1vwZODPUX6QUS7qfn
 DD2z455pMccjToP8S52TatMNwdFaxoQ9hYM/REivgGFQGDGbGsWjMGJVdTLHOqIqA3
 z+YKi1edqtiCrUbm3f6h9fl45WCYwMNdsqJ8Q5x4AA1VJ+kPqx0GX41XCP/2zvQf5j
 FW3l1vAKnw2Hg==
Message-ID: <b3a3d74c-338d-422f-b2c7-84ad00a9187d@kernel.org>
Date: Tue, 21 Jul 2026 08:47:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guanghui Yang <3497809730@qq.com>
References: <tencent_FA4515CFD8902EB74708A91807AA001E3507@qq.com>
 <c9081653-4295-4605-b543-ee84000b1ba4@kernel.org>
 <tencent_2D9E7B21C16E6E10F2315454333C5E8A4D08@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_2D9E7B21C16E6E10F2315454333C5E8A4D08@qq.com>
X-Headers-End: 1wlye5-0002mm-Il
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ifolio leak in
 f2fs_move_inline_dirents
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/19/26 17:05, Guanghui Yang wrote:
> Thanks for taking a look.
> 
> f2fs_reserve_block() drops the dnode only when the inode folio was not
> provided by the caller:
> 
>          bool need_put = dn->inode_folio ? false : true;
>          ...
>          if (err || need_put)

What about err is non-zero?

>                  f2fs_put_dnode(dn);
> 
> In this path, f2fs_move_inline_dirents() passes ifolio through
> set_new_dnode(), so need_put is false and f2fs_reserve_block() keeps the
> caller-provided folio.
> 
> The caller of do_convert_inline_dir() also drops ifolio only on success:
> 
>          err = do_convert_inline_dir(dir, ifolio, inline_dentry);
>          if (!err)
>                  f2fs_folio_put(ifolio, true);
> 
> Therefore, when f2fs_reserve_block() fails, the ifolio reference still
> appears to need cleanup in f2fs_move_inline_dirents(). I kept the cleanup
> local to avoid changing f2fs_reserve_block() semantics for other callers.
> 
> Thanks,
> Guanghui
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
