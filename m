Return-Path: <SRS0=FOea=UO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66962C31E47
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Jun 2019 12:39:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B52A21841;
	Sat, 15 Jun 2019 12:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ft0C9YBg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fhYXG57w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B52A21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hc7yA-0007ce-6Z; Sat, 15 Jun 2019 12:39:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hc7y8-0007cG-Ju
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 12:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f9t7ABzoBYgFK8or7ei02Z6nMJDwIokIbGbyr/XE1Ug=; b=ft0C9YBgVabFdqoYhbJj5dxrsu
 rOKwWPWJGCh0tZEqvmytRZ7BS+b6SbbaT03AhspLNwXuk9spPhmw++PjXvJT8S2ws3w8gsrdiwx6k
 tXjKdK6RbaVr6M1oPoa6o7R90JV7hFyKTztio9aYvHO593Mqu17QUmgs2IxLRO7znYak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f9t7ABzoBYgFK8or7ei02Z6nMJDwIokIbGbyr/XE1Ug=; b=fhYXG57wvRNHicXxMOokRMjZ0B
 0Sb1ViXFGjaOkZiY7r/6ZZVVB6ad2oltyVtHgJ6CyqQc8RonT6x1WHvqVOqYeg63yjXhJQM0MLgHD
 jty+q7u6kptZ29ETvE/OGg0YSzgGo+8aIjVp/zDODYPaDhVU0OcrQW/lDEXp45Jy8Q+w=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hc7y5-00Euns-PI
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 Jun 2019 12:39:39 +0000
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com
 [74.87.88.165]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCdL7J031269
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Jun 2019 08:39:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id A4E1B420484; Sat, 15 Jun 2019 08:39:20 -0400 (EDT)
Date: Sat, 15 Jun 2019 08:39:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190615123920.GB6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-2-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hc7y5-00Euns-PI
Subject: Re: [f2fs-dev] [PATCH v4 01/16] fs-verity: add a documentation file
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
Message-ID: <20190615123920.Vl1Ag6_fnwnn4MWRnEZoCjxzXNPICJwvATlU9HXVK4A@z>

On Thu, Jun 06, 2019 at 08:51:50AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a documentation file for fs-verity, covering....
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


One minor design point below:

> +ext4 stores the verity metadata (Merkle tree and fsverity_descriptor)
> +past the end of the file, starting at the first page fully beyond
                                                   ^^^^
> +i_size.  This approach works because (a) verity files are readonly,
> +and (b) pages fully beyond i_size aren't visible to userspace but can
> +be read/written internally by ext4 with only some relatively small
> +changes to ext4.  This approach avoids having to depend on the
> +EA_INODE feature and on rearchitecturing ext4's xattr support to
> +support paging multi-gigabyte xattrs into memory, and to support
> +encrypting xattrs.  Note that the verity metadata *must* be encrypted
> +when the file is, since it contains hashes of the plaintext data.

If we ever want to support mounting, say, a file system with 4k blocks
and fsverity enabled on a architecture with a 16k or 64k page size,
then "page" in that first sentence will need to become "block".  At
the moment we only support fsverity when page size == block size, so
it's not an issue.

However, it's worth reflecting on what this means.  In order to
satisfy this requirement (from the mmap man page):

       A file is mapped in multiples of the page size.  For a file
       that is not a multiple of the page size, the remaining memory
       is zeroed when mapped...

we're going to have to special case how the last page gets mmaped.
The simplest way to do this will be to map in an anonymous page which
just has the blocks that are part of the data block copied in, and the
rest of the page can be zero'ed.

One thing we might consider doing just to make life much easier for
ourselves (should we ever want to support page size != block size ---
which I could imagine some folks like Chandan might find desirable) is
to specify that the fsverity metadata begins at an offset which begins
at i_size rounded up to the next 64k binary, which should handle all
current and future architectures' page sizes.

					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
