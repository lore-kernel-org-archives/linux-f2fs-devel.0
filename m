Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B057D72341
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BtBgvxZUrHi9WRSE1oh3cf5mOrcoWK87Mhq0GwqtOTU=; b=iG91gpqz/9UQKTB93wvaUao6Zb
	KXskOr1s0jxecOJ8Y0fixXgzbkpFoy7sPxZ7N3BKTWoftpsfMI+0mQDatjZDEkmIGqIv5mlCUgCi4
	+SU65YxlFV67DYOOPQyv/njZPvxvC40iPFKFnaixSCrAnfwT5aeFZwO9JcejQ1AB5gUQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjBV6-0003D3-L6;
	Fri, 23 Jan 2026 07:22:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vjBV5-0003Cs-H9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hYORL+ulDQU1A0yZS6mdoF/USDIkZvUZDTcV50rz5/8=; b=h719z2Nov5cEShuw1v/KA3XFPW
 zzsiF/hRPgb0U7SeRuCWiyLjSuaI7MxKyK37HKojErAqU9scLE+HxXyd1Z8Mxwz2AR3lODlKVK4AA
 t6uRvNdtCCH9wOxCQXMOdjCzOEMSyMz/R/cuCpsCS3Crx8ERU8LlNVkfFMG/Lz4/qWoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hYORL+ulDQU1A0yZS6mdoF/USDIkZvUZDTcV50rz5/8=; b=ho4u7WlgxKLDW60qQE8DJI37PU
 UXeZDAaKQ7XXzPcztgey+XVEXaBje+rXyct3Ti4+jxf1B9sN/7RAgFSosPdd7cx5CvV17LDA7n2X7
 yKwyZgiU/mItKhu5npYKk5/m49UAUFShvgMG8M8EmeXs5w+LNJCHPt1N4QsbmHfqoDh4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjBUy-00032v-Si for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:22:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B790419AA;
 Fri, 23 Jan 2026 07:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631EBC4CEF1;
 Fri, 23 Jan 2026 07:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769152938;
 bh=xv7Ciia1o4TzkfhiJeMNZ7afzQQkd0wZmCmSkOnW3D8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ag+3xAAMAiEobo8tr0xQ+pzcrO/vVQSUK1Ag76ICSV8GT7q49niWT+pofKmzKsG8d
 Jw39Di1WR6hLI1vHcojDjdN67CQ0NZ4hT6qBh6VKNpuT+NwwIGeFCoVzI/Cw7PFD8H
 iDuF0Gf2+DPUBr/9WjkqNurr6hBOvGEbVBDUSzw/q/xGgutFraBC7WtwpfTz4uSSV3
 05dE5Th7Oj5wPPLqdrF+TxQtBTjE8Jpq8Hgi5LkNg9Eac+189i5VZfNF/Sxr89VkxQ
 HkR9HEZf+DjnbaULQQHgzisWBIN1hfRryZZ7oPJMvM5Tg+TZjXUU7ROBmPVPkNk1aQ
 DE5y1rbi3NWNg==
Date: Thu, 22 Jan 2026 23:22:17 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260123072217.GK5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-6-hch@lst.de>
 <20260122214227.GE5910@frogsfrogsfrogs>
 <20260123051429.GB24123@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123051429.GB24123@lst.de>
X-Headers-End: 1vjBUy-00032v-Si
Subject: Re: [f2fs-dev] [PATCH 05/11] fsverity: kick off hash readahead at
 data I/O submission time
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 23, 2026 at 06:14:29AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 01:42:27PM -0800, Darrick J. Wong wrote:
> > > +		if (first_folio) {
> > > +			if (ext4_need_verity(inode, folio->index))
> > > +				fsverity_readahead(folio, nr_pages);
> > 
> > Ok, so here ext4 is trying to read a data page into memory, so we
> > initiate readahead on the merkle tree block(s) for that data page.
> 
> Yes.
> 
> > > +	__fsverity_readahead(inode, vi, offset, last_index - index + 1);
> > 
> > I went "Huh??" here until I realized that this is the function that
> > reads merkle tree content on behalf of some ioctl, so this is merely
> > starting readahead for that.  Not sure anyone cares about throughput of
> > FS_VERITY_METADATA_TYPE_MERKLE_TREE but sure why not. 
> 
> It is trivial to provide and will make the ioctl read much faster.
> 
> > > +	const struct merkle_tree_params *params = &vi->tree_params;
> > > +	u64 start_hidx = data_start_pos >> params->log_blocksize;
> > > +	u64 end_hidx = (data_start_pos + ((nr_pages - 1) << PAGE_SHIFT)) >>
> > > +			params->log_blocksize;
> > 
> > I really wish these unit conversions had proper types and helpers
> > instead of this multiline to read shifting stuff.  Oh well, you didn't
> > write it this way, you're just slicing and dicing.
> 
> Agreed.  Just not feeling like turning everything totally upside down
> right now :)
> 
> > So if I read this correctly, we're initiating readahead of merkle tree
> > (leaf) data for the file data range starting at data_start_pos and
> > running for (nr_pages<<SHIFT) bytes?  Then going another level up in the
> > merkle tree and initiating readahead for the corresponding interior
> > nodes until we get to the root?
> 
> Yes.  That's a difference to the old code that just did readahead
> for the leaf nodes.

Cool!  In that case I think I understand what's going on here well
enough to say:
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
