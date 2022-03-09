Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455BAC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Mar 2022 21:56:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nS4I6-0006ZP-HH; Wed, 09 Mar 2022 21:56:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nS4I5-0006ZJ-OL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Mar 2022 21:56:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mu4xF5OlOsfXioRAOjhIU2QXlQ6Mqujm7811Ofdmgfg=; b=emRKMqdy/atRom+BBgLHwZbASl
 ocxi+r/bNtbmuC17+Xv4SCvms44nT2LjosKgEQPocJKYajaWu/611ighwb8zoBJZID3S10BXRbn+u
 XFxh6KCLfQHIZtZ+XO6x9wJUCYtegoAkKvoEET9GbiVg58tr/RSzfv1Hu47r9HZJ2mHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mu4xF5OlOsfXioRAOjhIU2QXlQ6Mqujm7811Ofdmgfg=; b=kRuvOjyHeKOrOv1vxtJIXKogKB
 AIfKQhXqiDLVrlyUbwXxPfOM2R/QQszjJdg9yXXJ/lvPhIfiTwng9tNiv21dY+NDn0dJkwam+sGmS
 kPRuyjY0r993y2sT0Oa3Mi/x7qC0qB1pxkTUYj0/GOu9UemdKNUDCbKiHDfvk6p0WbAs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nS4Hz-0002Cd-PT
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Mar 2022 21:56:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A42E2B823CD;
 Wed,  9 Mar 2022 21:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0329EC340E8;
 Wed,  9 Mar 2022 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646862963;
 bh=IS54PgFpU8xs3vpDbc6IUoRHStNZV8CcU58i4EZlsVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=daT+BLOSXTPt6p40LYsGmlkC5D5hlK9QR2vfX0I8RorWfsak9UI8OQq/Eux1WtMUA
 dsCsM5BE4Ajk/I7zh1DpvLLW58HcueVHxGe+g+n7JulbijagV3XBUrVnoK7HBGl9az
 /cHwXs2B+34a+94z1kNINeScA0AICuVobXF9y1QoYBAuAlN9ea1tsTZ3FfdgIjXJs4
 EwTwp/bskdD7kuSPSL6eRaCKNGN5F/c2xXR6FE3G1/3oolSxdDf68hW5OY5tJmAJKN
 VtgmC8J1+8mkSG3G41tu403QZGHUxvgr4unlb6L+QsKJSDJgoGDpWeoASl7E+EFzFD
 VwGcS2Vgapttw==
Date: Wed, 9 Mar 2022 13:56:01 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YikiceholHfw3Vql@google.com>
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-2-hch@lst.de>
 <32114417-fd17-9412-28da-10f0ff09530d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32114417-fd17-9412-28da-10f0ff09530d@kernel.org>
X-Headers-End: 1nS4Hz-0002Cd-PT
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't pass a bio to
 f2fs_target_device
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/01, Chao Yu wrote:
> On 2022/2/28 20:41, Christoph Hellwig wrote:
> > Set the bdev at bio allocation time by changing the f2fs_target_device
> > calling conventions, so that no bio needs to be passed in.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
