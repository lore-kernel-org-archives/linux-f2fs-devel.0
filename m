Return-Path: <SRS0=41bR=VE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026B2C48BDB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Jul 2019 18:54:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8D420684;
	Sun,  7 Jul 2019 18:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jy3gFG+E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fF3qVLhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8D420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hkCIn-0003lS-ER; Sun, 07 Jul 2019 18:54:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hkCIl-0003lK-Nm
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Jul 2019 18:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uEOVYhonbLU86WIV8IuYG31sgO3qVnrdBrMU8JfIK+c=; b=jy3gFG+E9OaBjO8dTmdp4OuMy0
 Itzo/UYQOIXvROL+VK6U2BcEeud36ShfLUacoljjYWw0ztuiCiwIt/acpmaMhDyoUQpnhNj6vKegj
 1G+jleffGaNpmSNSJLE01dscMMrU1xyUjwOTDo+hpPtyGALVnmKcE2zwaiIQHE0BEZDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uEOVYhonbLU86WIV8IuYG31sgO3qVnrdBrMU8JfIK+c=; b=fF3qVLhMDSwEQB3DJewEVDjS+g
 zatuZeQtB62Kb2kCMXC5vQYrd4l92I3VdRNUdrQ7zQuFRl66DOe/CYDy1GI3EWdILDQ1vkKvaJw0o
 m3Sch9cN0XVXECTBZFGHy70ffZpe+GRW7cFveOI4Q6neh5gO4/blNX+42FGklc91lveU=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hkCJ6-009K6P-28
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Jul 2019 18:54:41 +0000
Received: from callcc.thunk.org (75-104-86-74.mobility.exede.net
 [75.104.86.74] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x67IsJgr016282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 7 Jul 2019 14:54:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 7EC8C42002E; Sun,  7 Jul 2019 14:54:18 -0400 (EDT)
Date: Sun, 7 Jul 2019 14:54:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190707185418.GD19775@mit.edu>
References: <20190701153237.1777-1-ebiggers@kernel.org>
 <20190701153237.1777-16-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190701153237.1777-16-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hkCJ6-009K6P-28
Subject: Re: [f2fs-dev] [PATCH v6 15/17] ext4: add fs-verity read support
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
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-integrity@vger.kernel.org,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 01, 2019 at 08:32:35AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make ext4_mpage_readpages() verify data as it is read from fs-verity
> files, using the helper functions from fs/verity/.
> 
> To support both encryption and verity simultaneously, this required
> refactoring the decryption workflow into a generic "post-read
> processing" workflow which can do decryption, verification, or both.
> 
> The case where the ext4 block size is not equal to the PAGE_SIZE is not
> supported yet, since in that case ext4_mpage_readpages() sometimes falls
> back to block_read_full_page(), which does not support fs-verity yet.
> 
> Co-developed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good.  Since there's a S-o-B, some might claim that a
Reviewed-by: is not necessary, but to the extent that you modified
this code as well:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

							- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
