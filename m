Return-Path: <SRS0=cRzz=GL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602C6C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Jan 2021 09:15:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB552226A;
	Fri,  8 Jan 2021 09:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB552226A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kxnru-0007RT-5X; Fri, 08 Jan 2021 09:15:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hch@lst.de>) id 1kxnrt-0007R5-Fa
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jan 2021 09:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X91a4aVULhhzA/VtTyy8IFUIgJ78zRrgM0zcjEXqpxs=; b=VNALFFLcy9OqQItJwc63ful1+C
 16qpbkpM5+6SyK6xmUj/Sa92ndJE11FolTLJZTYdRzJ3BcNRrHseK7syj0p9N5i7PZXAH7YtK/ZEP
 onDHAZ+tJZqKvN1tWWL9QET+edLhgkWNrkmFxSwddMPmtLEgCmP626dOLUkAOPz4BfQM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X91a4aVULhhzA/VtTyy8IFUIgJ78zRrgM0zcjEXqpxs=; b=kFuLKJvjrLzC6Zd/AXQSQx7ODN
 OrpGTFVwymuuLejUyfykEMSiEQMre1XBkW90DJAxuZ7FwiQiD18E9WDZYQgOFH9WA7gbplCl9kelh
 7odxSQIdPNZMNFPoKf4wwA6//pA8tpJLnQTqUFTyIPnqP9gONhwcSjFXIKfI4DEZYIzM=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kxnrn-00Gqil-NB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jan 2021 09:15:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C5B1468AFE; Fri,  8 Jan 2021 10:15:24 +0100 (CET)
Date: Fri, 8 Jan 2021 10:15:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20210108091522.GD2587@lst.de>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-13-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-13-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1kxnrn-00Gqil-NB
Subject: Re: [f2fs-dev] [PATCH 12/13] xfs: remove a stale comment from
 xfs_file_aio_write_checks()
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 04, 2021 at 04:54:51PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The comment in xfs_file_aio_write_checks() about calling file_modified()
> after dropping the ilock doesn't make sense, because the code that
> unconditionally acquires and drops the ilock was removed by
> commit 467f78992a07 ("xfs: reduce ilock hold times in
> xfs_file_aio_write_checks").
> 
> Remove this outdated comment.

Yes, this looks good, I actually have the removal included in a WIP
patch as well, but splitting it out like this look good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
