Return-Path: <SRS0=r/0U=WQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57B7C3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:26:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD0722CE3;
	Tue, 20 Aug 2019 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZOPvedcu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RV3C2/7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD0722CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i06xz-0001gb-3z; Tue, 20 Aug 2019 16:26:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1i06xy-0001gV-1j
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Aug 2019 16:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MxpgqBlkGsPEFu7E0Q+br0lmLT20x//jciUURbiyUfM=; b=ZOPvedcu8FNdWv3/YmUGQf10Pz
 DuYlhVcpa+Q+hEzH5gV9AD5kMgGGmlrZxWg4yE2DBVnqyrQW8sZlyYciM3ZVJYiYINm8TBDACl8d9
 zgoqUDYdknm/EW96Se/8Btb0nn/aeGaxOFNEasRPQ3RoPD8I66gk2DuExf6Hp0XT6H+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MxpgqBlkGsPEFu7E0Q+br0lmLT20x//jciUURbiyUfM=; b=RV3C2/7y43swiOD6+i8v6DMSye
 NbD3UQuGDSt7KMN5zu664x3v1pnFVvIa5seQKOhALduasNO5I+HDgmqL/4YWEuxd3U9VV9abSbQEV
 io3iEJD8KlC6GNjZJeE3pkusEvUfnvIs8hhggBCHaB78hKCQcgc+fNL4Po3MFBX6QYHs=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i06xw-00DU7R-0N
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Aug 2019 16:26:37 +0000
Received: from callcc.thunk.org (wsip-184-188-36-2.sd.sd.cox.net
 [184.188.36.2]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7KGPBGs030830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Aug 2019 12:25:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id B3927420843; Tue, 20 Aug 2019 12:25:10 -0400 (EDT)
Date: Tue, 20 Aug 2019 12:25:10 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <20190820162510.GC10232@mit.edu>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <1652707.8YmLLlegLt@localhost.localdomain>
 <20190820051236.GE159846@architecture4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190820051236.GE159846@architecture4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1i06xw-00DU7R-0N
Subject: Re: [f2fs-dev] [PATCH V4 5/8] f2fs: Use read_callbacks for
 decrypting file data
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
Cc: hch@infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
 Chandan Rajendra <chandan@linux.ibm.com>, adilger.kernel@dilger.ca,
 chandanrmail@gmail.com, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 20, 2019 at 01:12:36PM +0800, Gao Xiang wrote:
> Add a word, I have some little concern about post read procession order
> a bit as I mentioned before, because I'd like to move common EROFS
> decompression code out in the future as well for other fses to use
> after we think it's mature enough.
> 
> It seems the current code mainly addresses eliminating duplicated code,
> therefore I have no idea about that...

Actually, we should chat.  I was actually thinking about "borrowing"
code from erofs to provide ext4-specific compression.  I was really
impressed with the efficiency goals in the erofs design[1] when I
reviewed the Usenix ATC paper, and as the saying goes, the best
artists know how to steal from the best.  :-)

[1] https://www.usenix.org/conference/atc19/presentation/gao

My original specific thinking was to do code reuse by copy and paste,
simply because it was simpler, and I have limited time to work on it.
But if you are interested in making the erofs pipeline reusable by
other file systems, and have the time to do the necessary code
refactoring, I'd love to work with you on that.

It should be noted that the f2fs developers have been working on their
own compression scheme that was going to be f2fs-specific, unlike the
file system generic approach used with fsverity and fscrypt.

My expectation is that we will need to modify the read pipeling code
to support compression.  That's true whether we are looking at the
existing file system-specific code used by ext4 and f2fs or in some
combined work such as what Chandan has proposed.

Cheers,

					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
