Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37902C6FD19
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Mar 2023 22:24:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1palA1-0000zT-0b;
	Fri, 10 Mar 2023 22:24:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pal9z-0000zL-Vb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 22:24:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D7KvrHTPJDNIaa0Ntg5hjCTRCBuRSV1MmVoG0tDBYYc=; b=gC/0df8bGGrNxSh59Wi4YaajwM
 wA4Va3V3tJrzt2zjZ2LMEIfm8TWP1q3QEmsCDwZFZ38aQGFxKnop4UGRvpjoPIwBkay/6zwYhG+1L
 Iw20YWV09BlQ/wMoE5U1yB4t2kV8AGE6+2JquNnoNoxUrqVKguOUbBN7G45pGhR4aJJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D7KvrHTPJDNIaa0Ntg5hjCTRCBuRSV1MmVoG0tDBYYc=; b=IdJ/wF2dcgspLm4//R/F2//+1h
 Y/f/bbr6oZBjGKcVYB/PRKLILSYQtK4WNfqtob7kt8e+bgatanT2ZU/YQM8UI1HYWqch14kzABd2L
 rC/3B0qZYhpjnF5TzeAK3BnsN/oR+EuqY43zhB7dX0nomADZDCP6P5t6ZPBGkgWk889U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pal9y-0002ao-JS for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 22:24:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4A21F61D77
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Mar 2023 22:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922FCC433EF;
 Fri, 10 Mar 2023 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678487055;
 bh=wBO740t5o2nLe95wsJDHfzac2ScEyqV1MZTnvh/dt6o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k8X09bZ7g198jG6S9p1oZpJGrTKXtfdis3jvTm5HAOnPdpgHant54IaogMeLKglUz
 ZwON7utGZoKk8Q7ZsSFDcvzkPEh9vL9vQte3Bm9iiGfSLYQ5H8LdlqfhRNKxPPLOQ3
 ttF8wpP5vEgiLmFrLjbSZPz/rNRSz6NIL6hWp9F1v9qSnf4F8qsCAdusBGFRHy44gZ
 joUTFP3nVpdW094RVDw79nU6n2DmTr9sBAh0qjnUTMek6jXLtZ8sRTXwFYd6v2/Qxl
 SkXb6l4YJTRebzRLzJD7ok+0RoEroGoNH15xAhesL21iH81MBR/mDOMIK4yvyjoblo
 kU3gm10j3cyQQ==
Date: Fri, 10 Mar 2023 14:24:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ZAuuDkwBgcJ6dBul@sol.localdomain>
References: <20230310210454.2350881-1-jaegeuk@kernel.org>
 <20230310210454.2350881-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230310210454.2350881-2-jaegeuk@kernel.org>
X-Headers-End: 1pal9y-0002ao-JS
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: factor out discard_cmd usage from
 general rb_tree use
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Mar 10, 2023 at 01:04:53PM -0800, Jaegeuk Kim wrote:
> +static bool f2fs_check_discard_tree(struct f2fs_sb_info *sbi)
> +{
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct rb_node *cur = rb_first_cached(&dcc->root), *next;
> +	struct discard_cmd *cur_dc, *next_dc;
> +
> +	if (!cur)
> +		return true;
> +
> +	while (cur) {

The !cur check is redundant here.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
