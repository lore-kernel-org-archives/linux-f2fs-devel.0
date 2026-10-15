Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB52CC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBMwgc9AYQvAmQ0obj/mRkn/UQBGR1xkYcPO55cnfLs=; b=afYb0L4G+qGRjDoEAckuJNOWcg
	cNVorBJYtgr+DsuDuF5dJeECuCZ7CUAzaj50zcMTflihfa0lKi2lL15VO/ByJTWIIz1EyuwW+8jQf
	1VdNO9iNE2LqGrOwx+iZIp08NLVOX/u9uaDwwooFoblw6/LPb2rBSVKEoleEVJc4xiq0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHT00-0008Lf-32;
	Thu, 15 Oct 2026 21:28:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xHSzd-0008LK-L9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 21:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CBX12mfxHYqQEqStDh3U2qMU78nlJwFaHC1h8Enx6xY=; b=VI3VobM+cI3Vynqc+6wSgC4yCS
 5LyWqGjFAh5u5WdbYASY6iFx41OTybO3I7YJaKcKRyxKXFiRwAQ0FjwoeMs3hTGecLFQbdZlD/WAa
 xRl+1K/FHiuJqEymcYxLswbB1bpDtuu42x33yklAfNjI+lPpmCb8xzqyyEMrFsZR7l9k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CBX12mfxHYqQEqStDh3U2qMU78nlJwFaHC1h8Enx6xY=; b=RE15/eBbRkPpikdFf+XpTaISwE
 miji19hPRMDxR03NG6mMEz5zCaKNQnWngrbMgvqU8G5LN6hL/FIaA6i0S9srcqrw28vI+pLSE0CF0
 zCg+1OdMCSIKY2rltCGlhXv89vtC7URHSXijQ56hIA6nQE1rgUAjfcwVBZFqxumexJwI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHSzc-0001aF-QE for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 21:28:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5872541453;
 Thu, 15 Oct 2026 21:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B551F000C4;
 Thu, 15 Oct 2026 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792099679;
 bh=CBX12mfxHYqQEqStDh3U2qMU78nlJwFaHC1h8Enx6xY=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=USr1GujDOF9Rat+IHKcsJolXVpE8gR74onlp6dyPUQhFzivEqWbA2q/Knw5nSWTDU
 eE3o7fOoHHkHnyURZtXDLzXpsr09F5YcnNiIV0B5QJm/YBv9BAHWezv2Ym22H977A3
 qINqWAOl+FxQ5lO1pLOnUibRQwTCLDlxSR3sbIttnMbQfWO4xftWjFVlpx38VUPh64
 ddbEpa7XFgPHLgJuW2HKO/V3a+J7x8eFnAVYShuUubL0y95FSTdZ+1ZkTc/YQ1aBxp
 8uRSXb23DaN2mO8ONKuRgvhVZDX7K4WXnCqP658vniytvI5D5N+8Fe5VeFnsmHXZb9
 /XqcDIkSpKjzQ==
Date: Thu, 15 Oct 2026 21:27:57 +0000
To: Nanzhe Zhao <nzzhao@126.com>, Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net
Message-ID: <atFFXafuVyyimmUk@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
 <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
 <atD9Csw1-lj5_SR_@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atD9Csw1-lj5_SR_@google.com>
X-Headers-End: 1xHSzc-0001aF-QE
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/15, Jaegeuk Kim via Linux-f2fs-devel wrote:
> On 10/15, Nanzhe Zhao wrote:
> > 
> > Hi Jaeguk:
> > 
> > >Ok, this comes when applying "f2fs: carry subpage offset and count in write IO".
> > >
> > 
> > So we didn't reproduce this bug with the whole series patched on dev-test?
> 
> I hit this after applying the entire patch set. Then, tried to bisect and got an
> issue with that patch in the first round.

Ok, the issue was different when bisecting the patches. After applying the below
change that Chao pointed out, I can continue to bisect. Let's see.

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1560,6 +1560,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
                        .op_flags = REQ_SYNC,
                        .old_blkaddr = NULL_ADDR,
                        .folio = folio,
+                       .folio_blkcnt = 1,
                        .encrypted_page = NULL,
                        .need_lock = LOCK_REQ,
                        .io_type = FS_GC_DATA_IO,

> 
> > 
> > Thanks,
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
