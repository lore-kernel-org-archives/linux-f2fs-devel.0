Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6941C83F11
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Aug 2023 13:56:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qacjX-000740-UY;
	Mon, 28 Aug 2023 13:56:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1qacjW-00073t-Ga
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 13:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PJ90BdA+8s3qX5y6y0ylNyYbaZuzc0FQ7tGvCVtNYPo=; b=RrjuYnGUvGyK4yBUIzeuPdJhc7
 hrj9B4k88UJjim6b3ANThPNLciu4UrEBrCKaZGuUbiepgV4iyG0al/PefDhUrWb8rqwcnd1c55aUt
 o+IRRVIXrusf2FPSvXLUe7tmHEr5vbml6lNM4sFiO/V6IgVgtfNOBUllKPkgIaeRQtBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PJ90BdA+8s3qX5y6y0ylNyYbaZuzc0FQ7tGvCVtNYPo=; b=deqhTn3QttpNu/pudoJQdMOtNS
 2vsiMlja1XHF3Ij+1XNsWuvITcTQqyMQObw2vZGSDOcwQ/VQdY+b482dn7NCvP6Gpihc8vTvhloWZ
 T74mYZJZl6RgC0tZ1xxd4YAviIPEl8Hx53pyUsCoxzyqcv5cyeX0TjCHh9ybZvsqbH70=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qacjV-000o19-4P for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 13:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PJ90BdA+8s3qX5y6y0ylNyYbaZuzc0FQ7tGvCVtNYPo=; b=AIKhRmdLChvBh1g3+s6EW46CKf
 MEbR4fH1pD3IzHz8haDpscNiqgIT1MwygtaGsg0/mJ22nTUE6hhMTmMaXMPK2UFki637fwtT5IR5e
 NpCkU9lVELANCdo3c4h02AUyKpTFJGcO2Yf8AdjY5H7ThMDg0k1adrBbq/dNvtWwWnE3JjBJPdXc+
 ZymQQTBtlnb8KZghvPVKQ32cCYcqGFspsFg4ARKclGMJ6roXU/fBsxC40PaksuQ+i2Lrun7tK4Cxw
 NodllbY3kB+LQ2ImYXlQY7RelX2cS+RJORhfHJhRq6XyXuEQGqfPM8/oHIO2kXnO0q6TWo/qN/Di3
 04k9P7lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qacj1-001ZTg-1Q; Mon, 28 Aug 2023 13:56:15 +0000
Date: Mon, 28 Aug 2023 14:56:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230828135615.GW3390869@ZenIV>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-4-hch@lst.de>
 <20230827194122.GA325446@ZenIV> <20230827214518.GU3390869@ZenIV>
 <20230828123259.GB11084@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230828123259.GB11084@lst.de>
X-Headers-End: 1qacjV-000o19-4P
Subject: Re: [f2fs-dev] [PATCH 03/12] filemap: update ki_pos in
 generic_perform_write
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 28, 2023 at 02:32:59PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 27, 2023 at 10:45:18PM +0100, Al Viro wrote:
> > IOW, I suspect that the right thing to do would be something along the lines
> > of
> 
> The idea looks sensible to me, but we'll also need to do it for the
> filemap_write_and_wait_range failure case.

Huh?  That's precisely where this patch is doing that...  That function
in mainline is
        if (unlikely(buffered_written < 0)) {
                if (direct_written)
                        return direct_written;
                return buffered_written;
        }

        /*
         * We need to ensure that the page cache pages are written to disk and
         * invalidated to preserve the expected O_DIRECT semantics.
         */
        err = filemap_write_and_wait_range(mapping, pos, end);
        if (err < 0) {
                /*
                 * We don't know how much we wrote, so just return the number of
                 * bytes which were direct-written
                 */
                if (direct_written)
                        return direct_written;
                return err;
        }
        invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
        return direct_written + buffered_written;

The first failure exit does not need any work - the caller had not bumped
->ki_pos; the second one (after that 'if (err < 0) {' line) does and that's
where the patch upthread adds iocb->ki_pos -= buffered_written.

Or am I completely misparsing what you've written?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
