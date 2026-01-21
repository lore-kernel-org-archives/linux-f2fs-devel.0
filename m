Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA17C44536
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Jan 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qugyrCl4+q/A4vL754mEXs/maN5Y/ZQYTYN2MKitHNw=; b=dy7XYG/z0TylDV0Yt78UgXuE9C
	0RRkiopOjySqsbyNfAOo1liruNuZcLwz8dYFGwA/AFeqJxv1KoLVImAic5tJabdaexWhAMABoAukh
	0wu9odW4QJyC5Fz/q6wMmjDhIaOjIkBbM3W9wKv8wuk32N8F4fNJK0bjW9K7YX+a96Zg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viZkA-0005I3-LM;
	Wed, 21 Jan 2026 15:03:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1viZk8-0005Hx-Mg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jan 2026 15:03:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DqHAqIOo0KRqteg6PWKdenv5VYX2rGWJWrWdPtH1CUc=; b=B9E7DHV+qIX9PbMMuzXe0xQfp5
 3I1YHzDkzETVm/gxiPUXR2Mm1IptmeH5BZawCkIbmovF2qwe5SFj2KJw7hKCsQoyoAQ/G9s9sq2r8
 1OE+LnHis/V7ADEeeUaqwdSFYBgwQm0Z5mNCoVmaq6708odz2oIky5s/Jsh5sT2qRftQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DqHAqIOo0KRqteg6PWKdenv5VYX2rGWJWrWdPtH1CUc=; b=gvgDhasWIGBwU6whdKbA9AwdRn
 TJ7g9L/hAHLu/M8R7Gkyq/U8uaiPrCnF/LEwV+ueSnLLtaqdYWmVSQJijilm57H+ilHIjr7s7Zen+
 yJxNwyKoO21oKbw8OhN8f4d0RDbeWTs6KXQC8sc78txYEWcQJtOuoGEagDP74wvtvNls=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viZk8-0003nf-2a for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jan 2026 15:03:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5C378227AB0; Wed, 21 Jan 2026 16:03:21 +0100 (CET)
Date: Wed, 21 Jan 2026 16:03:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20260121150320.GA14702@lst.de>
References: <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
 <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
 <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
 <20260119063349.GA643@lst.de> <20260119193242.GB13800@sol>
 <20260119195816.GA15583@frogsfrogsfrogs> <20260120073218.GA6757@lst.de>
 <5tse47xskuaofuworccgwhyftyymx5xj3mc6opwz7nfxa225u6@uvbk4gc2rktd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5tse47xskuaofuworccgwhyftyymx5xj3mc6opwz7nfxa225u6@uvbk4gc2rktd>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1viZk8-0003nf-2a
Subject: Re: [f2fs-dev] fsverity metadata offset,
 was: Re: [PATCH v2 0/23] fs-verity support for XFS with post EOF
 merkle tree
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, aalbersh@kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, david@fromorbit.com,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 20, 2026 at 12:44:19PM +0100, Andrey Albershteyn wrote:
> > > I'd leave the ondisk offset as-is, but change the pagecache offset to
> > > roundup(i_size_read(), mapping_max_folio_size_supported()) just to keep
> > > file data and fsverity metadata completely separate.
> > 
> > Can we find a way to do that in common code and make ext4 and f2fs do
> > the same?
> 
> hmm I don't see what else we could do except providing common offset
> and then use it to map blocks
> 
> loff_t fsverity_metadata_offset(struct inode *inode)
> {
> 	return roundup(i_size_read(), mapping_max_folio_size_supported());
> }

Something like that, yes.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
