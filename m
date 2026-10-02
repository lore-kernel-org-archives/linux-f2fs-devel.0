Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9150CA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 23:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGFnCtbGWKYzVod3l3aLaVqmL8eWBqkla//FqRoF9rs=; b=R2M6Fm5lAqcvRcyvE3dsm4MrEP
	ZU0b66JTNHWA65FghcWzeUXEYgjcW1efxYyz9uV1jOYMxhOIgGKs4iBzLpz9PC3CL2eb/htYQk6id
	tQNN9CVwjYxpjIN96Bmyup39+5/Rsdu9B7b7BtVl4nul5IeKY66MZTeWgFLmgRdmPVf4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCmeC-0004ke-MJ;
	Fri, 02 Oct 2026 23:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1xCmdl-0004kJ-5s
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 23:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dX8mjLok4UtQXnDkgexJ+xhshtPu80jfh72aVt20z/k=; b=ZcdfxUmGyXnbPzXpJbuitp4qS9
 j0XNHL70fq8ykvgm24jxBdAFIs1ZJvMiE8gHMs2Iq78XaitEubggcoFyrvUiYosD77LzrX30GTTn3
 nXyTdyGWFnUG4CGEIbd4C1EJJ66g+czg/8+OKAqJEDDoL8rY3fYXsgbNu6M0Vpgx15x0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dX8mjLok4UtQXnDkgexJ+xhshtPu80jfh72aVt20z/k=; b=QhccLcaQOG5jCKXJyTZ0EbK+5g
 Z3hn90gwc+e+3RN7S/OUXVfHjuCfOXEoMG6c74dEU69vsLCeTcSboecuKD8b+jVabgnNy0fi9EJxS
 93UG5LS6UZX2bgW6GaXEnUv6Q0J8tOMSJ0rJaXL0L8lH4AJK8a40NFNUZvCWWtIdilAY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCmdl-0007dh-H9 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 23:26:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3849843F04;
 Fri,  2 Oct 2026 23:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D121F000FF;
 Fri,  2 Oct 2026 23:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790983564;
 bh=dX8mjLok4UtQXnDkgexJ+xhshtPu80jfh72aVt20z/k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RnE8nbDXaHLywz+cDXAfB6ZsQGwhyS440PA8yoFOF3QYRE5zAVHnXZOmhfUeCep3u
 a4wMpj9lCDH0ZrxcsQPIxE0o41ZkBkpkKwpM1mEQXH4IX8ybRNV71uD7PHiZm/NeOQ
 w3BG7/4gB1mOS3sKLbIYVRO7GvON4tUQ1YF6IHpozPPMnv3osR6gslxP/ykpHPw7/I
 TnFD7QONTnTEuozu6MuXDf4SKbQFytR/64idEu+bZ4Ts/kmQPDx5knPcSWSOGFq80t
 2QIyXFqkkUc72IbxBIxqhkws/q2qCT8DtxyVoFh6iNeG7vlZN5Ap4EJ7hwQoUvRZ3T
 IllQEwHSChcnQ==
Date: Fri, 2 Oct 2026 16:25:42 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261002232542.GA15366@quark>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
X-Headers-End: 1xCmdl-0007dh-H9
Subject: Re: [f2fs-dev] [PATCH v17 00/21] fs-verity support for XFS with
 post EOF merkle tree
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Oct 03, 2026 at 12:36:41AM +0200, Andrey Albershteyn wrote:
> Andrey Albershteyn (19):
>   fsverity: report validation errors through fserror to fsnotify
>   fsverity: expose ensure_fsverity_info()
>   fsverity: pass digest size and hash of the all-zeroes block to ->write
>   fsverity: hoist pagecache_read from f2fs/ext4 to fsverity
>   fsverity: don't allow setting DAX file attribute on fsverity files
>   fsverity: hoist statx reporting of fs-verity flag

Would it be helpful if I applied these six patches to fsverity/for-next
for 7.4, or do you want to wait for the full series to go in at once
(presumably through the XFS tree)?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
