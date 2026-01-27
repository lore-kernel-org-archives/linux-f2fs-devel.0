Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E94BD2594E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9fQDdS9Rddufblbv0FrIXRj7RDMkFVC1yLubORElsNU=; b=mqBofAeGP8GT1v+ZbFN8G6PiVh
	E8QXyp5HzxUIzv0n7SgUuDTP9yAtrbRp0M9d2VEjp/hSTIqZwvgog3tlFJ+bBvwYq/z4MjjxrbsJ8
	fjZudlDUDpPQZ6JiEvm6bTUvqHV2CdbTV2w23vYAaemkcPHIlr+nn4YwneErS8CN1veU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkciU-0007ii-5T;
	Tue, 27 Jan 2026 06:38:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkciT-0007ic-Kk
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 06:38:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u46RhyT0aa21njT4KXqVtfwt9bRAHYR3FkzCPbPMXes=; b=MsMvmQaNE0cTp++r+pnWn0L7nC
 cYWvWsvL3YU9OlPtMfKSSFqrgntK/bfWpoVXPruPBQRX+LlGvqNIaZPXpr1BS0F5tW4/QQ06YA4CS
 +VfmOCkr/+PaxNEhLAO7TwWlHg2Iz00fi/fYSmthd2B6Jsxr7dXT9UhZ9DD7Aogwe3uw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u46RhyT0aa21njT4KXqVtfwt9bRAHYR3FkzCPbPMXes=; b=fGont/rlj7twb6f57+qcqrwd7I
 bSSqAweNerrJAFVsn1PejCm7UbbKqHk52s47svzD/SUIIiFX+w+6nmA+tajCMHlxBGeBwk+UWMJ3X
 2Ru1JMfUbY91H9OZzCRD7W7pFePbH8uj97bWpCUJF+bylU6Zd93HBVwsGLzLxo7r6saY=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkciT-0002e4-6P for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 06:38:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5F0EC227AAE; Tue, 27 Jan 2026 07:38:09 +0100 (CET)
Date: Tue, 27 Jan 2026 07:38:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260127063809.GB25894@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-8-hch@lst.de> <20260126191102.GO5910@frogsfrogsfrogs>
 <20260126205301.GD30838@quark> <20260127060039.GA25321@lst.de>
 <20260127062055.GA90735@sol> <20260127062849.GX5966@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260127062849.GX5966@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkciT-0002e4-6P
Subject: Re: [f2fs-dev] [PATCH 07/16] fsverity: don't issue readahead for
 non-ENOENT errors from __filemap_get_folio
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 10:28:49PM -0800, Darrick J. Wong wrote:
> > Yes, it's really just a cast, and 'PTR_ERR(folio) == -ENOENT' actually
> > still works when folio isn't necessarily an error pointer.  But normally
> > it would be written as a pointer comparison as I suggested.
> 
> How does one know that a pointer is an error pointer?  Oughtn't there be
> some kind of obvious marker, or is IS_ERR the only tool we've got?

IS_ERR(ptr) is the interface to check is a pointer is an error pointer
or not.

PTR_ERR(ptr) == -EFOO checks if ptr is an error pointer for the errno
value -EFOO.




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
