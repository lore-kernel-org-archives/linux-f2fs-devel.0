Return-Path: <SRS0=kpNU=UR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1AC31E5B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:51:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2873205F4;
	Tue, 18 Jun 2019 17:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="BEt+1I2H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="eHwpKUHS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN+UHuS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2873205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hdIGZ-0002yi-3s; Tue, 18 Jun 2019 17:51:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hdIGY-0002yV-9r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Jun 2019 17:51:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dkzOcDvDPbAqqbSn4IkzRsM/a1UOBs/mqOL3uFyjONY=; b=BEt+1I2HZHk9s+yvtRc3BDfY63
 7HYhGE1tcTI+/BYLpoGsvRCyf0laty7wtdTeNmRKT37eCbaTa7FJwKXCoo4Un3fHbexoL8SnJPUhk
 jXVGE2IqyrF/S2JBI/HUw8snv48MASjECsXb6fb9oEqKnYNcZPvtT7M/KmEOdDXYwbpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dkzOcDvDPbAqqbSn4IkzRsM/a1UOBs/mqOL3uFyjONY=; b=eHwpKUHSMBStzJP3X1zAviZ7Qm
 YEc8k+IuENAf1FD1dzsrk5meK27ZyAC2m23iHtw+Ly4Nzl7/dip+2XW2Rw7kDUnx5Uehc4anpdPmW
 CyEQR9o/qB4A5cwtWUcxD5FzB1P3+SSQu7fLjRbFI4lQ5RYE86FLeV1EqIufv6Wv+OXk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hdIGU-00FrEA-N9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Jun 2019 17:51:29 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E84DC205F4;
 Tue, 18 Jun 2019 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560880280;
 bh=+JwMW+EfA+1KPkG7+F9JNJm/PdgIsMm+vsIk5VyMsXU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jN+UHuS7ftaLSzRz/uIHx1sk5q1R1x1AoYmkjyFeRGM23VC4+ycH6vhtDO6U3CLbJ
 QF9MEni6U1cDt7guNvx25VfpXPIjhqjCq5psE955shlVQKm+NnVxKNBEUDRsVxFZbD
 NijVFVXBjZzTi6Rjldw9aQ2M2ZOZ8+cRambf8Z+A=
Date: Tue, 18 Jun 2019 10:51:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20190618175117.GF184520@gmail.com>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-15-ebiggers@kernel.org>
 <20190615153112.GO6142@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190615153112.GO6142@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hdIGU-00FrEA-N9
Subject: Re: [f2fs-dev] [PATCH v4 14/16] ext4: add basic fs-verity support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jun 15, 2019 at 11:31:12AM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 08:52:03AM -0700, Eric Biggers wrote:
> > +/*
> > + * Format of ext4 verity xattr.  This points to the location of the verity
> > + * descriptor within the file data rather than containing it directly because
> > + * the verity descriptor *must* be encrypted when ext4 encryption is used.  But,
> > + * ext4 encryption does not encrypt xattrs.
> > + */
> > +struct fsverity_descriptor_location {
> > +	__le32 version;
> > +	__le32 size;
> > +	__le64 pos;
> > +};
> 
> What's the benefit of storing the location in an xattr as opposed to
> just keying it off the end of i_size, rounded up to next page size (or
> 64k) as I had suggested earlier?
> 
> Using an xattr burns xattr space, which is a limited resource, and it
> adds some additional code complexity.  Does the benefits outweigh the
> added complexity?
> 
> 						- Ted

It means that only the fs/verity/ support layer has to be aware of the format of
the fsverity_descriptor, and the filesystem can just treat it an as opaque blob.

Otherwise the filesystem would need to read the first 'sizeof(struct
fsverity_descriptor)' bytes and use those to calculate the size as
'sizeof(struct fsverity_descriptor) + le32_to_cpu(desc.sig_size)', then read the
rest.  Is this what you have in mind?

Alternatively the filesystem could prepend the fsverity_descriptor with its
size, similar to how in the v1 and v2 patchsets there was an fsverity_footer
appended to the fsverity_descriptor.  But an xattr seems a cleaner approach to
store a few bytes that don't need to be encrypted.

Putting the verity descriptor before the Merkle tree also means that we'd have
to pass the desc_size to ->begin_enable_verity(), ->read_merkle_tree_page(), and
->write_merkle_tree_block(), versus just passing the merkle_tree_size to
->end_enable_verity().  This would be easy, but it would still add a bit of
complexity in the fsverity_operations rather than reduce it.

It's also somewhat nice to have the version number in the xattr, in case we ever
introduce a new fs-verity format for ext4 or f2fs.

So to me, it doesn't seem like the other possible solutions are better.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
