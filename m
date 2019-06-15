Return-Path: <SRS0=FOea=UO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2CC31E50
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Jun 2019 14:48:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA6D2183F;
	Sat, 15 Jun 2019 14:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PVXkVtFy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="E2fKg76x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA6D2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hc9yz-0007D2-8X; Sat, 15 Jun 2019 14:48:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hc9yy-0007Cv-1E
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 14:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dmstTLR6XeaDCrdKMNj+3B+mTlrc80R3jf4Rtw69uYY=; b=PVXkVtFyX0ZLixR03o1HPVT6u+
 nhL23UuO40lIiNEHue0vKVkyS9sqhXk9tYCJ3vBVu5k5KnB7K3ypm7vN6oVenfqVq8b7HjRAOJ9Dx
 itvaoOd/UNy6yI32tXWWhItRgnpGIIb69dNMNfQ6ARYSvVAhDy5G2EBXld+o45ErvY0U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dmstTLR6XeaDCrdKMNj+3B+mTlrc80R3jf4Rtw69uYY=; b=E2fKg76xyY1NS1a2+UCfwLK95b
 d6a9kkPZY67shzEkkLC/+XUQXnEVNDLqkGL1B2XashLyQNz97JV2ByQenvPrz5gXWdaDyCVI2Xc5x
 D1wwi/QvbqTfn/0yQnEtbfM/PvMYRgmkhOeRtkQ7SBpP7czTFxoH5t6mDO8ziHp06G3M=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hc9yw-00F67c-DF
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 14:48:40 +0000
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com
 [74.87.88.165]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FEmOLp000697
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Jun 2019 10:48:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 5E1F9420484; Sat, 15 Jun 2019 10:48:24 -0400 (EDT)
Date: Sat, 15 Jun 2019 10:48:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190615144824.GJ6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-10-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-10-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hc9yw-00F67c-DF
Subject: Re: [f2fs-dev] [PATCH v4 09/16] fs-verity: add data verification
 hooks for ->readpages()
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190615144824.oIIrd7bkKN4Wh4T2ZqBzrcDB2LeAznAi4K8y89PV0t4@z>

On Thu, Jun 06, 2019 at 08:51:58AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add functions that verify data pages that have been read from a
> fs-verity file, against that file's Merkle tree.  These will be called
> from filesystems' ->readpage() and ->readpages() methods.
> 
> Since data verification can block, a workqueue is provided for these
> methods to enqueue verification work from their bio completion callback.
> 
> See the "Verifying data" section of
> Documentation/filesystems/fsverity.rst for more information.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
