Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D500CC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IWUIKlDaqH02zwSCoy6BxNFEAq7vYUH+f9xhfbs9WFI=; b=jVG3kn0R7wZlYA935h6/SXvxhj
	zRPeJ5UenV119em46dTOA+UK9FFPrPvDl7AwaaEHeCwcopiG64nMcs20riH/WnH10fpd/F/tuGz9v
	R9daWMssOCJcBLtaTE/rYzC/dNSPamxw2rMOm++FtmBHAyrhTHtnRRnCft+w59LLxgAw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JAD-00071p-Bs;
	Fri, 04 Sep 2026 01:56:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JA2-00071d-2F
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Suo1Ecr1VzKsfn3mGXhGaibOPyeH7RYyKh+Q65B/hIc=; b=U1XFDG4DT9cUb3Px3bTUqw5ok+
 5luqSa4ufO/ybPJ8TgjrQzK74kxaJ69L8guTGJzc97kX/2Msv6QGcz2r+d46utRc/ScQrAmKrwxRg
 iRELSEGc+l+1cs7tuHzV4TNMHVG/fei2+dxXAEkJbieZaByoMhUiRqy4MdF7ubPBrSKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Suo1Ecr1VzKsfn3mGXhGaibOPyeH7RYyKh+Q65B/hIc=; b=OrYCVRR/NXFzv3uJXIg1VoMGDz
 9MvLL6GFU99DBZ1/y+m4qls6bETLR6ImIVb5FiNeaGaMkSPh+d/5d6Wr4yxcscXPK3akvirsJ6Ax1
 mbR0bzsZE3AHPBGbvtsxpHqje+vtfGbAFLHoz80Bw3khtgRgrp962zwT5nWiM96IClMU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JA2-00059Z-EA for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:56:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96C9B60A62;
 Fri,  4 Sep 2026 01:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10FD1F000E9;
 Fri,  4 Sep 2026 01:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788486964;
 bh=Suo1Ecr1VzKsfn3mGXhGaibOPyeH7RYyKh+Q65B/hIc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GrQyCcYWDgmZSb6m0HXIj1WPeg/f1R8mqKS5en+IBl3l2N3VTFLUUpXchRgNF4PG6
 S1U+v0Tct3w4bTBINPXB12z8w+U90lXN4g08DBI3rmQrZNt4pHWW29/FzNxQw9Ryx0
 B+XJXGdr5h8JKNcVkarJQncKaGyv1qJyfu85Jh/aCnArtdBQuKyW4bqhZmdZAGv5/F
 hmu4+jtU/UdfKLN3ig3MGJRaCofFgCSMBSUoMsKWGMfu79SZzl6NtZt66gYxiZ0sff
 xbvgZz6J3a2KpCjsfI/W6P4Da9a1yNajPGcyr5F5Pkld3JdT3ouA6D/LRP8ajiCNlh
 Yn5nDecf6CdUA==
Message-ID: <d0293f62-e999-4339-8bd2-b321551825b1@kernel.org>
Date: Fri, 4 Sep 2026 09:56:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <99c37e861d74328fa6203c58284dc33505d326ad.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <99c37e861d74328fa6203c58284dc33505d326ad.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JA2-00059Z-EA
Subject: Re: [f2fs-dev] [PATCH v9 04/11] f2fs: describe orphan block layout
 dynamically
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:56, Kelvin Zhang wrote:
> An on-disk orphan block contains a variable-length array of 32-bit
> inode numbers followed by a fixed footer at the end of the block. A
> compile-time whole-block structure cannot represent the footer position
> when the block size varies at runtime.
> 
> Remove struct f2fs_orphan_block, introduce
> struct f2fs_orphan_block_footer, and compute sbi->orphans_per_block
> dynamically in init_sb_info(). Add helpers to access the inode entry array
> and footer from a block buffer.
> 
> Update orphan inode recovery, checkpointing, and mount paths to use the
> parameterized helpers. This preserves the on-disk format while decoupling
> orphan handling from compile-time constants.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
