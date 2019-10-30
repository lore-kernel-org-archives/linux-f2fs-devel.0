Return-Path: <SRS0=bQz1=YX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48662CA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F5920874
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LG/1Ny8e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IzINmE3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F5920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iPpgm-00070O-DQ; Wed, 30 Oct 2019 15:15:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1iPpgk-0006zw-J1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Oct 2019 15:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aguS72LZou1XoIz14PFGtqUpbHgxgvkO0/qCIwRIgQs=; b=LG/1Ny8eaTv7KEt5yo7YoSXyRW
 +a+GTYWZRQvNoDrkU8sWEdLHK77j+VBrf4Te/ItPegwXVoSWtrw3sVSV7cyIR0kZX5ugPOP3o+6u9
 uU5gck7Br+5tVwL9vjQbdgvP2XNHF0pq1954D3bPAy8212jL+VZZiiiVGvxw4kb9qWJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aguS72LZou1XoIz14PFGtqUpbHgxgvkO0/qCIwRIgQs=; b=IzINmE3IqLEvRSzerR88b9783n
 q6o3XxOvQGfUZNPIUkIA2ru8cFDFZg3IJ1u5Nm3iLPRm1DLt78NTZDg2IUc96dubmv3Y+F/A7Nb3D
 +BecmUwrJ7sK1SIAbDCwDf/EjHnf/v0DWA/TGqhTqdjzdNMSnEFowAIwihXu2F8nZlfM=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iPpgi-00Ayxe-E1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Oct 2019 15:15:10 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com
 [104.133.0.98] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9UFEjKE010180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Oct 2019 11:14:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 16ABD420456; Wed, 30 Oct 2019 11:14:45 -0400 (EDT)
Date: Wed, 30 Oct 2019 11:14:45 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <20191030151444.GC16197@mit.edu>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030104345.GB170703@architecture4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1iPpgi-00Ayxe-E1
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
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
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Oct 30, 2019 at 06:43:45PM +0800, Gao Xiang wrote:
> > You're right, in low memory scenario, allocation with bioset will be faster, as
> > you mentioned offline, maybe we can add/use a priviate bioset like btrfs did
> > rather than using global one, however, we'd better check how deadlock happen
> > with a bioset mempool first ...
> 
> Okay, hope to get hints from Jaegeuk and redo this patch then...

It's not at all clear to me that using a private bioset is a good idea
for f2fs.  That just means you're allocating a separate chunk of
memory just for f2fs, as opposed to using the global pool.  That's an
additional chunk of non-swapable kernel memory that's not going to be
available, in *addition* to the global mempool.  

Also, who else would you be contending for space with the global
mempool?  It's not like an mobile handset is going to have other users
of the global bio mempool.

On a low-end mobile handset, memory is at a premium, so wasting memory
to no good effect isn't going to be a great idea.

Regards,

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
