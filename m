Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1F110FCAE6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJLVSIHw/KpTUKn7dHYolEJXhQp2RxxpMiq2pcbGY6U=; b=TGfDbe2NKUg8BoFeA/0vdGddMk
	j2lo7avKD85JVNg+bvr3O1cRKs+ShXWIjIujA6LVaFBDYxJrYFRL+DKyIDh2Qr8AtYggoB1G0lyjw
	4OuQiwH3smk+zKuhw2tDKTCdzZF2lQV0FEpEW/V468624ZaIdOez2LP8bKE0qG9SdJFA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w82y4-0005iA-N1;
	Wed, 01 Apr 2026 21:19:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1w82y3-0005i2-Hg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 21:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DV65+fK+aTlygf1u1TAw1mumFxNjza5Cu2q1OKV9vVY=; b=WBOOFHOCvXnafSIRvs2/3/s0m6
 tlvGvuUEzHjMUXe6lnuZQWGOMLTMp9ne+lrdZh22d1w0ckc1frsb8+NxuVJ+YUQpAVBRoVgEjIFXR
 FXlnT+lYx1YVcll221o96++L48SkpRjX5RjkYLzonKlhatGdv/avnwGkoiJAmQc0Y7sg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DV65+fK+aTlygf1u1TAw1mumFxNjza5Cu2q1OKV9vVY=; b=K4+p6ljwQVBuBMGQUfg0nejoK2
 JEGiE97VzrPCUrUh8Px345P0xSVoVJwsvhbhPSAOhiHaCEWBwmsBOFM/KPQfzT8RM0eh4rTXX+F7W
 f8DyncO/oNZemYvHgXMxrZ8cwNuOxfWy5JurYtAvwXTgCL9K7VsqUjWVZEp1UPcu9lOI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w82y3-0000PL-3l for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 21:19:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 37583600CB;
 Wed,  1 Apr 2026 21:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E56C4CEF7;
 Wed,  1 Apr 2026 21:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775078343;
 bh=ZUftJy/Eg2vooutQH6w/+XirdMYySx6JVlXp754Vgdk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jD3Jb1tyAXHJ7rlEQVgRfpLV2q36bVM+ZajV5KTZtkYLuqlKdfLGdjCpcy0YnRnbi
 LoLgBIqHi+42FatuccDnBFDivdoaKpF07bf+PUeofoud0KB0kILvHTwfnNr+wV1Aa6
 ojA8OH7ghnBr07KKD5W+MJmxN0ig7il2HpVBOqc3Si1yz5HvBAiqiaYP7rfDfiQXz5
 gvCbKx8DnrxuEsyb7EO6QrlJeDeTqifD0tfUem+skhvVcglnV+FvF/Xw4hsMFllqjZ
 y+d3meadPcE1/VqbKbjkdKbo9sj1+GwnPXFD2uG1NnYG5a8cUTLgXieYD+hkSeKO8n
 ECkQRhTDfjUOA==
Date: Wed, 1 Apr 2026 14:19:01 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401211901.GF2466@quark>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-2-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-2-aalbersh@kernel.org>
X-Headers-End: 1w82y3-0000PL-3l
Subject: Re: [f2fs-dev] [PATCH v6 01/22] fsverity: report validation errors
 through fserror to fsnotify
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
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 31, 2026 at 11:28:02PM +0200, Andrey Albershteyn wrote:
> Reported verification errors to fsnotify through recently added fserror
> interface.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/verity/verify.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Eric Biggers <ebiggers@kernel.org>

>  		if (memchr_inv(dblock->data, 0, params->block_size)) {
> +			fserror_report_data_lost(inode, data_pos,
> +						 params->block_size, GFP_NOFS);
>  			fsverity_err(inode,
>  				     "FILE CORRUPTED!  Data past EOF is not zeroed");
>  			return false;
> @@ -312,6 +315,7 @@ static bool verify_data_block(struct fsverity_info *vi,
>  		data_pos, level - 1, params->hash_alg->name, hsize, want_hash,
>  		params->hash_alg->name, hsize,
>  		level == 0 ? dblock->real_hash : real_hash);
> +	fserror_report_data_lost(inode, data_pos, params->block_size, GFP_NOFS);

The first case does the fserror call first and the log message second,
and the second case does them in the opposite order.  I don't think it
matters what the order is, but they should be consistent.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
