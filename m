Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA6C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Md4rbo8dSqJUaWDRe/xam2qtEErUUaPm6PG1CDWf3V8=; b=CqwKc7ZDpJT+glqIEoYsTaX5zo
	dx/spEnWt1WfP5697A4PfTe6TrARAjhc8S5WRx5MXh7bJdQEaLSuMpKrWsCAU5LKUP+4OuDCuWFcd
	cOuNBgeZERIauSk+z3aBWA+BsN9f7tAEy8+LOPa+8adS+8YL9d8meLWkzjLyTum/0yXA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnI6R-0006rm-Nq;
	Fri, 24 Jul 2026 15:46:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wnI6Q-0006rg-DX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:46:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jkpiNj5yYWUn9DX3khritgNaoGIvMgas1udwsxs4nsI=; b=bc1Q3xczBMcWktwPLUpSJpDn1n
 bgV9+Oe7bDiDn/orSyNjUvA6CWAdKnV5uGRpkMNfMzz2yTy5aUf8q3KaQrSrLoAGW9/uqVa4xC0sD
 4XnZybUUJjF+UHF+dOTNAkLXJ1f1m2bLb9iEafzcTRrnL/VDZRxwWulNQXG6wcUVEDcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jkpiNj5yYWUn9DX3khritgNaoGIvMgas1udwsxs4nsI=; b=StPUDR6wNr45M+7/AwJRkIgmQA
 sRDpu6w+Xw+4c/GRi5Ni6NAtPqoWHSnWCWDQ+PWIf/OwFlot7cwh1isQEMEL/fuftMFvtpPXp7Vdg
 9S+UAgY8LBH95sOlk2P7MYME+Aa0hgBTTs0u4pk6Qt8ekliZJ+kWcgrdrUDXm/fKku9Q=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnI6S-0004zL-0S for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:46:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CDF6E68D09; Fri, 24 Jul 2026 15:20:18 +0200 (CEST)
Date: Fri, 24 Jul 2026 15:20:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724132018.GF27878@lst.de>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-18-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-18-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wnI6S-0004zL-0S
Subject: Re: [f2fs-dev] [PATCH v13 17/23] xfs: remove unwritten extents
 after preallocations in fsverity metadata
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 21, 2026 at 08:40:54PM +0200, Andrey Albershteyn wrote:
> +	while (offset_fsb < end_fsb) {
> +		nimaps = 1;
> +
> +		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, 0, 0, 0, &tp);
> +		if (error)
> +			return error;
> +
> +		xfs_ilock(ip, XFS_ILOCK_EXCL);
> +		error = xfs_bmapi_read(ip, offset_fsb,
> +				end_fsb - offset_fsb, &imap, &nimaps,
> +				0);
> +		if (error)
> +			goto out_cancel;
> +
> +		if (nimaps == 0)
> +			goto out_cancel;
> +
> +		if (imap.br_state == XFS_EXT_UNWRITTEN) {

Do we also need to cancel COW fork extents here?  Should this
share code xfs_free_eofblocks by adding an end argument to that?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
