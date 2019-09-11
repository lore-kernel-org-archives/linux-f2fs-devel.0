Return-Path: <SRS0=MRh2=XG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E4AC5ACAE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:21:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304252053B;
	Wed, 11 Sep 2019 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DgRoMi5W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="OMQozz3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304252053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i86Iy-0007NS-LK; Wed, 11 Sep 2019 17:21:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dsterba@suse.cz>) id 1i86Ix-0007NK-9L
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Sep 2019 17:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Hhqig6BkJ8p5uO0vcMR/jV3MKwcVc4vd2as8lb8lVY=; b=DgRoMi5Wvzy87VftTpXL20CvnK
 rEGDgYq40xGMXJ50lEwdAATCYdVjgMm1sJ4M7PXameR0WJrUXXo2KjfIY6JOkZRGdH6pXR1CvpQvx
 UwQNoZcWHalkTu4AZurq2aGGw9XXSzKBB+oAMx1dFbbQbzIUUgT8keYwsgHc1Pva3t7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5Hhqig6BkJ8p5uO0vcMR/jV3MKwcVc4vd2as8lb8lVY=; b=OMQozz3SaOCCxtM6qAr86MoBCq
 IyQKSlnpo6EaCqxCKX6ujO9O6cUbZAOwBnq1keIc8jqaEkXPeLLnwA0a684R6kdfSvA0rQGuk4GG3
 OKCxIDHWMc8v1qddaBEAQocpn/qeWRc/pf/L4hO4hA2kNYlrLADXUbJ9x2xGAOf6qmtM=;
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i86Iv-0004EB-8y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Sep 2019 17:21:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B2109AF57;
 Wed, 11 Sep 2019 17:21:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id B3C66DA7D9; Wed, 11 Sep 2019 19:21:33 +0200 (CEST)
Date: Wed, 11 Sep 2019 19:21:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <20190911172133.GJ2850@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, hch@infradead.org, andres@anarazel.de,
 david@fromorbit.com, riteshh@linux.ibm.com,
 linux-f2fs-devel@lists.sourceforge.net,
 Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190911164517.16130-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1i86Iv-0004EB-8y
Subject: Re: [f2fs-dev] [PATCH 1/3] btrfs: fix inode rwsem regression
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
Reply-To: dsterba@suse.cz
Cc: david@fromorbit.com, linux-f2fs-devel@lists.sourceforge.net,
 hch@infradead.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, andres@anarazel.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Sep 11, 2019 at 11:45:15AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our read/write methods to just do the
> trylock for the RWF_NOWAIT case.
> 
> Fixes: edf064e7c6fe ("btrfs: nowait aio support")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

The subject seems to be a bit confusing so I'll update it, otherwise
patch added to devel queue, thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
