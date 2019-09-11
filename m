Return-Path: <SRS0=MRh2=XG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B6ECDE20
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:45:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C065C20838;
	Wed, 11 Sep 2019 16:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MfUOYMRl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Qnmt4Bao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C065C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i85kN-0007wi-Lw; Wed, 11 Sep 2019 16:45:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rgoldwyn@suse.de>) id 1i85kL-0007wU-Mh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Sep 2019 16:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BzvFRCU9Noapa7DSzP2levHpmPRmxOIQhOYcKQDvUf8=; b=MfUOYMRlwSJsoahiEjVCBODTlr
 wiDyjBzc6/dlXDNG+2HkoOa2mdooVhUuKXGAlXO4xkkJ2IAjg19Pdt3/mh+7t00uM2J7MOiMpbfko
 d8uBwIyX1eqPQiI0J676/pKWCh7yZHoKjNWattw48cT3baVfEdChIinDBn+GyMtEmBtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BzvFRCU9Noapa7DSzP2levHpmPRmxOIQhOYcKQDvUf8=; b=Qnmt4BaoVfQ3/HEMKKV9gmGh4b
 GuIHypwWEQV6vH7S3jnBN/lPrBomnd9pjaVx1dHZbOJGN/jpm6K2C/AJxRm5oPI4333TroTD+xghf
 /xYy05GZ92fbDEGeyG4ulPrMKYJIctbrEE9UPhmR9q+ehBTEo4JjB7Eu6h4lNSPOdoAA=;
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i85kJ-00026M-MR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Sep 2019 16:45:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9FA22AF81;
 Wed, 11 Sep 2019 16:45:24 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-fsdevel@vger.kernel.org
Date: Wed, 11 Sep 2019 11:45:14 -0500
Message-Id: <20190911164517.16130-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
X-Headers-End: 1i85kJ-00026M-MR
Subject: [f2fs-dev] Fix inode sem regression for nowait
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
Cc: david@fromorbit.com, linux-f2fs-devel@lists.sourceforge.net,
 hch@infradead.org, linux-ext4@vger.kernel.org, andres@anarazel.de,
 linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This changes the way we acquire the inode semaphore when
the I/O is marked with IOCB_NOWAIT. The regression was discovered
in AIM7 and later by Andres in ext4. This has been fixed in
XFS by 942491c9e6d6 ("xfs: fix AIM7 regression")

I realized f2fs and btrfs also have the same code and need to
be updated.

Regards,

-- 
Goldwyn



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
