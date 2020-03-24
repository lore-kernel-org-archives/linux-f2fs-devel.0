Return-Path: <SRS0=nR8U=5J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5348C2BAEE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:43:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3482076E;
	Tue, 24 Mar 2020 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lwmrNa2p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mGK0hQqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3482076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGoWk-0005Oc-JR; Tue, 24 Mar 2020 18:43:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1jGoWg-0005OP-B8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 18:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w2bzsIjamKvVisM0eov33d9gRrDmGIEUJJVr/0iVlNg=; b=lwmrNa2pNrOaDQX1ayg6ZXIVG6
 wwH9Nj5BP+fB4JtMvyIcnTIr2/bla4pdsbKQcBYFBFHawhLSUif2ieiqeM14pIrw3dOv5oO+zIkcf
 ZPnu2ApsZREJCzhRYpWAmawtYULdkNl20ljQ1dwAU9uNEZiGA/bjzGkG9P5QjkPCFZ8Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w2bzsIjamKvVisM0eov33d9gRrDmGIEUJJVr/0iVlNg=; b=mGK0hQqVV1LszCuSxS+15Ay7+Q
 jYNr2h4xcN2H/+yUxd4D5/I7HohRc9A/Bj3660xMIkXIcRo9Jwt+fsCc0tOYi1IXiYKKMWSxugEow
 6do3mfFxNW6c3gl8Oj0PIhpwn8ITjqhb4+KFiaOcvIbSmGCaKfoF97pT0c3MvJ80SFQQ=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGoWd-0029dT-B9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 18:43:46 +0000
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net
 [72.93.95.157]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02OIhPC4017362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2020 14:43:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 3E068420EBA; Tue, 24 Mar 2020 14:43:25 -0400 (EDT)
Date: Tue, 24 Mar 2020 14:43:25 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20200324184325.GF53396@mit.edu>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
 <20200320025255.1705972-2-tytso@mit.edu>
 <20200323175838.GA7133@mit.edu>
 <20200324083759.GA32036@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200324083759.GA32036@infradead.org>
X-Headers-End: 1jGoWd-0029dT-B9
Subject: Re: [f2fs-dev] [PATCH 2/2] writeback,
 xfs: call dirty_inode() with I_DIRTY_TIME_EXPIRED when appropriate
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
Cc: linux-xfs@vger.kernel.org,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 24, 2020 at 01:37:59AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 23, 2020 at 01:58:38PM -0400, Theodore Y. Ts'o wrote:
> > Christoph, Dave --- does this give you the notification that you were
> > looking such that XFS could get the notification desired that it was
> > the timestamps need to be written back?
> 
> I need to look at it in more detail as it seems convoluted.  Also the
> order seems like you regress XFS in patch 1 and then fix it in patch 2?

In patch one we send I_DIRTY_SYNC as we had been doing as before.  So
I don't believe that patch #1 would regress XFS; can you confirm?

My thinking was to move ahead with patch 1 so that it fixed the bug
which Eric Biffers had reported for f2fs, but only to move forward
with patch #2 if it would be useful for XFS.

Cheers,

     	      	    	     	    - Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
