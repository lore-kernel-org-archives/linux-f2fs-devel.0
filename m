Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580CDC25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 May 2024 17:47:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sACWs-0000WL-4i;
	Thu, 23 May 2024 17:47:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sACWq-0000W5-Ta
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 May 2024 17:47:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ofdG6cOVDKe4iEDRHwUavXfAIoDD1FxExt3AvIo2pWg=; b=K3gq9FfndFrJqXGH1wzip8y+/4
 DfR+teCkb1tNRsIcc2x8ZLj9LuevqxUU3SlVRb4mfLKmksAfmTA3m2eqFHj/sh9EKUNEpG1BT+ub/
 z/75P88rntsRNJuFp0VlZjqO7gMnK5ja3MfKuqNN0WP8SQce7Lg9raIPhAAVA2yAhBgs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ofdG6cOVDKe4iEDRHwUavXfAIoDD1FxExt3AvIo2pWg=; b=g/ION7u98kVifzZmSNRDAQmi2z
 q/RDEs0aTpw1e0ht9JMcb1ih0NOiUny627Uk4Nlgrj07+HTck2JHyif6G6thBnMeTNqJagri1f+eG
 LfpwnqWyi8ehLf2jkY+h8PxBLtsNq+HiTMQreFDS6R2B1SoItfvWgRATw+MBYJnV7fN4=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sACWr-00008l-VY for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 May 2024 17:47:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6C8B7CE1787;
 Thu, 23 May 2024 17:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F62C2BD10;
 Thu, 23 May 2024 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716486408;
 bh=axKpqX7OyxRRCvS63G23idJ5DSe9uwY6YtfBQyk6UXA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DfhrwL6ZYr2U/k2cV+uJ6FlfSvGKBfOf0QHmX7Uh1/WxB7a4o1beGBVbtyGEcddmo
 lkd2WcjSoHpRY98KL1OAR+5deYjV7PsEZOmY32ggScgVlHWq0ZFsv6lBod0UPBxYKI
 JmfEZC7nZDLFjv4YZNA2ZDVQuaHvaVzI4hfbtmZZtzVvK+HLh99JtbBS6CKHP4GVcu
 jelCq+4jj1yVOwNfk+SVQ5r5Vegh1o1Vee9IqoC/jTDq9J9hG5+wtzc0qUE6Pk08yU
 ewf3q6EYDvI29IY1fPJ6PHGKJey5iRXtLtnfXX18mDk+tyYSdSyr4ET1MsUgyriYig
 O3u/oYmDqFymw==
Date: Thu, 23 May 2024 17:46:46 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <Zk-BBpChhBi1J4PC@google.com>
References: <20240520220208.1596727-1-jaegeuk@kernel.org>
 <Zk-AilUqViUaLj8b@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zk-AilUqViUaLj8b@google.com>
X-Headers-End: 1sACWr-00008l-VY
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix false alarm on invalid block
 address
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
Cc: stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Fixed the stable mailing list.

On 05/23, Jaegeuk Kim wrote:
> Hi Greg,
> 
> Could you please consider to cherry-pick this patch in stable-6.9, since
> there are many users suffering from unnecessary fsck runs during boot?
> 
> You can get this from Linus's tree by
> (b864ddb57eb0 "f2fs: fix false alarm on invalid block address")
> 
> Thanks,
> 
> On 05/20, Jaegeuk Kim wrote:
> > f2fs_ra_meta_pages can try to read ahead on invalid block address which is
> > not the corruption case.
> > 
> > Cc: <stable@kernel.org> # v6.9+
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218770
> > Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
> > Reviewed-by: Chao Yu <chao@kernel.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 5d05a413f451..55d444bec5c0 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >  		break;
> >  	case META_SIT:
> >  		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case META_SSA:
> >  		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
> >  			blkaddr < SM_I(sbi)->ssa_blkaddr))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case META_CP:
> >  		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
> >  			blkaddr < __start_cp_addr(sbi)))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case META_POR:
> >  		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
> >  			blkaddr < MAIN_BLKADDR(sbi)))
> > -			goto err;
> > +			goto check_only;
> >  		break;
> >  	case DATA_GENERIC:
> >  	case DATA_GENERIC_ENHANCE:
> > @@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >  	return true;
> >  err:
> >  	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +check_only:
> >  	return false;
> >  }
> >  
> > -- 
> > 2.45.0.rc1.225.g2a3ae87e7f-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
