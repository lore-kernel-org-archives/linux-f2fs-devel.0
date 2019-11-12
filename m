Return-Path: <SRS0=9BzI=ZE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD0FC43331
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:31:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5922084F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bhlS4RTX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RmsikCeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5922084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iUWGA-0004ml-TT; Tue, 12 Nov 2019 13:31:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1iUWG9-0004me-Qq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Nov 2019 13:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q45lDqE0wY+4WQhnFg8ocvuo/NTrvNbSyv2QAmHg1yw=; b=bhlS4RTX/SN2ejt+wLaGP92ZnG
 UkKPNX8fhFestFC8iSYhzIOUiPUQgc7haQGcZ7ofcT1QkBjR7Fgizv0QVsoaS794oxylSrT47tW64
 bHW+rNmLmCg3zigakWNdzDVVPDccBi2v51yKlBfE6Wr2tLOpShnPQfgbp6nVz9+bap5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q45lDqE0wY+4WQhnFg8ocvuo/NTrvNbSyv2QAmHg1yw=; b=RmsikCeg0x0f6txdknUZWeGCIn
 qOxCzKTh2WdYtjmwqTv86Yw1m4I/aGgD7abE6iZZY5kuULR2aN2zy6gHEOtT/pd2jo4Ro7QX2Icn8
 Jmc/L+5PlsjiC6CYIDlmJywSUNvUhu5IqcAtP+45XY97ai2JFcrtkCx6bQ4bmHJt+qfw=;
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iUWG7-00DHy3-HS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Nov 2019 13:31:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 44A94AEEE;
 Tue, 12 Nov 2019 13:30:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 462B11E4AD2; Tue, 12 Nov 2019 14:30:55 +0100 (CET)
Date: Tue, 12 Nov 2019 14:30:55 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20191112133055.GI1241@quack2.suse.cz>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-3-ira.weiny@intel.com>
 <20191112065507.GA15915@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191112065507.GA15915@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1iUWG7-00DHy3-HS
Subject: Re: [f2fs-dev] [PATCH 2/2] fs: Move swap_[de]activate to
 file_operations
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
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, Josef Bacik <josef@toxicpanda.com>,
 Anna Schumaker <anna.schumaker@netapp.com>, linux-xfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, ira.weiny@intel.com,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 11-11-19 22:55:07, Christoph Hellwig wrote:
> On Mon, Nov 11, 2019 at 04:34:52PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > swap_activate() and swap_deactivate() have nothing to do with
> > address spaces.  We want to eventually make the address space operations
> > dynamic to switch inode flags on the fly.  So to simplify this code as
> > well as properly track these operations we move these functions to the
> > file_operations vector.
> 
> What is the point?  If we switch aops for DAX vs not we might as well
> switch file operations as well, as they pretty much are entirely
> different.

Ira is trying to make switching of inodes between DAX and non-DAX mode
work. Currently, we have different address_space_operations for DAX vs
non-DAX and that makes sense because operation for address_space is vastly
different for DAX compared to page cache. But switching of aops is
difficult to do reliably so I've suggested to move functions that don't
make too much sense in aops out to simplify the picture.

Currently file_operations are the same (both on XFS and ext4) for DAX and
non-DAX case so we don't need to switch them. And although I agree that for
some operations split may make sense, I think most of the operations would
be actually the same for DAX vs non-DAX case so I don't see a point in
separating file_operations for DAX vs non-DAX case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
