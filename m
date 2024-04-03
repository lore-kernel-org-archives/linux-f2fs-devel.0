Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85EFCD1288
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 18:35:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rs5SX-00068V-Cc;
	Wed, 03 Apr 2024 18:35:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kent.overstreet@linux.dev>) id 1rs5SW-00068M-To
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 18:35:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KugM06W/s0lb++bW7levKHgpFLyEAtmCAECxADz00LA=; b=YkASSwdC17YpFJfdObYomHT/1U
 m5NhHeJ0J9cL13kNnrpsi0BVLiDciD4nBXblFgWQn+MaFe1KTRYdJPjw4zMfVR1NUu5LSSDwGrgY3
 cz3Uye9c6mW3COLrsaq/hBbY4jxIqcDjAC0KgnFKDGSLHe3Loe7OK68Exm1TuXB32CSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KugM06W/s0lb++bW7levKHgpFLyEAtmCAECxADz00LA=; b=Qi7lv5Xpl0NUUAAVxcVAZmkGOh
 tYARF3RH5eJWNGVQ2wd9KnFnm/n7oF+PLRWfqBemqvAiRpmwURMirm40l3wrJFbD5bhUj0SOycSfQ
 WPBf3XRCyOFskWYlMjOzIJ/KjsFxIXDF4UCfRkrf2F3OgreSR6VGsc9hC045N0tVjM5w=;
Received: from out-177.mta0.migadu.com ([91.218.175.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rs5SS-0003IW-Tu for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 18:35:41 +0000
Date: Wed, 3 Apr 2024 14:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1712168126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KugM06W/s0lb++bW7levKHgpFLyEAtmCAECxADz00LA=;
 b=O+mF5tSo+kQ3evl6evxwBacTiXzfRDinz7tasCBoCXvkVzg71Eg2Tj11aOOQOvAn2VtbKa
 4xDUzXt3vcUN1q4BynOenQTSxBZUR+PUrwJNN863OgeLxrPH8kAqph+irAR/22JqAk8WiC
 UUHnl3AUbkMRomaUH0xPDBYfDm7mIPM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Message-ID: <qf3rldn7sha5nbwz7iidkzb6secoyebwldgq56tfx4sunmthxo@qdap46g7lfsc>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <b9b795987a485afa0fdb8f0decc09405691d9320.1712126039.git.sweettea-kernel@dorminy.me>
 <Zg2LG1_2-ac1GlsG@bfoster>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zg2LG1_2-ac1GlsG@bfoster>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1rs5SS-0003IW-Tu
Subject: Re: [f2fs-dev] [PATCH v3 11/13] bcachefs: fiemap: return correct
 extent physical length
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
Cc: linux-bcachefs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 kernel-team@meta.com, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-btrfs@vger.kernel.org,
 linux-doc@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 03, 2024 at 01:00:11PM -0400, Brian Foster wrote:
> On Wed, Apr 03, 2024 at 03:22:52AM -0400, Sweet Tea Dorminy wrote:
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > ---
> >  fs/bcachefs/fs.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > index f830578a9cd1..d2793bae842d 100644
> > --- a/fs/bcachefs/fs.c
> > +++ b/fs/bcachefs/fs.c
> > @@ -913,15 +913,17 @@ static int bch2_fill_extent(struct bch_fs *c,
> >  			flags |= FIEMAP_EXTENT_SHARED;
> >  
> >  		bkey_for_each_ptr_decode(k.k, ptrs, p, entry) {
> > -			int flags2 = 0;
> > +			int flags2 = FIEMAP_EXTENT_HAS_PHYS_LEN;
> > +			u64 phys_len = k.k->size << 9;
> >  			u64 offset = p.ptr.offset;
> >  
> >  			if (p.ptr.unwritten)
> >  				flags2 |= FIEMAP_EXTENT_UNWRITTEN;
> >  
> > -			if (p.crc.compression_type)
> > +			if (p.crc.compression_type) {
> >  				flags2 |= FIEMAP_EXTENT_ENCODED;
> > -			else
> > +				phys_len = p.crc.compressed_size << 9;
> > +			} else
> >  				offset += p.crc.offset;
> >  
> >  			if ((offset & (block_sectors(c) - 1)) ||
> > @@ -931,7 +933,7 @@ static int bch2_fill_extent(struct bch_fs *c,
> >  			ret = fiemap_fill_next_extent(info,
> >  						bkey_start_offset(k.k) << 9,
> >  						offset << 9,
> > -						k.k->size << 9, 0,
> > +						k.k->size << 9, phys_len,
> >  						flags|flags2);
> >  			if (ret)
> >  				return ret;
> > @@ -941,14 +943,18 @@ static int bch2_fill_extent(struct bch_fs *c,
> >  	} else if (bkey_extent_is_inline_data(k.k)) {
> >  		return fiemap_fill_next_extent(info,
> >  					       bkey_start_offset(k.k) << 9,
> > -					       0, k.k->size << 9, 0,
> > +					       0, k.k->size << 9,
> > +					       bkey_inline_data_bytes(k.k),
> 
> Question for Kent perhaps, but what's the functional difference between
> bkey_inline_data_bytes() and k->size in this particular case?

Not much - k->size will correspond to the size of the original write -
that is, the writeback write from the pagecache. inline_data_bytes is
the amount of data that wasn't zeroes.

So inline_data_bytes is probably the right thing to use here.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
