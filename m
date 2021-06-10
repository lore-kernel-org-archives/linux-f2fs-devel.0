Return-Path: <SRS0=4l6L=LE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E1C48BDF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Jun 2021 23:09:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5920161002;
	Thu, 10 Jun 2021 23:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5920161002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lrTns-0005QP-PM; Thu, 10 Jun 2021 23:09:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1lrTnr-0005QI-NN
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 23:09:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mEX2Z26oWBg7i99/ZUCpPFP57xkDJ04cdyo0xWY7CGA=; b=YRgDjw35au6HnBG9jMVxuTCXpx
 Jt0q4NmeiAO+oR0JYLRMN8ytBWltIbrkKXRpM7ZR3iYsz/63pbv9OIZTboEURTkbdg3VAHbQtfyd9
 6pnmPIZ2TeqNQr2uvMgIRDKTSlJIgst4xrJyiDlJ/fze2RdPfaraloBw4I1xZU3jpHhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mEX2Z26oWBg7i99/ZUCpPFP57xkDJ04cdyo0xWY7CGA=; b=mAx5ajFQzib1DO7x4PmiFWH8cP
 9YrNXhuB+SuuuSlU4c6/Hc2+2n4MUlqgWujcHHz6mFfct8luNVBNbFkZUc8a70iVtC+4lLiaprJQc
 gkQkFFiYKAqEYc/eb5yMg4AF8W3EXU7G6WzeCUhxkVRGO+kb1gpWmzYRxAiBvxTfS42g=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lrTnf-0004gP-6D
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 23:09:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1FAA613D9;
 Thu, 10 Jun 2021 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623366558;
 bh=sehk7qVLTT99iBgWRG6d/XNEMQO3VwZUaO5rBbGONUc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NF4EHiwQE/k2Ptgw6ReqIxI3Y7d3D6jDUeucaY9ot/SZGYXs2GfKym469zY9y+VII
 CMrHBZTY8Hp6MOU9wG7EsYmdBBd3RL2za0ykca8OhXMrgKm3ji2Chc5z8RvaoI1mEB
 TRyd1CupfTyQAlrdCkwsAGDH0dzSsX6YuaAHApth/Hf4dvY2UD7RbpLO0C40u4JPAg
 CIeZ76IJ85ZmCdEvWkXYtT3nDko4D+9CiBsUh9mcOmgg3eFkMT20OS/81Lh9cJkx/I
 FdULipM3yAfUWjl76a3h/hl6OkQxGMAMIQ6NnMLNXoNPwe0MeP3tdZLldV160zWbK5
 ywbbfKlQsQx8Q==
Date: Thu, 10 Jun 2021 16:09:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YMKbncoLgqemjzmu@gmail.com>
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-3-jaegeuk@kernel.org>
 <YLxeynwR0v23c3sV@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLxeynwR0v23c3sV@google.com>
X-Headers-End: 1lrTnf-0004gP-6D
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: clean up
 /sys/fs/f2fs/<disk>/features
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jun 05, 2021 at 10:36:10PM -0700, Jaegeuk Kim wrote:
> Let's create /sys/fs/f2fs/<disk>/feature_list/ to meet sysfs rule.
> 
> Note that there are three feature list entries:
> 1) /sys/fs/f2fs/features
>   : shows runtime features supported by in-kernel f2fs along with Kconfig.
>     - ref. F2FS_FEATURE_RO_ATTR()
> 
> 2) /sys/fs/f2fs/$s_id/features <deprecated>
>   : shows on-disk features enabled by mkfs.f2fs, used for old kernels. This
>     won't add new feature anymore, and thus, users should check entries in 3)
>     instead of this 2).
> 
> 3) /sys/fs/f2fs/$s_id/feature_list
>   : shows on-disk features enabled by mkfs.f2fs per instance, which follows
>     sysfs entry rule where each entry should expose single value.
>     This list covers old feature list provided by 2) and beyond. Therefore,
>     please add new on-disk feature in this list only.
>     - ref. F2FS_SB_FEATURE_RO_ATTR()
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> change log from v1:
>  - adjust Eric's comment
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  29 +++-
>  fs/f2fs/f2fs.h                          |   3 +
>  fs/f2fs/sysfs.c                         | 196 ++++++++++++++++--------
>  3 files changed, 163 insertions(+), 65 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
