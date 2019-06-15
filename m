Return-Path: <SRS0=FOea=UO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1343C31E50
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Jun 2019 12:57:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49D121773;
	Sat, 15 Jun 2019 12:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="G46fWvr9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LU43LQCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49D121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hc8Ff-0002UQ-Rp; Sat, 15 Jun 2019 12:57:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hc8Fe-0002UH-ET
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 12:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6QcU/umXcetbwZjIIBHnh75TA30pZfdg6hUgtoFwrcA=; b=G46fWvr9Gx4cO661SRF2B9R5h4
 IQnoJAScVIh9A2k5Ev/PpxtHlfCJUjEWCKD1EqiwIDEPjOLCVOWm30X84NRva5YeTj/6fT1PWCV1f
 oFH/x2kE0Ta6a6ZKUeh0DmvTzvtARlaChAGT0VJzFy3HSoc8983JmlWgtN2o+NN7RUnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6QcU/umXcetbwZjIIBHnh75TA30pZfdg6hUgtoFwrcA=; b=LU43LQCG4w9ioeRRi+6PbTjPfn
 xqmSUg7aR8lIz8UNGFvoYOCNQ5wdGg7aOWqYQSaOqlobYEf5nPlN+iSwCZOI+O2F/PRtXnUZFObaE
 kIcVAPbrp1tMwBTLEOIHNXoatyn2HnQRTZ1Sz7iL6T2vahZSS+/gg+A6RPRWRh9ZkzkI=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hc8Fd-00EwpE-67
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 12:57:46 +0000
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com
 [74.87.88.165]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCvWOZ003473
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Jun 2019 08:57:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 0D4F8420484; Sat, 15 Jun 2019 08:57:32 -0400 (EDT)
Date: Sat, 15 Jun 2019 08:57:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190615125731.GF6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-6-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hc8Fd-00EwpE-67
Subject: Re: [f2fs-dev] [PATCH v4 05/16] fs-verity: add Kconfig and the
 helper functions for hashing
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
Message-ID: <20190615125731.4WmHekoOyTuUna88tPq2O0YvxieZSm1SvR6jvreC3v8@z>

On Thu, Jun 06, 2019 at 08:51:54AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add the beginnings of the fs/verity/ support layer, including the
> Kconfig option and various helper functions for hashing.  To start, only
> SHA-256 is supported, but other hash algorithms can easily be added.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

One thought for consideration below...


> +
> +/*
> + * Maximum depth of the Merkle tree.  Up to 64 levels are theoretically possible
> + * with a very small block size, but we'd like to limit stack usage during
> + * verification, and in practice this is plenty.  E.g., with SHA-256 and 4K
> + * blocks, a file with size UINT64_MAX bytes needs just 8 levels.
> + */
> +#define FS_VERITY_MAX_LEVELS		16

Maybe we should make FS_VERITY_MAX_LEVELS 8 for now?  This is an
implementation-level restriction, and currently we don't support any
architectures that have a page size < 4k.  We can always bump this
number up in the future if it ever becomes necessary, and limiting max
levels to 8 saves almost 100 bytes of stack space in verify_page().

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
