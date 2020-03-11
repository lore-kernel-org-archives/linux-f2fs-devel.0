Return-Path: <SRS0=DrP0=44=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE82C10F27
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:58:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED842146E;
	Wed, 11 Mar 2020 12:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UNrIRVOb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SAspNr9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED842146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jC0vy-0002vC-4O; Wed, 11 Mar 2020 12:58:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1jC0vw-0002ut-El
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 12:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IaROnpcjebfXREevgmU63GBuXUtavi+CZTDQYlg8YYM=; b=UNrIRVObXgl7JILp+PIyn/Sfrj
 1soacRJMQtAXxBTL9d9r/FGzxgJCR2SKSrLijJ+MXFvd3nU7SfvKgbATznLc05dzuMSBDbzZ02Avq
 TegIobvc1TV+2ew/YA8QiZAiCA91QCE/3QX18xAdFDu3LOuChtz8Gz/qFhYBQmXUsxIg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IaROnpcjebfXREevgmU63GBuXUtavi+CZTDQYlg8YYM=; b=SAspNr9z49qHPU+EfsE39pXwhe
 L25Ex5foITvdAENvSXyiZh6/z4b2a+j6yJvfGb31H1SWr5/QNsithwOTiiQyoCiAmWMvjXWaPHn85
 3afEkFjSZWEbcRJsQYpTHr6sz3/U5MC5BTGpKLXRRSVaor0es7mdOpEapH6yL/49mMTo=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jC0vu-008PnU-Ck
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 12:58:00 +0000
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net
 [72.93.95.157]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02BCvnk4017660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2020 08:57:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 3D70A42045B; Wed, 11 Mar 2020 08:57:49 -0400 (EDT)
Date: Wed, 11 Mar 2020 08:57:49 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200311125749.GA7159@mit.edu>
References: <20200306004555.GB225345@gmail.com>
 <20200307020043.60118-1-tytso@mit.edu>
 <20200311032009.GC46757@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311032009.GC46757@gmail.com>
X-Headers-End: 1jC0vu-008PnU-Ck
Subject: Re: [f2fs-dev] [PATCH] writeback: avoid double-writing the inode on
 a lazytime expiration
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
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 10, 2020 at 08:20:09PM -0700, Eric Biggers wrote:
> Thanks Ted!  This fixes the fscrypt test failure.
> 
> However, are you sure this works correctly on all filesystems?  I'm not sure
> about XFS.  XFS only implements ->dirty_inode(), not ->write_inode(), and in its
> ->dirty_inode() it does:
  ...
> 		if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
> 			return;

That's true, but when the timestamps were originally modified,
dirty_inode() will be called with flag == I_DIRTY_TIME, which will
*not* be a no-op; which is to say, XFS will force the timestamps to be
updated on disk when the timestamps are first dirtied, because it
doesn't support I_DIRTY_TIME.

So I think we're fine.

					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
