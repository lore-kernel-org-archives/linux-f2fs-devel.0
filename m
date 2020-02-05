Return-Path: <SRS0=KF8H=3Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCE9C35247
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:07:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FD520659;
	Wed,  5 Feb 2020 18:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="APQuXK8q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GD8sF5cJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5B5B1Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FD520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1izP5B-0003ay-Fm; Wed, 05 Feb 2020 18:07:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1izP5A-0003aj-7E
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 18:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gs10jRZHLwjIOjYVjU5UoDYIxulcXGovME2eBvzaEu0=; b=APQuXK8qqO88vlbJKjyL9a7B5K
 3U8s81eVVRCcqqHqFT+pC5P16FNRtlF81J1OABpODkpyrSP3C2CEovZncLuIeXsiJRSg9Zusqn+SA
 pgvH+TKaAeWqsv4oTnexk/sByLtrdeSppJ4HmTkX6iXZcgX5LIfy2tUNRjgwif1gh8/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gs10jRZHLwjIOjYVjU5UoDYIxulcXGovME2eBvzaEu0=; b=GD8sF5cJFBKreD0HU+I6rQa3iU
 GQoAJdqhXbx+KZ57FuMHajWFAvwFsQiKV5ESEDJa+umen53nNurbrd80bTzMECVTPqKOwsH5bBfKQ
 tZc3iWQZ1pYrvoxQ9atCtDa8v/AFwZYVLjGLBurMZXgh+DBMCmXS8LFuk5YC7PJpzyFg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1izP58-000REZ-V4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 18:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=gs10jRZHLwjIOjYVjU5UoDYIxulcXGovME2eBvzaEu0=; b=K5B5B1Wr2NgBnfmyO9DXR16gbP
 UWtIGk1NOt9+nnJLa9z8Hx9aSHXAN28QVk1+j81UZ4ps+KIX9PiL9RpepFY/llR8vFYM+VjxtlFKS
 RDOAmrCz0xLwUfEcXOpE2w90vsqxK/HjozjZTrvXiNdfa3RLhAyBfl4ZvQeuUtR45EfyP1J4NEb91
 ZQqGP8cVqKIEOApdbh+sWw7rj5D3LQJcioXoE1HLIt3g3pw4KsToRoLAKhhQafKmFFHfG7FQhSrxz
 jPx50gFpHpM6INp9TKyjx7BSF1JuGgUr03bW8xgOuoy7ti96pTjdN62goLKbranqk9g+U3q97w5jc
 i5/J1IIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1izP52-0001RS-L0; Wed, 05 Feb 2020 18:07:16 +0000
Date: Wed, 5 Feb 2020 10:07:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200205180716.GB32041@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-7-satyat@google.com>
 <20200117135808.GB5670@infradead.org>
 <20200118052720.GD3290@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200118052720.GD3290@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1izP58-000REZ-V4
Subject: Re: [f2fs-dev] [PATCH v6 6/9] scsi: ufs: Add inline encryption
 support to UFS
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
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Kim Boojin <boojin.kim@samsung.com>, Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 Satya Tangirala <satyat@google.com>, Christoph Hellwig <hch@infradead.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 17, 2020 at 09:27:20PM -0800, Eric Biggers wrote:
> On Fri, Jan 17, 2020 at 05:58:08AM -0800, Christoph Hellwig wrote:
> > On Wed, Dec 18, 2019 at 06:51:33AM -0800, Satya Tangirala wrote:
> > > Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> > > encryption additions and the keyslot manager.
> > 
> > I think this patch should be merged into the previous patch, as the
> > previous one isn't useful without wiring it up.
> > 
> 
> Satya actually did this originally but then one of the UFS maintainers requested
> the separate patches for (1) new registers, (2) ufshcd-crypto, and (3) ufshcd.c:
> https://lore.kernel.org/linux-block/SN6PR04MB49259F70346E2055C9E0F401FC310@SN6PR04MB4925.namprd04.prod.outlook.com/
> 
> So, he's not going to be able to make everyone happy :-)
> 
> I personally would be fine with either way.

Oh well, the split between adding functions and callers is highly
unusual for Linux development.  Adding the defines I can see,
especially if they are large (which these aren't).  But you'll need
to get this accepted by the UFS folks, so I'll shut up now.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
